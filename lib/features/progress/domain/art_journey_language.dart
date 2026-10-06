const artJourneyLanguagePrefsKey = 'lexora_art_journey_language';

/// Saved `en` or `ar`, otherwise the current app language.
String artJourneyLanguageOrDefault({
  required String? stored,
  required String appLanguage,
}) {
  if (stored == 'en' || stored == 'ar') return stored!;
  return appLanguage == 'ar' ? 'ar' : 'en';
}
