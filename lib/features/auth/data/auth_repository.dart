import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Default local preview credentials.
abstract final class DemoCredentials {
  static const username = 'hatem';
  static const password = '123456';
  static const displayName = 'Hatem Husam';
}

class AuthUser extends Equatable {
  const AuthUser({
    required this.id,
    required this.displayName,
    this.email,
    this.photoUrl,
    this.provider = 'password',
    this.username,
  });

  final String id;
  final String displayName;
  final String? email;
  final String? photoUrl;
  final String provider;
  final String? username;

  String get firstName {
    final parts = displayName.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? displayName : parts.first;
  }

  @override
  List<Object?> get props =>
      [id, displayName, email, photoUrl, provider, username];
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

abstract class AuthRepository {
  Future<AuthUser?> currentUser();
  Future<AuthUser> signInWithPassword({
    required String username,
    required String password,
  });
  Future<void> signOut();
}

class LocalAuthRepository implements AuthRepository {
  LocalAuthRepository({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const _sessionKey = 'lexora_auth_session';

  @override
  Future<AuthUser?> currentUser() async {
    final raw = await _storage.read(key: _sessionKey);
    if (raw == null || raw.isEmpty) return null;
    final parts = raw.split('|');
    if (parts.length < 3) return null;
    return AuthUser(
      id: parts[0],
      displayName: parts[1],
      email: parts[2].isEmpty ? null : parts[2],
      provider: parts.length > 3 ? parts[3] : 'password',
      username: parts.length > 4 ? parts[4] : DemoCredentials.username,
    );
  }

  Future<AuthUser> _persist(AuthUser user) async {
    await _storage.write(
      key: _sessionKey,
      value:
          '${user.id}|${user.displayName}|${user.email ?? ''}|${user.provider}|${user.username ?? ''}',
    );
    return user;
  }

  @override
  Future<AuthUser> signInWithPassword({
    required String username,
    required String password,
  }) async {
    final user = username.trim().toLowerCase();
    final pass = password.trim();

    if (user == DemoCredentials.username && pass == DemoCredentials.password) {
      return _persist(
        const AuthUser(
          id: 'local-hatem',
          displayName: DemoCredentials.displayName,
          email: 'hatem@lexora.app',
          provider: 'password',
          username: DemoCredentials.username,
        ),
      );
    }

    throw AuthException('invalid_credentials');
  }

  @override
  Future<void> signOut() => _storage.delete(key: _sessionKey);
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

  Future<void> signOut() async {
    await _repo.signOut();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => LocalAuthRepository(),
);

final authProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);
