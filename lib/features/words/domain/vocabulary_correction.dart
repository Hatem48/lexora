import 'dart:convert';
import 'dart:math' as math;

const vocabularyCorrectionVersionKey = 'vocabulary_correction_version';
const vocabularyCorrectionQueueKey = 'vocabulary_correction_queue';
const vocabularyCorrectionDecisionsKey = 'vocabulary_correction_decisions';

enum VocabularyReviewKind { spelling, content }

class CorrectionManifest {
  const CorrectionManifest({
    required this.version,
    required this.hints,
    required this.content,
  });

  final int version;
  final List<SpellingHint> hints;
  final List<ContentCorrection> content;

  factory CorrectionManifest.parse(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Correction manifest must be an object');
    }
    final version = decoded['version'];
    if (version is! int || version < 1) {
      throw const FormatException('Correction manifest version is missing');
    }
    return CorrectionManifest(
      version: version,
      hints: [
        for (final item in _maps(decoded['hints']))
          SpellingHint(
            written: normalizeLookup('${item['written'] ?? ''}'),
            lemmas: [
              for (final lemma in _strings(item['lemmas']))
                normalizeLookup(lemma),
            ],
          ),
      ],
      content: [
        for (final item in _maps(decoded['content']))
          ContentCorrection(
            lemma: normalizeLookup('${item['lemma'] ?? ''}'),
            meaningAr: '${item['meaningAr'] ?? ''}'.trim(),
            exampleEn: '${item['exampleEn'] ?? ''}'.trim(),
            exampleAr: '${item['exampleAr'] ?? ''}'.trim(),
          ),
      ],
    );
  }

  ContentCorrection? contentFor(String lemma) {
    final key = normalizeLookup(lemma);
    for (final item in content) {
      if (item.lemma == key && item.meaningAr.isNotEmpty) return item;
    }
    return null;
  }

  bool hintsLemma(String written, String lemma) => hintBoost(written, lemma) > 0;

  double hintBoost(String written, String lemma) {
    final word = normalizeLookup(written);
    final target = normalizeLookup(lemma);
    for (final hint in hints) {
      if (hint.written != word) continue;
      final index = hint.lemmas.indexOf(target);
      if (index < 0) continue;
      final span = hint.lemmas.length;
      return 0.22 * (span - index) / span;
    }
    return 0;
  }
}

class SpellingHint {
  const SpellingHint({required this.written, required this.lemmas});

  final String written;
  final List<String> lemmas;
}

class ContentCorrection {
  const ContentCorrection({
    required this.lemma,
    required this.meaningAr,
    required this.exampleEn,
    required this.exampleAr,
  });

  final String lemma;
  final String meaningAr;
  final String exampleEn;
  final String exampleAr;
}

class CatalogLexeme {
  const CatalogLexeme({
    required this.id,
    required this.lemma,
    required this.pos,
    required this.cefr,
    required this.arabic,
    required this.exampleEn,
  });

  final String id;
  final String lemma;
  final String pos;
  final String cefr;
  final String arabic;
  final String exampleEn;
}

class StoredUserWord {
  const StoredUserWord({
    required this.id,
    required this.personal,
    required this.word,
    required this.arabic,
    required this.exampleEn,
    required this.exampleAr,
  });

  final String id;
  final bool personal;
  final String word;
  final String arabic;
  final String exampleEn;
  final String exampleAr;

  String get subjectKey => personal ? 'word:$id' : 'vocab:$id';
}

class ReviewCandidate {
  const ReviewCandidate({
    required this.entryId,
    required this.lemma,
    required this.arabic,
    required this.exampleEn,
    required this.exampleAr,
    required this.pos,
    required this.cefr,
    required this.score,
  });

  final String entryId;
  final String lemma;
  final String arabic;
  final String exampleEn;
  final String exampleAr;
  final String pos;
  final String cefr;
  final double score;

