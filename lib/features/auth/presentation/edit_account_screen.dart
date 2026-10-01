import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/services/account/profile_image_store.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../data/auth_repository.dart';
import 'account_avatar.dart';
import 'auth_messages.dart';

class EditAccountScreen extends ConsumerStatefulWidget {
  const EditAccountScreen({super.key});

  @override
  ConsumerState<EditAccountScreen> createState() => _EditAccountScreenState();
}

class _EditAccountScreenState extends ConsumerState<EditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _emailCtrl;
  final _currentPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();
  Uint8List? _newPhoto;
  bool _removePhoto = false;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;
    _nameCtrl = TextEditingController(text: user?.displayName ?? '');
    _usernameCtrl = TextEditingController(text: user?.username ?? '');
    _emailCtrl = TextEditingController(text: user?.email ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _currentPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  Future<bool> _allowPhotoLibrary() async {
    var status = await Permission.photos.status;
    if (status.isGranted || status.isLimited) return true;
    status = await Permission.photos.request();
    if (status.isGranted || status.isLimited) return true;
    if (status.isPermanentlyDenied || status.isRestricted) {
      await openAppSettings();
    }
    return false;
  }

  Future<void> _pickPhoto() async {
    final allowed = await _allowPhotoLibrary();
    if (!allowed) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).photoPermissionDenied),
        ),
      );
      return;
    }

    final picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
      maxWidth: 1200,
    );
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    if (!mounted) return;
    setState(() {
      _newPhoto = bytes;
      _removePhoto = false;
    });
  }

  Future<String> _storedPhotoPath() async {
    final current = ref.read(authProvider).user?.photoPath ?? '';
    if (_removePhoto) {
      await _deleteStoredPhotos();
      return '';
    }
    final bytes = _newPhoto;
    if (bytes == null) return current;

    await _deleteStoredPhotos();
    return ProfileImageStore.saveBytes(bytes);
  }

  Future<void> _deleteStoredPhotos() async {
    final current = ref.read(authProvider).user?.photoPath;
    await ProfileImageStore.deleteStored(current);
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    final photoPath = await _storedPhotoPath();
    await ref.read(authProvider.notifier).updateProfile(
          username: _usernameCtrl.text,
          displayName: _nameCtrl.text,
          email: _emailCtrl.text,
          photoPath: photoPath,
        );
    final auth = ref.read(authProvider);
    if (auth.errorMessage != null || !mounted) return;
    await ref.read(settingsProvider.notifier).update(
          (s) => s.copyWith(displayName: auth.user?.firstName ?? ''),
        );
    if (!mounted) return;
    setState(() => _newPhoto = null);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).profileSaved)),
    );
  }

  Future<void> _changePassword() async {
    if (!_passwordKey.currentState!.validate()) return;
    if (_newPasswordCtrl.text != _confirmPasswordCtrl.text) {
      ref.read(authProvider.notifier).reportError('password_mismatch');
      return;
    }
    await ref.read(authProvider.notifier).changePassword(
          currentPassword: _currentPasswordCtrl.text,
          newPassword: _newPasswordCtrl.text,
        );
    final error = ref.read(authProvider).errorMessage;
    if (error != null || !mounted) return;
    _currentPasswordCtrl.clear();
    _newPasswordCtrl.clear();
    _confirmPasswordCtrl.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).passwordChanged)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authProvider);
    final theme = Theme.of(context);
    final errorText = auth.errorMessage == null
        ? null
        : authErrorText(l10n, auth.errorMessage);
    final previewPath = _removePhoto ? '' : null;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.editAccount)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          Center(
            child: _newPhoto == null
                ? AccountAvatar(
                    user: auth.user,
                    radius: 48,
                    previewPath: previewPath,
                  )
                : CircleAvatar(
                    radius: 48,
                    backgroundImage: MemoryImage(_newPhoto!),
                  ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: _pickPhoto,
                child: Text(l10n.choosePhoto),
              ),
              TextButton(
                onPressed: () => setState(() {
                  _newPhoto = null;
                  _removePhoto = true;
                }),
                child: Text(l10n.removePhoto),
              ),
            ],
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameCtrl,
                  decoration: InputDecoration(labelText: l10n.displayName),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? l10n.nameRequired : null,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _usernameCtrl,
                  decoration: InputDecoration(labelText: l10n.username),
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? l10n.requiredField
                      : null,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: l10n.email,
                    hintText: l10n.optional,
                  ),
                ),
              ],
            ),
          ),
          if (errorText != null && errorText.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              errorText,
              style: theme.textTheme.bodySmall?.copyWith(color: AppColors.error),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          LexoraPrimaryButton(
            label: l10n.save,
            isLoading: auth.isLoading,
            onPressed: _saveProfile,
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(l10n.changePassword, style: theme.textTheme.titleSmall),
          const SizedBox(height: AppSpacing.sm),
          Form(
            key: _passwordKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _currentPasswordCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(
                    labelText: l10n.currentPassword,
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => _obscure = !_obscure),
                      icon: Icon(
                        _obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? l10n.requiredField : null,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _newPasswordCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(labelText: l10n.newPassword),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? l10n.requiredField : null,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _confirmPasswordCtrl,
                  obscureText: _obscure,
                  decoration: InputDecoration(labelText: l10n.confirmPassword),
                  validator: (v) {
                    if (v == null || v.isEmpty) return l10n.requiredField;
                    if (v != _newPasswordCtrl.text) return l10n.passwordMismatch;
                    return null;
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton(
            onPressed: auth.isLoading ? null : _changePassword,
            child: Text(l10n.changePassword),
          ),
        ],
      ),
    );
  }
}
