import 'package:lexora/l10n/app_localizations.dart';

String partOfSpeechLabel(AppLocalizations l10n, String storage) {
  return switch (storage) {
    'noun' => l10n.noun,
    'verb' => l10n.verb,
    'adjective' => l10n.adjective,
    'adverb' => l10n.adverb,
    'pronoun' => l10n.pronoun,
    'preposition' => l10n.preposition,
    'conjunction' => l10n.conjunction,
    'interjection' => l10n.interjection,
    'phrase' => l10n.phrase,
    _ => l10n.other,
  };
}
