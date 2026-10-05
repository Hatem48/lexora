import 'package:flutter/material.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../constants/enums.dart';
import '../providers/settings_provider.dart';
import '../services/notifications/reminder_scheduler.dart';

Future<bool> persistAndSyncReminders(
  SettingsController controller,
  AppSettings current,
  AppSettings Function(AppSettings current) transform,
) async {
  final next = transform(current);
  await controller.update((_) => next);
  if (!next.remindersEnabled) {
    await ReminderScheduler.instance.sync(next);
    return true;
  }
  final permitted = await ReminderScheduler.instance.requestPermission();
  if (permitted) {
    await ReminderScheduler.instance.sync(next);
  }
  return permitted;
}

String reminderTypeLabel(AppLocalizations l10n, ReminderType type) {
  return switch (type) {
    ReminderType.words => l10n.reminderWords,
    ReminderType.sentences => l10n.reminderSentences,
    ReminderType.mixed => l10n.reminderMixed,
    ReminderType.dueReviews => l10n.reminderDueReviews,
  };
}

Future<TimeOfDay?> pickHm(
  BuildContext context,
  String hm,
) async {
  final parsed = hm.split(':');
  final initial = TimeOfDay(
    hour: int.tryParse(parsed.first)?.clamp(0, 23) ?? 22,
    minute: parsed.length > 1
        ? (int.tryParse(parsed[1])?.clamp(0, 59) ?? 0)
        : 0,
  );
  return showTimePicker(context: context, initialTime: initial);
}

String formatHm(TimeOfDay t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
