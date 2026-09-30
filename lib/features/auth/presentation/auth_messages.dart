import 'package:lexora/l10n/app_localizations.dart';

String authErrorText(AppLocalizations l10n, String? code) {
  return switch (code) {
    null || '' => '',
    'invalid_credentials' => l10n.invalidCredentials,
    'account_exists' => l10n.accountExists,
    'username_invalid' => l10n.usernameInvalid,
    'password_short' => l10n.passwordShort,
    'name_required' => l10n.nameRequired,
    'email_invalid' => l10n.emailInvalid,
    'wrong_password' => l10n.wrongPassword,
    'password_mismatch' => l10n.passwordMismatch,
    _ => code,
  };
}
