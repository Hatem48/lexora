import 'package:flutter/material.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/services/app_package_info.dart';
import '../domain/whats_new.dart';

Future<void> showWhatsNewIfNeeded(BuildContext context) async {
  final PackageInfo info;
  try {
    info = await PackageInfo.fromPlatform();
  } catch (_) {
    return;
  }
  final current = whatsNewIdentity(
    version: info.version,
    buildNumber: info.buildNumber,
  );
  final prefs = await SharedPreferences.getInstance();
  if (!shouldShowWhatsNew(seen: prefs.getString(whatsNewSeenKey), current: current)) {
    return;
  }
  if (!context.mounted) return;
  final l10n = AppLocalizations.of(context);
  await showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(l10n.whatsNewTitle),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.version(
                  formatInstalledVersion(
                    version: info.version,
                    buildNumber: info.buildNumber,
                  ),
                ),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.whatsNewThisVersion,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 6),
              Text(l10n.whatsNewCurrentBody),
              const SizedBox(height: 16),
              Text(
                l10n.whatsNewPreviousVersion,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 6),
              Text(l10n.whatsNewPreviousBody),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.done),
          ),
        ],
      );
    },
  );
  await prefs.setString(whatsNewSeenKey, current);
}
