const cefrLevels = {'A1', 'A2', 'B1', 'B2', 'C1', 'C2'};

const sourceCefrJ = 'cefrj-1.5';
const sourceOctanove = 'octanove-c1c2-1.0';
const sourceNgsl = 'ngsl-1.2';
const sourceNgslSpoken = 'ngsl-spoken-1.2';
const sourceNawl = 'nawl-1.2';

const cefrFileName = 'cefrj-vocabulary-profile-1.5.csv';
const octanoveFileName = 'octanove-vocabulary-profile-c1c2-1.0.csv';
const ngslFileName = 'ngsl-1.2.csv';
const spokenFileName = 'ngsl-spoken-1.2.csv';
const nawlFileName = 'nawl-1.2.csv';
const formsFileName = 'vocabulary-forms.csv';
const topicMappingsFileName = 'vocabulary-topic-mappings.json';

String canonicalLemma(String raw) {
  return raw.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
}

String canonicalPos(String raw) {
  final key = raw
      .trim()
      .toLowerCase()
      .replaceAll('_', '-')
      .replaceAll(RegExp(r'\s+'), '-');
  return switch (key) {
    'n' || 'nn' || 'noun' => 'noun',
    'v' || 'vb' || 'verb' => 'verb',
    'j' || 'jj' || 'adj' || 'adjective' => 'adjective',
    'r' || 'rb' || 'adv' || 'adverb' => 'adverb',
    'pron' || 'pronoun' => 'pronoun',
    'prep' || 'preposition' => 'preposition',
    'conj' || 'conjunction' => 'conjunction',
    'det' || 'determiner' || 'article' => 'determiner',
    'int' || 'interjection' => 'interjection',
    'num' || 'number' || 'numeral' => 'number',
    'aux' ||
    'auxiliary' ||
    'modal' ||
    'be-verb' ||
    'do-verb' ||
    'have-verb' ||
    'modal-auxiliary' =>
      'auxiliary',
    _ => '',
  };
}

String entryIdFor(String lemma, String pos) {
  final slug = canonicalLemma(lemma)
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-+|-+$'), '');
  if (slug.isEmpty) {
    throw FormatException('Cannot build an id for "$lemma".');
  }
  return '$slug-$pos';
}

class LemmaPos {
  const LemmaPos(this.lemma, this.pos);

  final String lemma;
  final String pos;

  @override
  bool operator ==(Object other) =>
      other is LemmaPos && other.lemma == lemma && other.pos == pos;

  @override
  int get hashCode => Object.hash(lemma, pos);
}
