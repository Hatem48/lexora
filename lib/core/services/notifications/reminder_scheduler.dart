import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../../constants/enums.dart';
import '../../providers/settings_provider.dart';

/// Schedules only after the learner turns reminders on and the OS allows them.
bool shouldScheduleReminders({
  required bool enabled,
  required bool permitted,
}) {
  return enabled && permitted;
}

/// Local reminder taps open the existing review screen.
String reminderPayload(ReminderType type) => '/review';

/// Schedules local daily learning reminders based on [AppSettings].
class ReminderScheduler {
  ReminderScheduler._();
  static final ReminderScheduler instance = ReminderScheduler._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'lexora_reminders';
  static const _channelName = 'Lexora Reminders';
  static const _baseNotificationId = 4200;

  bool _initialized = false;
  void Function(String? payload)? onOpened;
  String? _pendingPayload;

  void bind(void Function(String? payload) handler) {
    onOpened = handler;
    final pending = _pendingPayload;
    _pendingPayload = null;
    if (pending != null) handler(pending);
  }

  void _deliver(String? payload) {
    if (onOpened != null) {
      onOpened!(payload);
    } else if (payload != null) {
      _pendingPayload = payload;
    }
  }

  Future<void> initialize() async {
    if (_initialized) return;

    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (response) => _deliver(response.payload),
    );
    final launch = await _plugin.getNotificationAppLaunchDetails();
    if (launch?.didNotificationLaunchApp ?? false) {
      _deliver(launch?.notificationResponse?.payload);
    }

    if (!kIsWeb && Platform.isAndroid) {
      await _plugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              _channelId,
              _channelName,
              description: 'Daily English learning reminders',
              importance: Importance.defaultImportance,
            ),
          );
    }

    _initialized = true;
  }

  Future<bool> hasPermission() async {
    if (kIsWeb) return true;
    try {
      if (Platform.isAndroid) {
        final android = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        return await android?.areNotificationsEnabled() ?? false;
      }
      if (Platform.isIOS) {
        final ios = _plugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
        final status = await ios?.checkPermissions();
        return status?.isEnabled ?? false;
      }
    } catch (error) {
      if (kDebugMode) debugPrint('Notification permission check failed: $error');
    }
    return false;
  }

  Future<bool> requestPermission() async {
    if (kIsWeb) return true;
    try {
      if (Platform.isAndroid) {
        final android = _plugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        final granted = await android?.requestNotificationsPermission();
        return granted ?? false;
      }
      if (Platform.isIOS) {
        final ios = _plugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
        final granted = await ios?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        return granted ?? false;
      }
    } catch (error) {
      if (kDebugMode) debugPrint('Notification permission request failed: $error');
    }
    return false;
  }

  Future<void> sync(AppSettings settings) async {
    await initialize();
    await _plugin.cancelAll();

    if (!shouldScheduleReminders(
      enabled: settings.remindersEnabled,
      permitted: await hasPermission(),
    )) {
      return;
    }

    final slots = _reminderSlots(
      count: settings.remindersPerDay.clamp(1, 8),
      quietStart: _parseHm(settings.quietHoursStart),
      quietEnd: _parseHm(settings.quietHoursEnd),
    );

    final copy = _copyForType(settings.reminderType);
    final payload = reminderPayload(settings.reminderType);
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: 'Daily English learning reminders',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
      iOS: DarwinNotificationDetails(),
    );

    for (var i = 0; i < slots.length; i++) {
      final when = _nextOccurrence(slots[i]);
      try {
        await _plugin.zonedSchedule(
          id: _baseNotificationId + i,
          title: copy.$1,
          body: copy.$2,
          scheduledDate: when,
          notificationDetails: details,
          androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.time,
          payload: payload,
        );
      } catch (e) {
        if (kDebugMode) {
          debugPrint('Reminder schedule failed: $e');
        }
      }
    }
  }

  (String, String) _copyForType(ReminderType type) {
    return switch (type) {
      ReminderType.words => (
          'Lexora · Words',
          'Time for a quick vocabulary review.',
        ),
      ReminderType.sentences => (
          'Lexora · Sentences',
          'Practice a few sentences to lock them in.',
        ),
      ReminderType.dueReviews => (
          'Lexora · Reviews due',
          'You have items waiting in your review queue.',
        ),
      ReminderType.mixed => (
          'Lexora',
          'Keep your English streak going — open Lexora.',
        ),
    };
  }

  /// Evenly space [count] reminders across waking hours, skipping quiet hours.
  List<(int hour, int minute)> _reminderSlots({
    required int count,
    required (int, int) quietStart,
    required (int, int) quietEnd,
  }) {
    final wakeMinutes = <int>[];
    for (var m = 0; m < 24 * 60; m += 30) {
      if (!_inQuietHours(m, quietStart, quietEnd)) {
        wakeMinutes.add(m);
      }
    }
    if (wakeMinutes.isEmpty) {
      return [(9, 0), (13, 0), (18, 0), (20, 0)].take(count).toList();
    }

    final slots = <(int, int)>[];
    for (var i = 0; i < count; i++) {
      final idx = ((i + 0.5) * wakeMinutes.length / count)
          .floor()
          .clamp(0, wakeMinutes.length - 1);
      final total = wakeMinutes[idx];
      slots.add((total ~/ 60, total % 60));
    }
    return slots;
  }

  bool _inQuietHours(
    int minuteOfDay,
    (int, int) start,
    (int, int) end,
  ) {
    final startM = start.$1 * 60 + start.$2;
    final endM = end.$1 * 60 + end.$2;
    if (startM == endM) return false;
    if (startM < endM) {
      return minuteOfDay >= startM && minuteOfDay < endM;
    }
    return minuteOfDay >= startM || minuteOfDay < endM;
  }

  (int, int) _parseHm(String value) {
    final parts = value.split(':');
    if (parts.length < 2) return (22, 0);
    return (
      int.tryParse(parts[0])?.clamp(0, 23) ?? 22,
      int.tryParse(parts[1])?.clamp(0, 59) ?? 0,
    );
  }

  tz.TZDateTime _nextOccurrence((int hour, int minute) slot) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      slot.$1,
      slot.$2,
    );
    if (!scheduled.isAfter(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