  Map<String, Object?> toJson() => {
        'entryId': entryId,
        'lemma': lemma,
        'arabic': arabic,
        'exampleEn': exampleEn,
        'exampleAr': exampleAr,
        'pos': pos,
        'cefr': cefr,
        'score': score,
      };

  factory ReviewCandidate.fromJson(Map<String, dynamic> json) {
    return ReviewCandidate(
      entryId: '${json['entryId']}',
      lemma: '${json['lemma']}',
      arabic: '${json['arabic'] ?? ''}',
      exampleEn: '${json['exampleEn'] ?? ''}',
      exampleAr: '${json['exampleAr'] ?? ''}',
      pos: '${json['pos'] ?? ''}',
      cefr: '${json['cefr'] ?? ''}',
      score: (json['score'] as num?)?.toDouble() ?? 0,
    );
  }
}

class VocabularyReviewIssue {
  const VocabularyReviewIssue({
    required this.subjectKey,
    required this.wordId,
    required this.personal,
    required this.kind,
    required this.written,
    required this.currentArabic,
    required this.currentExampleEn,
    required this.currentExampleAr,
    required this.candidates,
    required this.signature,
  });

  final String subjectKey;
  final String wordId;
  final bool personal;
  final VocabularyReviewKind kind;
  final String written;
  final String currentArabic;
  final String currentExampleEn;
  final String currentExampleAr;
  final List<ReviewCandidate> candidates;
  final String signature;

  Map<String, Object?> toJson() => {
        'subjectKey': subjectKey,
        'wordId': wordId,
        'personal': personal,
        'kind': kind.name,
        'written': written,
        'currentArabic': currentArabic,
        'currentExampleEn': currentExampleEn,
        'currentExampleAr': currentExampleAr,
        'signature': signature,
        'candidates': [for (final item in candidates) item.toJson()],
      };

  factory VocabularyReviewIssue.fromJson(Map<String, dynamic> json) {
    final kindName = '${json['kind']}';
    return VocabularyReviewIssue(
      subjectKey: '${json['subjectKey']}',
      wordId: '${json['wordId']}',
      personal: json['personal'] == true,
      kind: kindName == 'content'
          ? VocabularyReviewKind.content
          : VocabularyReviewKind.spelling,
      written: '${json['written']}',
      currentArabic: '${json['currentArabic'] ?? ''}',
      currentExampleEn: '${json['currentExampleEn'] ?? ''}',
      currentExampleAr: '${json['currentExampleAr'] ?? ''}',
      signature: '${json['signature'] ?? ''}',
      candidates: [
        for (final item in _maps(json['candidates']))
          ReviewCandidate.fromJson(item),
      ],
    );
  }
}

class CorrectionDecision {
  const CorrectionDecision({
    required this.subjectKey,
    required this.action,
    required this.signature,
    required this.version,
  });

  final String subjectKey;
  final String action;
  final String signature;
  final int version;

  Map<String, Object?> toJson() => {
        'subjectKey': subjectKey,
        'action': action,
        'signature': signature,
        'version': version,
      };

  factory CorrectionDecision.fromJson(Map<String, dynamic> json) {
    return CorrectionDecision(
      subjectKey: '${json['subjectKey']}',
      action: '${json['action']}',
      signature: '${json['signature'] ?? ''}',
      version: (json['version'] as num?)?.toInt() ?? 0,
    );
  }
}

class CatalogLookup {
  CatalogLookup(List<CatalogLexeme> entries, {Map<String, String> forms = const {}})
      : _byKey = {},
        _buckets = {} {
    for (final entry in entries) {
      final key = normalizeLookup(entry.lemma);
      _byKey.putIfAbsent(key, () => []).add(entry);
      final length = key.length;
      _buckets.putIfAbsent(length, () => []).add(entry);
    }
    for (final form in forms.entries) {
      final key = normalizeLookup(form.key);
      for (final entry in entries) {
        if (entry.id != form.value) continue;
        final list = _byKey.putIfAbsent(key, () => []);
        if (list.every((item) => item.id != entry.id)) list.add(entry);
      }
    }
  }

