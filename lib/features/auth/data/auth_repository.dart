import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

final _usernamePattern = RegExp(r'^[a-z0-9._]{3,32}$');

String normalizeUsername(String value) => value.trim().toLowerCase();

/// Returns an error code, or null when the value can be stored.
String? validateUsername(String value) {
  if (!_usernamePattern.hasMatch(normalizeUsername(value))) {
    return 'username_invalid';
  }
  return null;
}

String? validatePassword(String value) {
  if (value.length < 6) return 'password_short';
  return null;
}

String? validateDisplayName(String value) {
  if (value.trim().isEmpty) return 'name_required';
  return null;
}

String? validateEmail(String value) {
  final email = value.trim();
  if (email.isEmpty) return null;
  final at = email.indexOf('@');
  if (at <= 0 || !email.substring(at + 1).contains('.') || email.contains(' ')) {
    return 'email_invalid';
  }
  return null;
}

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.displayName,
    this.email,
    this.photoPath,
    this.provider = 'password',
    this.username,
  });

  final String id;
  final String displayName;
  final String? email;
  final String? photoPath;
  final String provider;
  final String? username;

  String get firstName {
    final parts = displayName.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return username ?? displayName;
    }
    return parts.first;
  }

  String get avatarLetter {
    final source = displayName.trim().isNotEmpty
        ? displayName.trim()
        : (username ?? '').trim();
    if (source.isEmpty) return '?';
    return source[0].toUpperCase();
  }

  @override
  List<Object?> get props =>
      [id, displayName, email, photoPath, provider, username];
}

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthState extends Equatable {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.errorMessage,
    this.isLoading = false,
  });

  final AuthStatus status;
  final AuthUser? user;
  final String? errorMessage;
  final bool isLoading;

  AuthState copyWith({
    AuthStatus? status,
    AuthUser? user,
    String? errorMessage,
    bool? isLoading,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage, isLoading];
}

class AuthException implements Exception {
  AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

class _LocalAccount {
  const _LocalAccount({
    required this.id,
    required this.username,
    required this.password,
    required this.displayName,
    required this.email,
    required this.photoPath,
  });

  final String id;
  final String username;
  final String password;
  final String displayName;
  final String email;
  final String photoPath;

  AuthUser toUser() {
    return AuthUser(
      id: id,
      displayName: displayName,
      email: email.isEmpty ? null : email,
      photoPath: photoPath.isEmpty ? null : photoPath,
      username: username,
    );
  }

  Map<String, String> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'displayName': displayName,
        'email': email,
        'photoPath': photoPath,
      };

  factory _LocalAccount.fromJson(Map<String, dynamic> json) {
    return _LocalAccount(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
      password: json['password'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      photoPath: json['photoPath'] as String? ?? '',
    );
  }
}

abstract class AuthRepository {
  Future<AuthUser?> currentUser();
  Future<AuthUser> signInWithPassword({
    required String username,
    required String password,
  });
  Future<AuthUser> register({
    required String username,
    required String password,
    required String displayName,
    required String email,
  });
  Future<AuthUser> updateProfile({
    required String username,
    required String displayName,
    required String email,
    required String photoPath,
  });
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> signOut();
  Future<void> deleteAccount();
}

class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const _accountKey = 'lexora_local_account';
  static const _sessionKey = 'lexora_auth_session';
  final _uuid = const Uuid();

