import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/app_info.dart';
import '../../../core/constants/enums.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/services/account/account_deletion.dart';
import '../../../core/services/account/profile_image_store.dart';
import '../../../core/services/backup/lexora_backup.dart';
import '../../../core/services/backup/lexora_backup_store.dart';
import '../../../core/services/topics/topic_catalog_importer.dart';
import '../../../core/services/vocabulary/vocabulary_catalog_importer.dart';
import '../../../core/providers/settings_reminder_helpers.dart';
import '../../../core/services/notifications/reminder_scheduler.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/presentation/account_avatar.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final exported = await LexoraBackupStore(ref.read(appDatabaseProvider)).export();
    final user = ref.read(authProvider).user;
    final photo = await ProfileImageStore.resolve(user?.photoPath);
    final backup = photo == null || user?.photoPath == null
        ? exported
        : LexoraBackup(
            schemaVersion: exported.schemaVersion,
            exportedAt: exported.exportedAt,
            payload: {
              ...exported.payload,
              'profileImage': {
                'path': user!.photoPath,
                'bytes': base64Encode(await photo.readAsBytes()),
              },
            },
          );
    final dir = await getTemporaryDirectory();
    final file = File(
      p.join(dir.path, 'lexora-backup-${DateTime.now().millisecondsSinceEpoch}.json'),
    );
    await file.writeAsString(backup.encode());
    await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
    messenger.showSnackBar(SnackBar(content: Text(l10n.exportSuccess)));
  }

  Future<void> _import(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.confirmImport),
        content: Text(l10n.confirmImportMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.importData),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final picked = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
    if (picked == null) return;

    try {
      final raw = utf8.decode(await picked.readAsBytes());
      await LexoraBackupStore(ref.read(appDatabaseProvider)).importEncoded(raw);
      final image = LexoraBackup.decode(raw).payload['profileImage'];
      final account = ref.read(authProvider).user;
      if (image is Map && image['bytes'] is String && account != null) {
        final relative = await ProfileImageStore.saveBytes(
          base64Decode(image['bytes'] as String),
        );
        await ref.read(authProvider.notifier).updateProfile(
              username: account.username ?? '',
              displayName: account.displayName,
              email: account.email ?? '',
              photoPath: relative,
            );
      }
      final db = ref.read(appDatabaseProvider);
      await VocabularyCatalogImporter(db).importAssetIfNeeded();
      await TopicCatalogImporter(db).importAssetIfNeeded();
      messenger.showSnackBar(SnackBar(content: Text(l10n.importSuccess)));
    } on BackupException {
      messenger.showSnackBar(SnackBar(content: Text(l10n.unsupportedBackup)));
    } catch (_) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.importFailed)));
    }
  }

  Future<void> _openPage(BuildContext context, String url) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!opened) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.linkOpenFailed)));
    }
  }

  Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteAccount),
        content: Text(l10n.deleteAccountMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.deleteAccount),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    await AccountDeletion(ref.read(appDatabaseProvider)).deletePersonalData();
    await ref.read(settingsProvider.notifier).reset();
    await ReminderScheduler.instance.sync(ref.read(settingsProvider));
    await ref.read(authProvider.notifier).deleteAccount();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(settingsProvider);
    final auth = ref.watch(authProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPadding),
        children: [
          Text(l10n.account, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          LexoraCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: AccountAvatar(user: auth.user),
                  title: Text(
                    auth.user?.displayName.isNotEmpty == true
                        ? auth.user!.displayName
                        : settings.displayName,
                  ),
                  subtitle: Text(
                    auth.user?.email ??
                        auth.user?.username ??
                        l10n.localStorageOnly,
                  ),
                  trailing: const Icon(Icons.edit_outlined),
                  onTap: () => context.push('/account'),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.delete_outline,
                    color: theme.colorScheme.error,
                  ),
                  title: Text(
                    l10n.deleteAccount,
                    style: TextStyle(color: theme.colorScheme.error),
                  ),
                  onTap: () => _deleteAccount(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.categories, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          LexoraCard(
            onTap: () => context.push('/categories'),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.folder_outlined, color: AppColors.primary),
              title: Text(l10n.manageCategories),
              trailing: const Icon(Icons.chevron_right_rounded),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.language, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          LexoraCard(
            child: Column(
              children: [
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('English'),
                  value: 'en',
                  // ignore: deprecated_member_use
                  groupValue: settings.localeCode,
                  // ignore: deprecated_member_use
                  onChanged: (v) {
                    if (v != null) {
                      ref.read(settingsProvider.notifier).setLocale(v);
                    }
                  },
                ),
                RadioListTile<String>(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('العربية'),
                  value: 'ar',
                  // ignore: deprecated_member_use
                  groupValue: settings.localeCode,
                  // ignore: deprecated_member_use
                  onChanged: (v) {
                    if (v != null) {
                      ref.read(settingsProvider.notifier).setLocale(v);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.appearance, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          LexoraCard(
            child: Column(
              children: [
                for (final mode in AppThemeMode.values)
                  RadioListTile<AppThemeMode>(
                    contentPadding: EdgeInsets.zero,
                    title: Text(switch (mode) {
                      AppThemeMode.light => l10n.themeLight,
                      AppThemeMode.dark => l10n.themeDark,
                      AppThemeMode.system => l10n.themeSystem,
                    }),
                    value: mode,
                    // ignore: deprecated_member_use
                    groupValue: settings.themeMode,
                    // ignore: deprecated_member_use
                    onChanged: (v) {
                      if (v != null) {
                        ref.read(settingsProvider.notifier).setThemeMode(v);
                      }
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.pronunciation, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          LexoraCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.accent),
                  subtitle: Text(
                    settings.accent == PronunciationAccent.american
                        ? l10n.americanNatural
                        : l10n.britishNatural,
                  ),
                  trailing: DropdownButton<PronunciationAccent>(
                    value: settings.accent,
                    underline: const SizedBox.shrink(),
                    items: [
                      DropdownMenuItem(
                        value: PronunciationAccent.american,
                        child: Text(l10n.american),
                      ),
                      DropdownMenuItem(
                        value: PronunciationAccent.british,
                        child: Text(l10n.british),
                      ),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      ref
                          .read(settingsProvider.notifier)
                          .update((s) => s.copyWith(accent: v));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  child: Text(
                    l10n.clearerVoiceNote,
                    style: theme.textTheme.bodySmall,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.playbackSpeed),
                  trailing: DropdownButton<PlaybackSpeed>(
                    value: settings.playbackSpeed,
                    underline: const SizedBox.shrink(),
                    items: [
                      DropdownMenuItem(
                        value: PlaybackSpeed.normal,
                        child: Text(l10n.normalSpeed),
                      ),
                      DropdownMenuItem(
                        value: PlaybackSpeed.slow,
                        child: Text(l10n.slowSpeed),
                      ),
                    ],
                    onChanged: (v) {
                      if (v == null) return;
                      ref
                          .read(settingsProvider.notifier)
                          .update((s) => s.copyWith(playbackSpeed: v));
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.notifications, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          LexoraCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.dailyReminder),
                  value: settings.remindersEnabled,
                  onChanged: (v) async {
                    final messenger = ScaffoldMessenger.of(context);
                    await persistAndSyncReminders(
                      ref.read(settingsProvider.notifier),
                      settings,
                      (s) => s.copyWith(remindersEnabled: v),
                    );
                    final ok = !v ||
                        await ReminderScheduler.instance.requestPermission();
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                          !v
                              ? l10n.remindersDisabled
                              : ok
                                  ? l10n.remindersScheduled
                                  : l10n.notificationPermissionDenied,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  enabled: settings.remindersEnabled,
                  title: Text(l10n.remindersPerDay),
                  trailing: DropdownButton<int>(
                    value: settings.remindersPerDay.clamp(1, 8),
                    underline: const SizedBox.shrink(),
                    items: [1, 2, 3, 4, 5, 6, 8]
                        .map(
                          (n) => DropdownMenuItem(
                            value: n,
                            child: Text('$n'),
                          ),
                        )
                        .toList(),
                    onChanged: !settings.remindersEnabled
                        ? null
                        : (v) async {
                            if (v == null) return;
                            await persistAndSyncReminders(
                              ref.read(settingsProvider.notifier),
                              settings,
                              (s) => s.copyWith(remindersPerDay: v),
                            );
                          },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  enabled: settings.remindersEnabled,
                  title: Text(l10n.reminderType),
                  trailing: DropdownButton<ReminderType>(
                    value: settings.reminderType,
                    underline: const SizedBox.shrink(),
                    items: ReminderType.values
                        .map(
                          (t) => DropdownMenuItem(
                            value: t,
                            child: Text(reminderTypeLabel(l10n, t)),
                          ),
                        )
                        .toList(),
                    onChanged: !settings.remindersEnabled
                        ? null
                        : (v) async {
                            if (v == null) return;
                            await persistAndSyncReminders(
                              ref.read(settingsProvider.notifier),
                              settings,
                              (s) => s.copyWith(reminderType: v),
                            );
                          },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  enabled: settings.remindersEnabled,
                  title: Text(l10n.quietHoursStart),
                  trailing: Text(settings.quietHoursStart),
                  onTap: !settings.remindersEnabled
                      ? null
                      : () async {
                          final picked =
                              await pickHm(context, settings.quietHoursStart);
                          if (picked == null) return;
                          await persistAndSyncReminders(
                            ref.read(settingsProvider.notifier),
                            settings,
                            (s) => s.copyWith(
                              quietHoursStart: formatHm(picked),
                            ),
                          );
                        },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  enabled: settings.remindersEnabled,
                  title: Text(l10n.quietHoursEnd),
                  trailing: Text(settings.quietHoursEnd),
                  onTap: !settings.remindersEnabled
                      ? null
                      : () async {
                          final picked =
                              await pickHm(context, settings.quietHoursEnd);
                          if (picked == null) return;
                          await persistAndSyncReminders(
                            ref.read(settingsProvider.notifier),
                            settings,
                            (s) => s.copyWith(quietHoursEnd: formatHm(picked)),
                          );
                        },
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.data, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          LexoraCard(
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.localStorageOnly),
                  value: true,
                  onChanged: null,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.exportData),
                  trailing: const Icon(Icons.ios_share_rounded),
                  onTap: () => _export(context, ref),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.importData),
                  trailing: const Icon(Icons.file_open_outlined),
                  onTap: () => _import(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.legal, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          LexoraCard(
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.support),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => _openPage(context, AppInfo.supportUrl),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.termsOfUse),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => _openPage(context, AppInfo.termsOfUseUrl),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(l10n.privacyPolicy),
                  trailing: const Icon(Icons.open_in_new),
                  onTap: () => _openPage(context, AppInfo.privacyPolicyUrl),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(l10n.about, style: theme.textTheme.titleSmall),
          const SizedBox(height: 8),
          LexoraCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.appName, style: theme.textTheme.titleLarge),
                const SizedBox(height: 4),
                Text(l10n.version(AppInfo.version)),
                if (ref.watch(_developmentDatasetProvider).value ?? false) ...[
                  const SizedBox(height: 12),
                  Text(
                    l10n.developmentDatasetNote,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Text(
                  l10n.developedBy,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          OutlinedButton(
            onPressed: () => ref.read(authProvider.notifier).signOut(),
            child: Text(l10n.signOut),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

final _developmentDatasetProvider = FutureProvider<bool>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  final row = await (db.select(db.appStatistics)
        ..where((row) => row.key.equals(vocabularyCatalogVersionKey)))
      .getSingleOrNull();
  return row?.value.endsWith(':development') ?? false;
});
