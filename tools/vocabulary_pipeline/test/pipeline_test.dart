import 'dart:convert';

import 'package:test/test.dart';
import 'package:vocabulary_pipeline/vocabulary_pipeline.dart';

void main() {
  const configRaw = '''
  {
    "catalogVersion": 2,
    "weights": {
      "generalFrequency": 0.40,
      "spokenFrequency": 0.25,
      "academic": 0.20,
      "cefr": 0.15,
      "newsRelevance": 0,
      "ielts": 0,
      "toefl": 0,
      "topicRelevance": 0
    },
    "cefrScores": {"A1": 1.0, "A2": 0.85, "B1": 0.7, "B2": 0.55, "C1": 0.4, "C2": 0.25}
  }
  ''';

  RawSources sources() {
    return RawSources(
      cefr: const [
        CefrObservation(
          lemma: 'record',
          displayLemma: 'record',
          pos: 'noun',
          cefr: 'B1',
          sourceId: sourceCefrJ,
        ),
        CefrObservation(
          lemma: 'record',
          displayLemma: 'record',
          pos: 'verb',
          cefr: 'A2',
          sourceId: sourceCefrJ,
        ),
        CefrObservation(
          lemma: 'record',
          displayLemma: 'record',
          pos: 'noun',
          cefr: 'B1',
          sourceId: sourceCefrJ,
        ),
        CefrObservation(
          lemma: 'develop',
          displayLemma: 'develop',
          pos: 'verb',
          cefr: 'B2',
          sourceId: sourceCefrJ,
        ),
        CefrObservation(
          lemma: 'development',
          displayLemma: 'development',
          pos: 'noun',
          cefr: 'B2',
          sourceId: sourceCefrJ,
        ),
        CefrObservation(
          lemma: 'ceasefire',
          displayLemma: 'ceasefire',
          pos: 'noun',
          cefr: 'B2',
          sourceId: sourceCefrJ,
        ),
        CefrObservation(
          lemma: 'ceasefire',
          displayLemma: 'ceasefire',
          pos: 'noun',
          cefr: 'C1',
          sourceId: sourceOctanove,
        ),
        CefrObservation(
          lemma: 'ubiquitous',
          displayLemma: 'ubiquitous',
          pos: 'adjective',
          cefr: 'C2',
          sourceId: sourceOctanove,
        ),
      ],
      generalRanks: const [
        RankObservation(lemma: 'record', pos: 'noun', rank: 10, sourceId: sourceNgsl),
        RankObservation(lemma: 'develop', pos: null, rank: 3, sourceId: sourceNgsl),
        RankObservation(lemma: 'bank', pos: null, rank: 4, sourceId: sourceNgsl),
      ],
      spokenRanks: const [
        RankObservation(lemma: 'develop', pos: 'verb', rank: 2, sourceId: sourceNgslSpoken),
      ],
      academicRanks: const [
        RankObservation(lemma: 'develop', pos: 'verb', rank: 8, sourceId: sourceNawl),
      ],
      forms: const [
        FormObservation(lemma: 'develop', pos: 'verb', form: 'develops'),
        FormObservation(lemma: 'develop', pos: 'verb', form: 'developed'),
        FormObservation(lemma: 'develop', pos: 'verb', form: 'developing'),
      ],
      topicMappings: const [
        TopicMapping(
          lemma: 'missing',
          pos: 'noun',
          topicId: 'war',
          relevance: 'primary',
        ),
      ],
      ngslLoaded: true,
      spokenLoaded: true,
      nawlLoaded: true,
    );
  }

  test('merge keeps noun and verb apart and does not inflect development', () {
    final result = buildCatalog(sources(), PriorityConfig.parse(configRaw));
    final recordNoun = result.entries.where((entry) => entry.id == 'record-noun');
    final recordVerb = result.entries.where((entry) => entry.id == 'record-verb');
    expect(recordNoun, hasLength(1));
    expect(recordVerb, hasLength(1));
    expect(recordNoun.single.cefr, 'B1');
    expect(recordVerb.single.cefr, 'A2');
    expect(recordNoun.single.ngslRank, 10);
    expect(recordNoun.single.sources['ngslRank'], sourceNgsl);
    expect(recordNoun.single.sources['cefr'], sourceCefrJ);

    final develop = result.entries.singleWhere((entry) => entry.id == 'develop-verb');
    expect(develop.forms, ['develop', 'developed', 'developing', 'develops']);
    expect(develop.academic, isTrue);
    expect(develop.academicRank, 8);
    expect(develop.spokenRank, 2);
    expect(develop.sources['academic'], sourceNawl);
    final development =
        result.entries.singleWhere((entry) => entry.id == 'development-noun');
    expect(development.forms, ['development']);
    expect(development.forms, isNot(contains('develop')));
  });

  test('conflicting CEFR levels are excluded instead of guessed', () {
    final result = buildCatalog(sources(), PriorityConfig.parse(configRaw));
    expect(result.entries.map((entry) => entry.id), isNot(contains('ceasefire-noun')));
    expect(result.conflicts, hasLength(1));
    expect(result.conflicts.single.levelsBySource[sourceCefrJ], 'B2');
    expect(result.conflicts.single.levelsBySource[sourceOctanove], 'C1');
    expect(result.statistics['conflictsDetected'], 1);
  });

  test('two levels from the same source are both recorded', () {
    final result = buildCatalog(
      RawSources(
        cefr: const [
          CefrObservation(
            lemma: 'advantageous',
            displayLemma: 'advantageous',
            pos: 'adjective',
            cefr: 'C1',
            sourceId: sourceOctanove,
          ),
          CefrObservation(
            lemma: 'advantageous',
            displayLemma: 'advantageous',
            pos: 'adjective',
            cefr: 'C2',
            sourceId: sourceOctanove,
          ),
        ],
        generalRanks: const [],
        spokenRanks: const [],
        academicRanks: const [],
        forms: const [],
        topicMappings: const [],
        ngslLoaded: false,
        spokenLoaded: false,
        nawlLoaded: false,
      ),
      PriorityConfig.parse(configRaw),
    );
    expect(result.entries, isEmpty);
    expect(result.conflicts.single.levelsBySource[sourceOctanove], 'C1+C2');
  });

  test('identical duplicate rows are counted and do not create two entries', () {
    final result = buildCatalog(sources(), PriorityConfig.parse(configRaw));
    expect(result.statistics['duplicatesResolved'], greaterThan(0));
    expect(result.entries.where((entry) => entry.id == 'record-noun'), hasLength(1));
  });

  test('ambiguous rank without POS is skipped', () {
    final input = sources();
    final result = buildCatalog(
      RawSources(
        cefr: const [
          CefrObservation(
            lemma: 'record',
            displayLemma: 'record',
            pos: 'noun',
            cefr: 'B1',
            sourceId: sourceCefrJ,
          ),
          CefrObservation(
            lemma: 'record',
            displayLemma: 'record',
            pos: 'verb',
            cefr: 'A2',
            sourceId: sourceCefrJ,
          ),
        ],
        generalRanks: const [
          RankObservation(lemma: 'record', pos: null, rank: 5, sourceId: sourceNgsl),
        ],
        spokenRanks: const [],
        academicRanks: const [],
        forms: const [],
        topicMappings: const [],
        ngslLoaded: true,
        spokenLoaded: false,
        nawlLoaded: false,
      ),
      PriorityConfig.parse(configRaw),
    );
    expect(result.issues, isEmpty);
    expect(result.statistics['ambiguousRanksSkipped'], 1);
    expect(result.entries.every((entry) => entry.ngslRank == null), isTrue);
    expect(input.generalRanks, isNotEmpty);
  });

  test('ids and json are deterministic', () {
    final config = PriorityConfig.parse(configRaw);
    final first = buildCatalog(sources(), config);
    final second = buildCatalog(sources(), config);
    final firstJson = jsonEncode([for (final entry in first.entries) entry.toJson()]);
    final secondJson = jsonEncode([for (final entry in second.entries) entry.toJson()]);
    expect(secondJson, firstJson);
    expect(first.entries.map((entry) => entry.id).toList(), [
      'develop-verb',
      'development-noun',
      'record-noun',
      'record-verb',
      'ubiquitous-adjective',
    ]);
  });

  test('invalid CEFR, broken forms, and missing topic targets fail validation', () {
    final result = buildCatalog(
      RawSources(
        cefr: const [
          CefrObservation(
            lemma: 'ghost',
            displayLemma: 'ghost',
            pos: 'noun',
            cefr: 'Z9',
            sourceId: sourceCefrJ,
          ),
          CefrObservation(
            lemma: '',
            displayLemma: '',
            pos: 'noun',
            cefr: 'A1',
            sourceId: sourceCefrJ,
          ),
        ],
        generalRanks: const [
          RankObservation(lemma: 'ghost', pos: 'noun', rank: 0, sourceId: sourceNgsl),
        ],
        spokenRanks: const [],
        academicRanks: const [],
        forms: const [
          FormObservation(lemma: 'absent', pos: 'noun', form: 'absents'),
        ],
        topicMappings: const [
          TopicMapping(
            lemma: 'absent',
            pos: 'noun',
            topicId: 'war',
            relevance: 'primary',
          ),
        ],
        ngslLoaded: true,
        spokenLoaded: false,
        nawlLoaded: false,
      ),
      PriorityConfig.parse(configRaw),
    );
    expect(result.issues.map((issue) => issue.message).join('\n'), contains('Invalid CEFR'));
    expect(result.issues.map((issue) => issue.message).join('\n'), contains('Missing lemma'));
    expect(result.issues.map((issue) => issue.message).join('\n'), contains('Invalid rank'));
    expect(result.issues.map((issue) => issue.message).join('\n'), contains('missing entry'));
    expect(result.entries, isEmpty);
  });

  test('CEFR-J auxiliary labels map and a blank spoken rank is rejected', () {
    expect(canonicalPos('do-verb'), 'auxiliary');
    expect(canonicalPos('have-verb'), 'auxiliary');
    expect(canonicalPos('modal auxiliary'), 'auxiliary');
    expect(canonicalPos('infinitive-to'), isEmpty);
    expect(canonicalPos('vern'), isEmpty);
    final rejected = <String>[];
    final ranks = readRankCsv(
      'Lemma,Rank\nTRUE,#N/A\nschool,4\n',
      spokenFileName,
      sourceNgslSpoken,
      rejected: rejected,
    );
    expect(ranks.single.lemma, 'school');
    expect(ranks.single.rank, 4);
    expect(rejected, hasLength(1));
  });

  test('malformed csv and json are rejected', () {
    expect(
      () => readCefrCsv('only,one\n', 'bad.csv', sourceCefrJ),
      throwsFormatException,
    );
    expect(
      () => readTopicMappings('{'),
      throwsFormatException,
    );
  });

  test('quoted csv cells and provenance survive a clean merge', () {
    final cefr = readCefrCsv(
      'headword,pos,CEFR,CoreInventory 1\n"well known",adjective,B2,"News, media"\n',
      cefrFileName,
      sourceCefrJ,
    );
    final result = buildCatalog(
      RawSources(
        cefr: cefr,
        generalRanks: const [],
        spokenRanks: const [],
        academicRanks: const [],
        forms: const [],
        topicMappings: const [],
        ngslLoaded: false,
        spokenLoaded: false,
        nawlLoaded: false,
      ),
      PriorityConfig.parse(configRaw),
    );
    expect(result.issues, isEmpty);
    expect(result.entries.single.id, 'well-known-adjective');
    expect(result.entries.single.cefr, 'B2');
    expect(result.entries.single.sources['cefr'], sourceCefrJ);
    expect(result.entries.single.priorityScore, isNotNull);
    expect(result.statistics['entriesWithoutDefinition'], 1);
    expect(result.statistics['entriesWithoutArabicMeaning'], 1);
    expect(result.statistics['entriesWithoutExample'], 1);
    expect(result.statistics['B2'], 1);
  });
}
