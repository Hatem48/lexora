import 'dart:convert';
import 'dart:io';

/// Writes a replaceable practice catalog. This is not the production pipeline.
void main() {
  final scriptDir = File(Platform.script.toFilePath()).parent;
  final root = scriptDir.parent.parent;
  final entries = _readEntries(File('${scriptDir.path}/entries.tsv'));
  final sentences = _readSentences(File('${scriptDir.path}/sentences.tsv'));
  final topicsFile = File('${root.path}/assets/vocabulary/topics.json');
  final topicsDoc = jsonDecode(topicsFile.readAsStringSync()) as Map<String, dynamic>;
  final topicIds = {
    for (final topic in topicsDoc['topics'] as List)
      (topic as Map<String, dynamic>)['id'] as String,
  };

  _validate(entries, sentences, topicIds);

  final catalog = {
    'version': 2,
    'datasetType': 'development',
    'note':
        'Original practice entries for trying the app. Not an official CEFR word list. The vocabulary pipeline replaces this file and writes datasetType production.',
    'entries': [
      for (final entry in entries)
        {
          'id': entry.id,
          'lemma': entry.lemma,
          'cefr': entry.cefr,
          'pos': entry.pos,
          'definitionEn': entry.definition,
          'arabicMeaning': entry.arabic,
          'example': entry.example,
          if (entry.forms.isNotEmpty) 'forms': entry.forms,
          if (entry.academic) 'academic': true,
          if (entry.ielts) 'ielts': true,
          if (entry.toefl) 'toefl': true,
        },
    ],
  };

  final links = [
    for (final entry in entries)
      for (final link in entry.links)
        {
          'entryId': entry.id,
          'topicId': link.topicId,
          'relevance': link.relevance,
        },
  ];

  topicsDoc['version'] = 2;
  topicsDoc['datasetType'] = 'development';
  topicsDoc['note'] =
      'Practice topic links and sentences for the development vocabulary. Not an official topic word list. Links whose entry ids are absent are skipped on import.';
  topicsDoc['links'] = links;
  topicsDoc['sentences'] = [
    for (var i = 0; i < sentences.length; i++)
      {
        'id': sentences[i].id,
        'en': sentences[i].en,
        'ar': sentences[i].ar,
        'cefr': sentences[i].cefr,
        'sortOrder': i + 1,
        'topics': [sentences[i].topicId],
      },
  ];
  topicsDoc['ranks'] = <Object>[];

  const encoder = JsonEncoder.withIndent('  ');
  File('${root.path}/assets/vocabulary/catalog.json').writeAsStringSync(
    '${encoder.convert(catalog)}\n',
  );
  topicsFile.writeAsStringSync('${encoder.convert(topicsDoc)}\n');

  final byLevel = <String, int>{};
  for (final entry in entries) {
    byLevel[entry.cefr] = (byLevel[entry.cefr] ?? 0) + 1;
  }
  stdout.writeln('entries ${entries.length} $byLevel');
  stdout.writeln('links ${links.length} sentences ${sentences.length}');
}

class _Entry {
  _Entry({
    required this.lemma,
    required this.pos,
    required this.cefr,
    required this.arabic,
    required this.definition,
    required this.example,
    required this.forms,
    required this.links,
    required this.academic,
    required this.ielts,
    required this.toefl,
  });

  final String lemma;
  final String pos;
  final String cefr;
  final String arabic;
  final String definition;
  final String example;
  final List<String> forms;
  final List<_Link> links;
  final bool academic;
  final bool ielts;
  final bool toefl;

  String get id {
    final slug = lemma
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return '$slug-$pos';
  }
}

class _Link {
  const _Link(this.topicId, this.relevance);
  final String topicId;
  final String relevance;
}

class _Sentence {
  _Sentence({
    required this.topicId,
    required this.cefr,
    required this.en,
    required this.ar,
    required this.id,
  });

  final String topicId;
  final String cefr;
  final String en;
  final String ar;
  final String id;
}