  Future<_LocalAccount?> _readAccount() async {
    final raw = await _storage.read(key: _accountKey);
    if (raw == null || raw.isEmpty) return null;
    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) return null;
      final account = _LocalAccount.fromJson(json);
      if (account.id.isEmpty || account.username.isEmpty) return null;
      return account;
    } catch (_) {
      return null;
    }
  }

  Future<void> _writeAccount(_LocalAccount account) {
    return _storage.write(key: _accountKey, value: jsonEncode(account.toJson()));
  }

  Future<AuthUser> _openSession(_LocalAccount account) async {
    await _writeAccount(account);
    await _storage.write(key: _sessionKey, value: account.id);
    return account.toUser();
  }

  @override
  Future<AuthUser?> currentUser() async {
    final session = await _storage.read(key: _sessionKey);
    final account = await _readAccount();
    if (session == null || session.isEmpty || account == null || account.id != session) {
      if (session != null) await _storage.delete(key: _sessionKey);
      return null;
    }
    return account.toUser();
  }

  @override
  Future<AuthUser> register({
    required String username,
    required String password,
    required String displayName,
    required String email,
  }) async {
    if (await _readAccount() != null) {
      throw AuthException('account_exists');
    }
    final usernameError = validateUsername(username);
    if (usernameError != null) throw AuthException(usernameError);
    final passwordError = validatePassword(password);
    if (passwordError != null) throw AuthException(passwordError);
    final nameError = validateDisplayName(displayName);
    if (nameError != null) throw AuthException(nameError);
    final emailError = validateEmail(email);
    if (emailError != null) throw AuthException(emailError);

    return _openSession(
      _LocalAccount(
        id: _uuid.v4(),
        username: normalizeUsername(username),
        password: password,
        displayName: displayName.trim(),
        email: email.trim(),
        photoPath: '',
      ),
    );
  }

  @override
  Future<AuthUser> signInWithPassword({
    required String username,
    required String password,
  }) async {
    final account = await _readAccount();
    final user = normalizeUsername(username);
    if (account == null || account.username != user || account.password != password) {
      throw AuthException('invalid_credentials');
    }
    return _openSession(account);
  }

  @override
  Future<AuthUser> updateProfile({
    required String username,
    required String displayName,
    required String email,
    required String photoPath,
  }) async {
    final account = await _readAccount();
    if (account == null) throw AuthException('invalid_credentials');
    final usernameError = validateUsername(username);
    if (usernameError != null) throw AuthException(usernameError);
    final nameError = validateDisplayName(displayName);
    if (nameError != null) throw AuthException(nameError);
    final emailError = validateEmail(email);
    if (emailError != null) throw AuthException(emailError);

    final updated = _LocalAccount(
      id: account.id,
      username: normalizeUsername(username),
      password: account.password,
      displayName: displayName.trim(),
      email: email.trim(),
      photoPath: photoPath,
    );
    await _writeAccount(updated);
    return updated.toUser();
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final account = await _readAccount();
    if (account == null || account.password != currentPassword) {
      throw AuthException('wrong_password');
    }
    final passwordError = validatePassword(newPassword);
    if (passwordError != null) throw AuthException(passwordError);
    await _writeAccount(
      _LocalAccount(
        id: account.id,
        username: account.username,
        password: newPassword,
        displayName: account.displayName,
        email: account.email,
        photoPath: account.photoPath,
      ),
    );
  }

  @override
  Future<void> signOut() => _storage.delete(key: _sessionKey);

  @override
  Future<void> deleteAccount() async {
    await _storage.delete(key: _accountKey);
    await _storage.delete(key: _sessionKey);
  }
}

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() {
    _bootstrap();
    return const AuthState();
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> _bootstrap() async {
    final user = await _repo.currentUser();
    state = AuthState(
      status:
          user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated,
      user: user,
    );
  }

  Future<void> signInWithPassword({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repo.signInWithPassword(
        username: username,
        password: password,
      );
      state = AuthState(status: AuthStatus.authenticated, user: user);
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        status: AuthStatus.unauthenticated,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> register({
    required String username,
    required String password,
    required String displayName,
    required String email,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repo.register(
        username: username,
        password: password,
        displayName: displayName,
        email: email,
      );
      state = AuthState(status: AuthStatus.authenticated, user: user);
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        status: AuthStatus.unauthenticated,
        errorMessage: e.message,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        status: AuthStatus.unauthenticated,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> updateProfile({
    required String username,
    required String displayName,
    required String email,
    required String photoPath,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final user = await _repo.updateProfile(
        username: username,
        displayName: displayName,
        email: email,
        photoPath: photoPath,
      );
      state = AuthState(status: AuthStatus.authenticated, user: user);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      state = state.copyWith(isLoading: false, clearError: true);
    } on AuthException catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.message);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  void reportError(String message) {
    state = state.copyWith(isLoading: false, errorMessage: message);
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<void> deleteAccount() async {
    await _repo.deleteAccount();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => LocalAuthRepository(),
);

final authProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
