import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/enums.dart';
import '../database/app_database.dart';

class AppSettings {
  const AppSettings({
    this.localeCode = 'en',
    this.themeMode = AppThemeMode.system,
    this.cefrLevel = CefrLevel.b1,
    this.accent = PronunciationAccent.american,
    this.playbackSpeed = PlaybackSpeed.normal,
    this.dailyGoal = 20,
    this.remindersEnabled = true,
    this.remindersPerDay = 4,
    this.reminderType = ReminderType.mixed,
    this.quietHoursStart = '22:00',
    this.quietHoursEnd = '07:00',
    this.onboardingCompleted = false,
    this.displayName = 'Hatem',
    this.seedDemoData = true,
  });

  final String localeCode;
  final AppThemeMode themeMode;
  final CefrLevel cefrLevel;
  final PronunciationAccent accent;
  final PlaybackSpeed playbackSpeed;
  final int dailyGoal;
  final bool remindersEnabled;
  final int remindersPerDay;
  final ReminderType reminderType;
  final String quietHoursStart;
  final String quietHoursEnd;
  final bool onboardingCompleted;
  final String displayName;
  final bool seedDemoData;

  Locale get locale => Locale(localeCode);
  bool get isRtl => localeCode == 'ar';

  ThemeMode get flutterThemeMode => switch (themeMode) {
        AppThemeMode.light => ThemeMode.light,
        AppThemeMode.dark => ThemeMode.dark,
        AppThemeMode.system => ThemeMode.system,
      };

  AppSettings copyWith({
    String? localeCode,
    AppThemeMode? themeMode,
    CefrLevel? cefrLevel,
    PronunciationAccent? accent,
    PlaybackSpeed? playbackSpeed,
    int? dailyGoal,
    bool? remindersEnabled,
    int? remindersPerDay,
    ReminderType? reminderType,
    String? quietHoursStart,
    String? quietHoursEnd,
    bool? onboardingCompleted,
    String? displayName,
    bool? seedDemoData,
  }) {
    return AppSettings(
      localeCode: localeCode ?? this.localeCode,
      themeMode: themeMode ?? this.themeMode,
      cefrLevel: cefrLevel ?? this.cefrLevel,
      accent: accent ?? this.accent,
      playbackSpeed: playbackSpeed ?? this.playbackSpeed,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
      remindersPerDay: remindersPerDay ?? this.remindersPerDay,
      reminderType: reminderType ?? this.reminderType,
      quietHoursStart: quietHoursStart ?? this.quietHoursStart,
      quietHoursEnd: quietHoursEnd ?? this.quietHoursEnd,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      displayName: displayName ?? this.displayName,
      seedDemoData: seedDemoData ?? this.seedDemoData,
    );
  }

  Map<String, dynamic> toJson() => {
        'localeCode': localeCode,
        'themeMode': themeMode.storageValue,
        'cefrLevel': cefrLevel.code,
        'accent': accent.storageValue,
        'playbackSpeed': playbackSpeed.name,
        'dailyGoal': dailyGoal,
        'remindersEnabled': remindersEnabled,
        'remindersPerDay': remindersPerDay,
        'reminderType': reminderType.storageValue,
        'quietHoursStart': quietHoursStart,
        'quietHoursEnd': quietHoursEnd,
        'onboardingCompleted': onboardingCompleted,
        'displayName': displayName,
        'seedDemoData': seedDemoData,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      localeCode: json['localeCode'] as String? ?? 'en',
      themeMode: AppThemeMode.values.firstWhere(
        (e) => e.storageValue == json['themeMode'],
        orElse: () => AppThemeMode.system,
      ),
      cefrLevel: CefrLevel.fromCode(json['cefrLevel'] as String? ?? 'B1'),
      accent: PronunciationAccent.values.firstWhere(
        (e) => e.storageValue == json['accent'],
        orElse: () => PronunciationAccent.american,
      ),
      playbackSpeed: PlaybackSpeed.values.firstWhere(
        (e) => e.name == json['playbackSpeed'],
        orElse: () => PlaybackSpeed.normal,
      ),
      dailyGoal: json['dailyGoal'] as int? ?? 20,
      remindersEnabled: json['remindersEnabled'] as bool? ?? true,
      remindersPerDay: json['remindersPerDay'] as int? ?? 4,
      reminderType: ReminderType.values.firstWhere(
        (e) => e.storageValue == json['reminderType'],
        orElse: () => ReminderType.mixed,
      ),
      quietHoursStart: json['quietHoursStart'] as String? ?? '22:00',
      quietHoursEnd: json['quietHoursEnd'] as String? ?? '07:00',
      onboardingCompleted: json['onboardingCompleted'] as bool? ?? false,
      displayName: json['displayName'] as String? ?? 'Hatem',
      seedDemoData: json['seedDemoData'] as bool? ?? true,
    );
  }
}

class SettingsController extends Notifier<AppSettings> {
  static const _prefsKey = 'lexora_settings_v1';

  @override
  AppSettings build() {
    _load();
    return const AppSettings();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_prefsKey);
    if (raw == null) return;
    try {
      state = AppSettings.fromJson(
        jsonDecode(raw) as Map<String, dynamic>,
      );
    } catch (_) {
      // Keep defaults if corrupted.
    }
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefsKey, jsonEncode(state.toJson()));

    // Mirror into Drift for backup/export compatibility.
    final db = ref.read(appDatabaseProvider);
    final now = DateTime.now();
    for (final entry in state.toJson().entries) {
      await db.into(db.userPreferences).insertOnConflictUpdate(
            UserPreferencesCompanion.insert(
              key: entry.key,
              value: entry.value.toString(),
              updatedAt: now,
            ),
          );
    }
  }

  Future<void> update(AppSettings Function(AppSettings) transform) async {
    state = transform(state);
    await _persist();
  }

  Future<void> setLocale(String code) =>
      update((s) => s.copyWith(localeCode: code));

  Future<void> setThemeMode(AppThemeMode mode) =>
      update((s) => s.copyWith(themeMode: mode));

  Future<void> completeOnboarding(AppSettings draft) async {
    state = draft.copyWith(onboardingCompleted: true);
    await _persist();
  }

  Future<void> reset() async {
    state = const AppSettings();
    await _persist();
  }
}

final settingsProvider =
    NotifierProvider<SettingsController, AppSettings>(SettingsController.new);
