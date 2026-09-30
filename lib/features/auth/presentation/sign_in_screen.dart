import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../data/auth_repository.dart';
import 'auth_messages.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _passwordCtrl;
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _usernameCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authProvider.notifier).signInWithPassword(
          username: _usernameCtrl.text,
          password: _passwordCtrl.text,
        );

    final auth = ref.read(authProvider);
    if (auth.user != null) {
      await ref.read(settingsProvider.notifier).update(
            (s) => s.copyWith(displayName: auth.user!.firstName),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final auth = ref.watch(authProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final errorText = auth.errorMessage == null
        ? null
        : authErrorText(l10n, auth.errorMessage);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [Color(0xFF0B1220), Color(0xFF111827)]
                : const [AppColors.primaryLight, AppColors.background],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.xxl),
                  Image.asset(
                    'assets/branding/lexora_mark.png',
                    height: 88,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  )
                      .animate()
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    l10n.signInTitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge,
                  ).animate().fadeIn(delay: 80.ms),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.signInSubtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ).animate().fadeIn(delay: 140.ms),
                  const SizedBox(height: AppSpacing.xxl),
                  LexoraCard(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _usernameCtrl,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.username],
                          decoration: InputDecoration(
                            labelText: l10n.username,
                            prefixIcon: const Icon(Icons.person_outline_rounded),
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? l10n.requiredField
                              : null,
                        ),
                        const SizedBox(height: AppSpacing.md),
                        TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscure,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _submit(),
                          autofillHints: const [AutofillHints.password],
                          decoration: InputDecoration(
                            labelText: l10n.password,
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                            ),
                          ),
                          validator: (v) => (v == null || v.isEmpty)
                              ? l10n.requiredField
                              : null,
                        ),
                        if (errorText != null) ...[
                          const SizedBox(height: AppSpacing.sm),
                          Text(
                            errorText,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ],
                        const SizedBox(height: AppSpacing.lg),
                        LexoraPrimaryButton(
                          label: l10n.signIn,
                          isLoading: auth.isLoading,
                          onPressed: _submit,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        TextButton(
                          onPressed: () => context.push('/register'),
                          child: Text(l10n.createAccount),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.06, end: 0),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.privacyNote,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
