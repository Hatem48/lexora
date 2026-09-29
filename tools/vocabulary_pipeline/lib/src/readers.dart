import 'dart:convert';

import 'csv_table.dart';
import 'identity.dart';
import 'models.dart';

List<CefrObservation> readCefrCsv(String raw, String fileName, String sourceId) {
  final table = CsvTable.parse(raw, fileName);
  final lemmaIndex = table.requireColumn(
    const ['headword', 'lemma', 'word'],
    fileName,
  );
  final posIndex = table.requireColumn(const ['pos', 'partofspeech'], fileName);
  final cefrIndex = table.requireColumn(const ['cefr', 'level'], fileName);
  return [
    for (final row in table.rows)
      if (table.cell(row, lemmaIndex).isNotEmpty)
        CefrObservation(
          lemma: canonicalLemma(table.cell(row, lemmaIndex)),
          displayLemma: table.cell(row, lemmaIndex),
          pos: canonicalPos(table.cell(row, posIndex)),
          cefr: table.cell(row, cefrIndex).toUpperCase(),
          sourceId: sourceId,
        ),
  ];
}

List<RankObservation> readRankCsv(String raw, String fileName, String sourceId) {
  final table = CsvTable.parse(raw, fileName);
  final lemmaIndex = table.requireColumn(
    const ['lemma', 'headword', 'word'],
    fileName,
  );
  final rankIndex = table.requireColumn(
    const ['rank', 'sfi rank', 'frequency rank'],
    fileName,
  );
  final posIndex = columnIndex(table.header, const ['pos', 'partofspeech']);
  final rows = <RankObservation>[];
  for (final row in table.rows) {
    final lemma = canonicalLemma(table.cell(row, lemmaIndex));
    if (lemma.isEmpty) continue;
    final rankRaw = table.cell(row, rankIndex);
    final rank = int.tryParse(rankRaw);
    if (rank == null) {
      throw FormatException(
        '$fileName has a non-numeric rank "$rankRaw" for "$lemma".',
      );
    }
    final posRaw = posIndex == null ? '' : table.cell(row, posIndex);
    String? pos;
    if (posRaw.isNotEmpty) {
      pos = canonicalPos(posRaw);
      if (pos.isEmpty) {
        throw FormatException(
          '$fileName has an unknown part of speech "$posRaw" for "$lemma".',
        );
      }
    }
    rows.add(
      RankObservation(
        lemma: lemma,
        pos: pos,
        rank: rank,
        sourceId: sourceId,
      ),
    );
  }
  return rows;
}

List<FormObservation> readFormsCsv(String raw) {
  final table = CsvTable.parse(raw, formsFileName);
  final lemmaIndex = table.requireColumn(
    const ['lemma', 'headword'],
    formsFileName,
  );
  final posIndex = table.requireColumn(const ['pos'], formsFileName);
  final formIndex = table.requireColumn(const ['form', 'surface'], formsFileName);
  return [
    for (final row in table.rows)
      FormObservation(
        lemma: canonicalLemma(table.cell(row, lemmaIndex)),
        pos: canonicalPos(table.cell(row, posIndex)),
        form: table.cell(row, formIndex),
      ),
  ];
}

List<TopicMapping> readTopicMappings(String raw) {
  final decoded = jsonDecode(raw);
  if (decoded is! Map<String, dynamic> || decoded['mappings'] is! List) {
    throw const FormatException(
      'vocabulary-topic-mappings.json must contain a mappings list.',
    );
  }
  return [
    for (final item in decoded['mappings'] as List)
      if (item is Map<String, dynamic>)
        TopicMapping(
          lemma: canonicalLemma('${item['lemma'] ?? ''}'),
          pos: canonicalPos('${item['pos'] ?? ''}'),
          topicId: '${item['topicId'] ?? ''}'.trim(),
          relevance: '${item['relevance'] ?? 'medium'}'.trim(),
        ),
  ];
}