  final Map<String, List<CatalogLexeme>> _byKey;
  final Map<int, List<CatalogLexeme>> _buckets;

  List<CatalogLexeme> exact(String word) =>
      _byKey[normalizeLookup(word)] ?? const [];

  Iterable<CatalogLexeme> near(String word) sync* {
    final key = normalizeLookup(word);
    for (var length = key.length - 2; length <= key.length + 2; length++) {
      if (length < 2) continue;
      final bucket = _buckets[length];
      if (bucket == null) continue;
      yield* bucket;
    }
  }
}

String normalizeLookup(String word) => word.trim().toLowerCase();

bool looksProtected(String word) {
  final trimmed = word.trim();
  if (trimmed.length < 2) return true;
  final letters = trimmed.replaceAll(RegExp('[^A-Za-z]'), '');
  if (letters.length >= 2 && letters == letters.toUpperCase()) return true;
  if (RegExp(r'[A-Z]').hasMatch(trimmed.substring(1))) return true;
  return false;
}

int editDistance(String left, String right, {int max = 2}) {
  if ((left.length - right.length).abs() > max) return max + 1;
  if (left == right) return 0;
  final previous = List<int>.generate(right.length + 1, (index) => index);
  final current = List<int>.filled(right.length + 1, 0);
  for (var i = 1; i <= left.length; i++) {
    current[0] = i;
    var rowBest = current[0];
    for (var j = 1; j <= right.length; j++) {
      final cost = left.codeUnitAt(i - 1) == right.codeUnitAt(j - 1) ? 0 : 1;
      current[j] = math.min(
        math.min(current[j - 1] + 1, previous[j] + 1),
        previous[j - 1] + cost,
      );
      if (current[j] < rowBest) rowBest = current[j];
    }
    if (rowBest > max) return max + 1;
    for (var j = 0; j <= right.length; j++) {
      previous[j] = current[j];
    }
  }
  return previous[right.length];
}

List<VocabularyReviewIssue> findVocabularyIssues({
  required List<StoredUserWord> words,
  required CatalogLookup catalog,
  required CorrectionManifest manifest,
}) {
  final issues = <VocabularyReviewIssue>[];
  for (final word in words) {
    final issue = _issueFor(word, catalog, manifest);
    if (issue != null) issues.add(issue);
  }
  return issues;
}

List<VocabularyReviewIssue> openVocabularyIssues({
  required List<VocabularyReviewIssue> issues,
  required List<CorrectionDecision> decisions,
}) {
  final byKey = {for (final item in decisions) item.subjectKey: item};
  return [
    for (final issue in issues)
      if (_stillOpen(issue, byKey[issue.subjectKey])) issue,
  ];
}

bool _stillOpen(VocabularyReviewIssue issue, CorrectionDecision? decision) {
  if (decision == null) return true;
  return decision.signature != issue.signature;
}

VocabularyReviewIssue? _issueFor(
  StoredUserWord word,
  CatalogLookup catalog,
  CorrectionManifest manifest,
) {
  final exact = catalog.exact(word.word);
  if (exact.isNotEmpty) {
    return _contentIssue(word, _bestEntry(exact, word.arabic), manifest);
  }
  if (!word.personal || looksProtected(word.word)) return null;
  final ranked = _rankSpelling(word, catalog, manifest);
  if (ranked.isEmpty) return null;
  final shown = ranked.take(2).toList();
  return VocabularyReviewIssue(
    subjectKey: word.subjectKey,
    wordId: word.id,
    personal: true,
    kind: VocabularyReviewKind.spelling,
    written: word.word,
    currentArabic: word.arabic,
    currentExampleEn: word.exampleEn,
    currentExampleAr: word.exampleAr,
    candidates: shown,
    signature: shown.map((item) => item.entryId).join('|'),
  );
}

