import 'identity.dart';
import 'models.dart';
import 'priority.dart';

class BuildResult {
  const BuildResult({
    required this.entries,
    required this.conflicts,
    required this.issues,
    required this.statistics,
    required this.topicLinks,
    required this.catalogVersion,
  });

  final List<CatalogWord> entries;
  final List<LevelConflict> conflicts;
  final List<ValidationIssue> issues;
  final Map<String, Object?> statistics;
  final List<Map<String, Object?>> topicLinks;
  final int catalogVersion;
}

class RawSources {
  const RawSources({
    required this.cefr,
    required this.generalRanks,
    required this.spokenRanks,
    required this.academicRanks,
    required this.forms,
    required this.topicMappings,
    required this.ngslLoaded,
    required this.spokenLoaded,
    required this.nawlLoaded,
  });

  final List<CefrObservation> cefr;
  final List<RankObservation> generalRanks;
  final List<RankObservation> spokenRanks;
  final List<RankObservation> academicRanks;
  final List<FormObservation> forms;
  final List<TopicMapping> topicMappings;
  final bool ngslLoaded;
  final bool spokenLoaded;
  final bool nawlLoaded;
}

BuildResult buildCatalog(RawSources sources, PriorityConfig config) {
  final issues = <ValidationIssue>[];
  final conflicts = <LevelConflict>[];
  var duplicatesResolved = 0;

  final grouped = <LemmaPos, List<CefrObservation>>{};
  for (final row in sources.cefr) {
    if (row.lemma.isEmpty) {
      issues.add(ValidationIssue('Missing lemma in ${row.sourceId}.'));
      continue;
    }
    if (row.pos.isEmpty) {
      issues.add(
        ValidationIssue(
          'Unknown part of speech for "${row.displayLemma}" in ${row.sourceId}.',
        ),
      );
      continue;
    }
    if (!cefrLevels.contains(row.cefr)) {
      issues.add(
        ValidationIssue(
          'Invalid CEFR "${row.cefr}" for "${row.displayLemma}" (${row.pos}).',
        ),
      );
      continue;
    }
    grouped.putIfAbsent(LemmaPos(row.lemma, row.pos), () => []).add(row);
  }

  final entries = <CatalogWord>[];
  final byKey = <LemmaPos, CatalogWord>{};
  final byLemma = <String, List<CatalogWord>>{};

  final keys = grouped.keys.toList()
    ..sort((a, b) {
      final lemmaOrder = a.lemma.compareTo(b.lemma);
      return lemmaOrder != 0 ? lemmaOrder : a.pos.compareTo(b.pos);
    });

  final usedIds = <String>{};
  for (final key in keys) {
    final rows = grouped[key]!;
    final levels = <String, String>{};
    var disagreement = false;
    for (final row in rows) {
      final previous = levels[row.sourceId];
      if (previous != null && previous != row.cefr) {
        disagreement = true;
      }
      levels[row.sourceId] = row.cefr;
      if (previous == row.cefr) duplicatesResolved++;
    }
    final distinct = levels.values.toSet();
    if (disagreement || distinct.length != 1) {
      conflicts.add(
        LevelConflict(
          lemma: rows.first.displayLemma,
          pos: key.pos,
          levelsBySource: levels,
        ),
      );
      continue;
    }
    final id = entryIdFor(key.lemma, key.pos);
    if (!usedIds.add(id)) {
      issues.add(ValidationIssue('Duplicate id "$id".'));
      continue;
    }
    final sourceIds = levels.keys.toList()..sort();
    final entry = CatalogWord(
      id: id,
      lemma: rows.first.displayLemma.trim(),
      pos: key.pos,
      cefr: distinct.single,
      cefrSource: sourceIds.join('+'),
      catalogVersion: config.catalogVersion,
    );
    entry.sources['cefr'] = entry.cefrSource;
    entry.forms.add(key.lemma);
    entries.add(entry);
    byKey[key] = entry;
    byLemma.putIfAbsent(key.lemma, () => []).add(entry);
  }

  var ambiguousRanksSkipped = 0;

  void applyRanks(List<RankObservation> ranks, void Function(CatalogWord, int) apply) {
    final seen = <String, int>{};
    for (final rank in ranks) {
      if (rank.rank < 1) {
        issues.add(
          ValidationIssue(
            'Invalid rank ${rank.rank} for "${rank.lemma}" in ${rank.sourceId}.',
          ),
        );
        continue;
      }
      final targets = <CatalogWord>[];
      if (rank.pos != null && rank.pos!.isNotEmpty) {
        final match = byKey[LemmaPos(rank.lemma, rank.pos!)];
        if (match != null) targets.add(match);
      } else {
        targets.addAll(byLemma[rank.lemma] ?? const []);
        if (targets.length > 1) {
          ambiguousRanksSkipped++;
          continue;
        }
      }
      if (targets.length != 1) continue;
      final target = targets.single;
      final previous = seen[target.id];
      if (previous != null && previous != rank.rank) {
        issues.add(
          ValidationIssue(
            'Conflicting ${rank.sourceId} ranks for "${target.lemma}" (${target.pos}).',
          ),
        );
        continue;
      }
      if (previous == rank.rank) {
        duplicatesResolved++;
        continue;
      }
      seen[target.id] = rank.rank;
      apply(target, rank.rank);
    }
  }

  applyRanks(sources.generalRanks, (entry, rank) {
    entry.ngslRank = rank;
    entry.generalEnglish = true;
    entry.sources['ngslRank'] = sourceNgsl;
  });
  applyRanks(sources.spokenRanks, (entry, rank) {
    entry.spokenRank = rank;
    entry.spokenEnglish = true;
    entry.sources['spokenRank'] = sourceNgslSpoken;
  });
  applyRanks(sources.academicRanks, (entry, rank) {
    entry.academicRank = rank;
    entry.academic = true;
    entry.sources['academic'] = sourceNawl;
  });

  final maxNgsl = _max(entries.map((entry) => entry.ngslRank));
  final maxSpoken = _max(entries.map((entry) => entry.spokenRank));
  for (final entry in entries) {
    entry.priorityScore = priorityScore(
      config: config,
      cefr: entry.cefr,
      ngslRank: entry.ngslRank,
      spokenRank: entry.spokenRank,
      academic: sources.nawlLoaded ? entry.academic : null,
      newsRelevance: entry.newsRelevance,
      ieltsRelevant: entry.ieltsRelevant,
      toeflRelevant: entry.toeflRelevant,
      maxNgslRank: maxNgsl,
      maxSpokenRank: maxSpoken,
      maxNewsRank: null,
    );
  }

  var ambiguousSurfacesSkipped = 0;
  final blockedSurfaces = <String>{};
  final formOwners = <String, String>{};
  for (final entry in entries) {
    final surface = canonicalLemma(entry.lemma);
    if (blockedSurfaces.contains(surface)) continue;
    final owner = formOwners[surface];
    if (owner != null && owner != entry.id) {
      ambiguousSurfacesSkipped++;
      blockedSurfaces.add(surface);
      formOwners.remove(surface);
      entries.firstWhere((item) => item.id == owner).forms.remove(surface);
      continue;
    }
    formOwners[surface] = entry.id;
    if (!entry.forms.contains(surface)) entry.forms.add(surface);
  }
  for (final form in sources.forms) {
    final entry = byKey[LemmaPos(form.lemma, form.pos)];
    if (entry == null) {
      issues.add(
        ValidationIssue(
          'Form "${form.form}" points at missing entry ${form.lemma}/${form.pos}.',
        ),
      );
      continue;
    }
    final surface = canonicalLemma(form.form);
    if (surface.isEmpty) {
      issues.add(ValidationIssue('Empty form for ${entry.id}.'));
      continue;
    }
    final owner = formOwners[surface];
    if (owner != null && owner != entry.id) {
      issues.add(
        ValidationIssue('Form "$surface" points at both $owner and ${entry.id}.'),
      );
      continue;
    }
    formOwners[surface] = entry.id;
    if (!entry.forms.contains(surface)) entry.forms.add(surface);
  }
  for (final entry in entries) {
    entry.forms.sort();
  }

  final topicLinks = <Map<String, Object?>>[];
  for (final mapping in sources.topicMappings) {
    final entry = byKey[LemmaPos(mapping.lemma, mapping.pos)];
    if (entry == null) {
      issues.add(
        ValidationIssue(
          'Topic "${mapping.topicId}" points at missing entry ${mapping.lemma}/${mapping.pos}.',
        ),
      );
      continue;
    }
    topicLinks.add({
      'entryId': entry.id,
      'topicId': mapping.topicId,
      'relevance': mapping.relevance,
    });
  }

  entries.sort((a, b) => a.id.compareTo(b.id));
  final counts = {for (final level in cefrLevels) level: 0};
  for (final entry in entries) {
    counts[entry.cefr] = (counts[entry.cefr] ?? 0) + 1;
  }

  return BuildResult(
    entries: entries,
    conflicts: conflicts,
    issues: issues,
    catalogVersion: config.catalogVersion,
    topicLinks: topicLinks,
    statistics: <String, Object?>{
      'totalEntries': entries.length,
      'A1': counts['A1'],
      'A2': counts['A2'],
      'B1': counts['B1'],
      'B2': counts['B2'],
      'C1': counts['C1'],
      'C2': counts['C2'],
      'generalEnglish': entries.where((entry) => entry.generalEnglish).length,
      'spokenEnglish': entries.where((entry) => entry.spokenEnglish).length,
      'academic': entries.where((entry) => entry.academic).length,
      'entriesWithoutArabicMeaning':
          entries.where((entry) => entry.arabicMeaning.isEmpty).length,
      'entriesWithoutDefinition':
          entries.where((entry) => entry.definitionEn.isEmpty).length,
      'entriesWithoutExample':
          entries.where((entry) => entry.exampleSentence.isEmpty).length,
      'entriesWithoutInflections': entries
          .where((entry) => entry.forms.length <= 1)
          .length,
      'duplicatesResolved': duplicatesResolved,
      'conflictsDetected': conflicts.length,
      'ambiguousRanksSkipped': ambiguousRanksSkipped,
      'ambiguousSurfacesSkipped': ambiguousSurfacesSkipped,
    },
  );
}

int? _max(Iterable<int?> values) {
  int? max;
  for (final value in values) {
    if (value == null) continue;
    if (max == null || value > max) max = value;
  }
  return max;
}