List<_Entry> _readEntries(File file) {
  final entries = <_Entry>[];
  for (final raw in file.readAsLinesSync()) {
    final line = raw.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    final parts = line.split('|');
    if (parts.length != 9) {
      throw FormatException('Expected 9 columns: $line');
    }
    final flags = parts[8] == '-' ? <String>{} : parts[8].split(',').toSet();
    entries.add(
      _Entry(
        lemma: parts[0],
        pos: parts[1],
        cefr: parts[2],
        arabic: parts[3],
        definition: parts[4],
        example: parts[5],
        forms: parts[6] == '-' ? const [] : parts[6].split(','),
        links: [
          for (final item in parts[7].split(','))
            _Link(item.split(':').first, item.split(':').last),
        ],
        academic: flags.contains('academic'),
        ielts: flags.contains('ielts'),
        toefl: flags.contains('toefl'),
      ),
    );
  }
  return entries;
}

List<_Sentence> _readSentences(File file) {
  final counts = <String, int>{};
  final sentences = <_Sentence>[];
  for (final raw in file.readAsLinesSync()) {
    final line = raw.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    final parts = line.split('|');
    if (parts.length != 4) {
      throw FormatException('Expected 4 columns: $line');
    }
    final topicId = parts[0];
    final n = (counts[topicId] ?? 0) + 1;
    counts[topicId] = n;
    sentences.add(
      _Sentence(
        topicId: topicId,
        cefr: parts[1],
        en: parts[2],
        ar: parts[3],
        id: '$topicId-$n',
      ),
    );
  }
  return sentences;
}

void _validate(
  List<_Entry> entries,
  List<_Sentence> sentences,
  Set<String> topicIds,
) {
  if (entries.length < 120 || entries.length > 200) {
    throw StateError('Entry count ${entries.length} is outside 120-200.');
  }
  final levels = entries.map((entry) => entry.cefr).toSet();
  for (final level in ['A1', 'A2', 'B1', 'B2', 'C1', 'C2']) {
    if (!levels.contains(level)) throw StateError('Missing CEFR $level');
  }

  final ids = <String>{};
  final surfaces = <String, String>{};
  void claim(String surface, String id) {
    final owner = surfaces[surface];
    if (owner != null && owner != id) {
      throw StateError('Surface "$surface" belongs to $owner and $id');
    }
    surfaces[surface] = id;
  }

  final linksByTopic = <String, Set<String>>{};
  for (final entry in entries) {
    if (!ids.add(entry.id)) throw StateError('Duplicate id ${entry.id}');
    if (entry.definition.isEmpty || entry.arabic.isEmpty || entry.example.isEmpty) {
      throw StateError('${entry.id} is missing text');
    }
    claim(entry.lemma.toLowerCase(), entry.id);
    for (final form in entry.forms) {
      claim(form.toLowerCase(), entry.id);
    }
    for (final link in entry.links) {
      if (!topicIds.contains(link.topicId)) {
        throw StateError('Unknown topic ${link.topicId} on ${entry.id}');
      }
      linksByTopic.putIfAbsent(link.topicId, () => {}).add(entry.id);
    }
  }

  final develop = entries.singleWhere((entry) => entry.id == 'develop-verb');
  final development = entries.singleWhere((entry) => entry.id == 'development-noun');
  if (develop.forms.contains('development') ||
      develop.lemma == development.lemma) {
    throw StateError('development must stay separate from develop');
  }
  for (final form in ['develops', 'developed', 'developing']) {
    if (!develop.forms.contains(form)) throw StateError('Missing form $form');
  }
  final study = entries.singleWhere((entry) => entry.id == 'study-verb');
  for (final form in ['studies', 'studied', 'studying']) {
    if (!study.forms.contains(form)) throw StateError('Missing form $form');
  }
  final work = entries.singleWhere((entry) => entry.id == 'work-verb');
  for (final form in ['works', 'worked', 'working']) {
    if (!work.forms.contains(form)) throw StateError('Missing form $form');
  }
  final write = entries.singleWhere((entry) => entry.id == 'write-verb');
  if (write.forms.contains('writing')) {
    throw StateError('writing is its own entry');
  }

  final sentencesByTopic = <String, int>{};
  for (final sentence in sentences) {
    if (!topicIds.contains(sentence.topicId)) {
      throw StateError('Unknown sentence topic ${sentence.topicId}');
    }
    sentencesByTopic[sentence.topicId] =
        (sentencesByTopic[sentence.topicId] ?? 0) + 1;
  }

  for (final topicId in topicIds) {
    final words = linksByTopic[topicId]?.length ?? 0;
    final sentenceCount = sentencesByTopic[topicId] ?? 0;
    if (words < 3 || sentenceCount < 3) {
      throw StateError('$topicId has $words words and $sentenceCount sentences');
    }
  }
}