VocabularyReviewIssue? _contentIssue(
  StoredUserWord word,
  CatalogLexeme entry,
  CorrectionManifest manifest,
) {
  final trusted = manifest.contentFor(entry.lemma);
  final meaning = trusted?.meaningAr ?? entry.arabic;
  final exampleEn = (trusted != null && trusted.exampleEn.isNotEmpty)
      ? trusted.exampleEn
      : entry.exampleEn;
  final exampleAr = trusted?.exampleAr ?? '';
  final meaningChanged = meaningDiffers(word.arabic, meaning);
  final exampleChanged = trusted != null && _exampleDiffers(word.exampleEn, exampleEn);
  if (!meaningChanged && !exampleChanged) return null;
  if (meaning.trim().isEmpty && exampleEn.trim().isEmpty) return null;
  final candidate = ReviewCandidate(
    entryId: entry.id,
    lemma: entry.lemma,
    arabic: meaning,
    exampleEn: exampleEn,
    exampleAr: exampleAr,
    pos: entry.pos,
    cefr: entry.cefr,
    score: 1,
  );
  return VocabularyReviewIssue(
    subjectKey: word.subjectKey,
    wordId: word.id,
    personal: word.personal,
    kind: VocabularyReviewKind.content,
    written: word.word,
    currentArabic: word.arabic,
    currentExampleEn: word.exampleEn,
    currentExampleAr: word.exampleAr,
    candidates: [candidate],
    signature: '${entry.id}|$meaning|$exampleEn',
  );
}

bool meaningDiffers(String user, String trusted) {
  final left = _arabicKey(user);
  final right = _arabicKey(trusted);
  if (left.isEmpty || right.isEmpty) return false;
  if (left == right || left.contains(right) || right.contains(left)) {
    return false;
  }
  return arabicOverlap(left, right) < 0.45;
}

bool _exampleDiffers(String user, String trusted) {
  final left = user.trim().toLowerCase();
  final right = trusted.trim().toLowerCase();
  if (left.isEmpty || right.isEmpty) return false;
  return left != right;
}

List<ReviewCandidate> _rankSpelling(
  StoredUserWord word,
  CatalogLookup catalog,
  CorrectionManifest manifest,
) {
  final written = normalizeLookup(word.word);
  if (written.length < 2) return const [];
  final scored = <ReviewCandidate>[];
  final seen = <String>{};
  for (final entry in catalog.near(written)) {
    if (!seen.add(entry.id)) continue;
    final lemma = normalizeLookup(entry.lemma);
    if (lemma == written) continue;
    final hinted = manifest.hintsLemma(written, lemma);
    final distance = editDistance(written, lemma, max: hinted ? 3 : 2);
    final limit = hinted ? 3 : 2;
    if (distance > limit) continue;
    final longest = math.max(written.length, lemma.length);
    final normalized = distance / longest;
    if (normalized > (hinted ? 0.75 : 0.5)) continue;
    final prefix = _sharedPrefix(written, lemma) / longest;
    final lengthScore = 1 - (written.length - lemma.length).abs() / longest;
    final overlap = arabicOverlap(word.arabic, entry.arabic);
    final score = (1 - normalized) * 0.42 +
        prefix * 0.18 +
        lengthScore * 0.08 +
        overlap * 0.28 +
        manifest.hintBoost(written, lemma);
    if (score < 0.5) continue;
    final trusted = manifest.contentFor(lemma);
    scored.add(
      ReviewCandidate(
        entryId: entry.id,
        lemma: entry.lemma,
        arabic: trusted?.meaningAr.isNotEmpty == true
            ? trusted!.meaningAr
            : entry.arabic,
        exampleEn: trusted != null && trusted.exampleEn.isNotEmpty
            ? trusted.exampleEn
            : entry.exampleEn,
        exampleAr: trusted?.exampleAr ?? '',
        pos: entry.pos,
        cefr: entry.cefr,
        score: score,
      ),
    );
  }
  final bestByLemma = <String, ReviewCandidate>{};
  for (final item in scored) {
    final key = normalizeLookup(item.lemma);
    final current = bestByLemma[key];
    if (current == null || item.score > current.score) {
      bestByLemma[key] = item;
    }
  }
  final unique = bestByLemma.values.toList();
  unique.sort((a, b) {
    final byScore = b.score.compareTo(a.score);
    if (byScore != 0) return byScore;
    return a.lemma.compareTo(b.lemma);
  });
  return unique;
}

