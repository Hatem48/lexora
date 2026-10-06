import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers/settings_provider.dart';
import '../domain/art_journey_language.dart';

final artJourneyLanguageProvider =
    AsyncNotifierProvider<ArtJourneyLanguageController, String>(
  ArtJourneyLanguageController.new,
);

class ArtJourneyLanguageController extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(artJourneyLanguagePrefsKey);
    if (stored == 'en' || stored == 'ar') return stored!;
    final appLanguage = ref.watch(settingsProvider).localeCode;
    return artJourneyLanguageOrDefault(stored: null, appLanguage: appLanguage);
  }

  Future<void> select(String code) async {
    final next = code == 'ar' ? 'ar' : 'en';
    state = AsyncData(next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(artJourneyLanguagePrefsKey, next);
  }
}
