/// Linguistic form slots. Values stay empty until a licensed source
/// provides them. Nothing here inflects a word.
class WordFormSlots {
  const WordFormSlots({
    this.base = const [],
    this.plural = const [],
    this.comparative = const [],
    this.superlative = const [],
    this.thirdPersonSingular = const [],
    this.pastSimple = const [],
    this.pastParticiple = const [],
    this.presentParticiple = const [],
  });

  final List<String> base;
  final List<String> plural;
  final List<String> comparative;
  final List<String> superlative;
  final List<String> thirdPersonSingular;
  final List<String> pastSimple;
  final List<String> pastParticiple;
  final List<String> presentParticiple;

  bool get hasAny =>
      base.isNotEmpty ||
      plural.isNotEmpty ||
      comparative.isNotEmpty ||
      superlative.isNotEmpty ||
      thirdPersonSingular.isNotEmpty ||
      pastSimple.isNotEmpty ||
      pastParticiple.isNotEmpty ||
      presentParticiple.isNotEmpty;

  /// Known surfaces from the catalog, excluding the lemma itself.
  /// Part of speech decides which slot can hold them later. With no
  /// inflection source, every slot stays empty.
  factory WordFormSlots.fromCatalog({
    required String partOfSpeech,
    required String lemma,
    required List<String> surfaces,
  }) {
    final extras = [
      for (final surface in surfaces)
        if (surface.toLowerCase() != lemma.toLowerCase()) surface,
    ];
    if (extras.isEmpty) return const WordFormSlots();
    return switch (partOfSpeech) {
      'noun' => WordFormSlots(plural: extras),
      'adjective' => WordFormSlots(comparative: extras),
      'verb' => WordFormSlots(base: extras),
      _ => WordFormSlots(base: extras),
    };
  }
}
