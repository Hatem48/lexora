import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

final installedPackageProvider = FutureProvider<PackageInfo>((ref) {
  return PackageInfo.fromPlatform();
});

/// Marketing version plus the installed build number, such as 1.0.0 (14).
String formatInstalledVersion({
  required String version,
  required String buildNumber,
}) {
  final name = version.trim().isEmpty ? '—' : version.trim();
  final build = buildNumber.trim().isEmpty ? '—' : buildNumber.trim();
  return '$name ($build)';
}

class InstalledVersionText extends ConsumerWidget {
  const InstalledVersionText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final package = ref.watch(installedPackageProvider);
    return package.when(
      data: (info) => Text(
        l10n.version(
          formatInstalledVersion(
            version: info.version,
            buildNumber: info.buildNumber,
          ),
        ),
      ),
      loading: () => Text(l10n.version('…')),
      error: (_, _) => Text(l10n.version('—')),
    );
  }
}
