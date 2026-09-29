import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/services/vocabulary/vocabulary_discovery_repository.dart';

final blogRepositoryProvider = Provider<BlogRepository>((ref) {
  return BlogRepository(ref.watch(appDatabaseProvider));
});

final blogsProvider = StreamProvider<List<BlogEntryRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.blogEntries)
        ..orderBy([(row) => OrderingTerm.desc(row.updatedAt)]))
      .watch();
});

class BlogRepository {
  BlogRepository(AppDatabase db)
      : _db = db,
        _discovery = VocabularyDiscoveryRepository(db);

  final AppDatabase _db;
  final VocabularyDiscoveryRepository _discovery;

  Future<BlogEntryRow?> find(String id) {
    return (_db.select(_db.blogEntries)..where((row) => row.id.equals(id)))
        .getSingleOrNull();
  }

  Future<DiscoverySummary> save({
    String? id,
    required String title,
    required String content,
  }) async {
    final now = DateTime.now();
    final blogId = id ?? const Uuid().v4();
    final existing = id == null ? null : await find(id);

    if (existing == null) {
      await _db.into(_db.blogEntries).insert(
            BlogEntriesCompanion.insert(
              id: blogId,
              title: title,
              content: content,
              createdAt: now,
              updatedAt: now,
            ),
          );
    } else {
      await (_db.update(_db.blogEntries)..where((row) => row.id.equals(blogId)))
          .write(
        BlogEntriesCompanion(
          title: Value(title),
          content: Value(content),
          updatedAt: Value(now),
        ),
      );
    }

    final summary = await _discovery.analyzeAndRecord(
      text: '$title\n$content',
      discoveredIn: 'blog',
      sourceId: blogId,
      trackBlogLinks: true,
    );

    await (_db.update(_db.blogEntries)..where((row) => row.id.equals(blogId)))
        .write(
      BlogEntriesCompanion(
        wordCount: Value(summary.tokenCount),
        uniqueClassified: Value(summary.uniqueClassified),
        newDiscoveries: Value(
          (existing?.newDiscoveries ?? 0) + summary.newCount,
        ),
        cefrDistributionJson: Value(
          encodeCefrDistribution(summary.cefrDistribution),
        ),
      ),
    );
    return summary;
  }

  Future<void> delete(String id) async {
    await _db.transaction(() async {
      await (_db.delete(_db.blogVocabulary)
            ..where((row) => row.blogId.equals(id)))
          .go();
      await (_db.delete(_db.blogEntries)..where((row) => row.id.equals(id)))
          .go();
    });
  }
}
