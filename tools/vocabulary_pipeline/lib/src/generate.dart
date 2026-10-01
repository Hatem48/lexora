import 'dart:convert';
import 'dart:io';

import 'build_catalog.dart';
import 'identity.dart';
import 'models.dart';
import 'readers.dart';

class PipelinePaths {
  PipelinePaths(this.repoRoot);

  final Directory repoRoot;

  Directory get rawDir => Directory('${repoRoot.path}/data/vocabulary/raw');
  File get catalogFile =>
      File('${repoRoot.path}/assets/vocabulary/catalog.json');
  Directory get reportDir => Directory('${repoRoot.path}/build/vocabulary');
  File get priorityFile => File(
        '${repoRoot.path}/tools/vocabulary_pipeline/config/priority_weights.json',
      );
}

class MissingSources implements Exception {
  MissingSources(this.files);
  final List<String> files;

  @override
  String toString() =>
      'Missing raw vocabulary files:\n${files.map((file) => '- $file').join('\n')}';
}

class InvalidCatalog implements Exception {
  InvalidCatalog(this.issues);
  final List<ValidationIssue> issues;

  @override
  String toString() =>
      'Vocabulary dataset failed validation:\n${issues.map((issue) => '- ${issue.message}').join('\n')}';
}

void generateCatalog(PipelinePaths paths) {
  final required = [
    cefrFileName,
    octanoveFileName,
    ngslFileName,
    spokenFileName,
    nawlFileName,
  ];
  final missing = [
    for (final name in required)
      if (!File('${paths.rawDir.path}/$name').existsSync()) name,
  ];
  if (missing.isNotEmpty) throw MissingSources(missing);

  final config = PriorityConfig.parse(paths.priorityFile.readAsStringSync());
  final rankRejected = <String>[];
  final sources = RawSources(
    cefr: [
      ...readCefrCsv(
        _read('${paths.rawDir.path}/$cefrFileName'),
        cefrFileName,
        sourceCefrJ,
      ),
      ...readCefrCsv(
        _read('${paths.rawDir.path}/$octanoveFileName'),
        octanoveFileName,
        sourceOctanove,
      ),
    ],
    generalRanks: readRankCsv(
      _read('${paths.rawDir.path}/$ngslFileName'),
      ngslFileName,
      sourceNgsl,
      rejected: rankRejected,
    ),
    spokenRanks: readRankCsv(
      _read('${paths.rawDir.path}/$spokenFileName'),
      spokenFileName,
      sourceNgslSpoken,
      rejected: rankRejected,
    ),
    academicRanks: readRankCsv(
      _read('${paths.rawDir.path}/$nawlFileName'),
      nawlFileName,
      sourceNawl,
      rejected: rankRejected,
    ),
    forms: _optional('${paths.rawDir.path}/$formsFileName', readFormsCsv) ??
        const [],
    topicMappings: _optional(
          '${paths.rawDir.path}/$topicMappingsFileName',
          readTopicMappings,
        ) ??
        const [],
    ngslLoaded: true,
    spokenLoaded: true,
    nawlLoaded: true,
  );

  final result = buildCatalog(sources, config);
  final rejected = [
    ...rankRejected,
    for (final issue in result.issues) issue.message,
  ];
  final fatal = [
    for (final issue in result.issues)
      if (issue.message.startsWith('Duplicate id ')) issue,
  ];
  if (fatal.isNotEmpty) throw InvalidCatalog(fatal);

  paths.reportDir.createSync(recursive: true);
  final catalog = {
    'version': result.catalogVersion,
    'datasetType': 'production',
    'entries': [for (final entry in result.entries) entry.toJson()],
  };
  paths.catalogFile.writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(catalog)}\n',
  );
  final withoutPos = result.issues
      .where((issue) => issue.message.startsWith('Unknown part of speech'))
      .length;
  final summary = {
    'totalVocabularyEntries': result.statistics['totalEntries'],
    'A1': result.statistics['A1'],
    'A2': result.statistics['A2'],
    'B1': result.statistics['B1'],
    'B2': result.statistics['B2'],
    'C1': result.statistics['C1'],
    'C2': result.statistics['C2'],
    'ngslMatches': result.statistics['generalEnglish'],
    'ngslSpokenMatches': result.statistics['spokenEnglish'],
    'nawlMatches': result.statistics['academic'],
    'generalTaggedCount': result.statistics['generalEnglish'],
    'spokenTaggedCount': result.statistics['spokenEnglish'],
    'academicTaggedCount': result.statistics['academic'],
    'entriesWithPos': result.entries.length,
    'entriesWithoutPos': withoutPos,
    'duplicatesRemoved': result.statistics['duplicatesResolved'],
    'cefrConflicts': result.statistics['conflictsDetected'],
    'rejectedRows': rejected.length,
    'catalogBytes': paths.catalogFile.lengthSync(),
  };
  File('${paths.reportDir.path}/summary.json').writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(summary)}\n',
  );
  File('${paths.reportDir.path}/statistics.json').writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(result.statistics)}\n',
  );
  File('${paths.reportDir.path}/conflicts.json').writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert([
          for (final conflict in result.conflicts) conflict.toJson(),
        ])}\n',
  );
  File('${paths.reportDir.path}/rejected.json').writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert(rejected)}\n',
  );
  File('${paths.reportDir.path}/topic_links.json').writeAsStringSync(
    '${const JsonEncoder.withIndent('  ').convert({'links': result.topicLinks})}\n',
  );
}

String _read(String path) => File(path).readAsStringSync();

T? _optional<T>(String path, T Function(String raw) parse) {
  final file = File(path);
  if (!file.existsSync()) return null;
  return parse(file.readAsStringSync());
}