CatalogLexeme _bestEntry(List<CatalogLexeme> entries, String arabic) {
  CatalogLexeme best = entries.first;
  var bestOverlap = arabicOverlap(arabic, best.arabic);
  for (final entry in entries.skip(1)) {
    final overlap = arabicOverlap(arabic, entry.arabic);
    if (overlap > bestOverlap) {
      best = entry;
      bestOverlap = overlap;
    }
  }
  return best;
}

double arabicOverlap(String user, String trusted) {
  final left = _arabicLetters(user);
  final right = _arabicLetters(trusted);
  if (left.isEmpty || right.isEmpty) return 0;
  final bag = <String, int>{};
  for (final char in right) {
    bag[char] = (bag[char] ?? 0) + 1;
  }
  var shared = 0;
  for (final char in left) {
    final count = bag[char] ?? 0;
    if (count == 0) continue;
    shared++;
    bag[char] = count - 1;
  }
  return shared / left.length;
}

int _sharedPrefix(String left, String right) {
  final limit = math.min(left.length, right.length);
  var index = 0;
  while (index < limit && left[index] == right[index]) {
    index++;
  }
  return index;
}

String _arabicKey(String value) => _arabicLetters(value).join();

List<String> _arabicLetters(String value) {
  final stripped = value.replaceAll(RegExp(r'[\u064B-\u0652]'), '');
  return [
    for (final rune in stripped.runes)
      if (rune >= 0x0621 && rune <= 0x064A) String.fromCharCode(rune),
  ];
}

int masteryRank(String status) {
  return switch (status) {
    'mastered' => 4,
    'reviewing' => 3,
    'learning' => 2,
    'discovered' => 1,
    _ => 0,
  };
}

String higherMastery(String left, String right) =>
    masteryRank(left) >= masteryRank(right) ? left : right;

String vocabularyStatusForPersonal(String mastery) {
  return switch (mastery) {
    'mastered' => 'mastered',
    'reviewing' => 'reviewing',
    'learning' => 'learning',
    _ => 'discovered',
  };
}

List<Map<String, dynamic>> _maps(Object? value) {
  if (value is! List) return const [];
  return [
    for (final item in value)
      if (item is Map<String, dynamic>)
        item
      else if (item is Map)
        Map<String, dynamic>.from(item),
  ];
}

List<String> _strings(Object? value) {
  if (value is! List) return const [];
  return [for (final item in value) '$item'];
}

String encodeIssues(List<VocabularyReviewIssue> issues) =>
    jsonEncode([for (final issue in issues) issue.toJson()]);

List<VocabularyReviewIssue> decodeIssues(String? raw) {
  if (raw == null || raw.isEmpty) return const [];
  final decoded = jsonDecode(raw);
  if (decoded is! List) return const [];
  return [
    for (final item in decoded)
      if (item is Map<String, dynamic>) VocabularyReviewIssue.fromJson(item),
  ];
}

String encodeDecisions(List<CorrectionDecision> decisions) =>
    jsonEncode([for (final item in decisions) item.toJson()]);

List<CorrectionDecision> decodeDecisions(String? raw) {
  if (raw == null || raw.isEmpty) return const [];
  final decoded = jsonDecode(raw);
  if (decoded is! List) return const [];
  return [
    for (final item in decoded)
      if (item is Map<String, dynamic>) CorrectionDecision.fromJson(item),
  ];
}
