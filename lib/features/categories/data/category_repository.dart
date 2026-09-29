import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';

final categoriesListProvider = StreamProvider<List<CategoryRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.categories)
        ..orderBy([
          (t) => OrderingTerm.asc(t.sortOrder),
          (t) => OrderingTerm.asc(t.name),
        ]))
      .watch();
});

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepository(ref.watch(appDatabaseProvider));
});

class CategoryRepository {
  CategoryRepository(this._db);

  final AppDatabase _db;
  final _uuid = const Uuid();

  Future<String> create({
    required String name,
    String? nameAr,
    String iconName = 'folder',
  }) async {
    final now = DateTime.now();
    final id = _uuid.v4();
    final maxOrder = await (_db.selectOnly(_db.categories)
          ..addColumns([_db.categories.sortOrder.max()]))
        .map((row) => row.read(_db.categories.sortOrder.max()) ?? 0)
        .getSingle();

    await _db.into(_db.categories).insert(
          CategoriesCompanion.insert(
            id: id,
            name: name.trim(),
            nameAr: Value(
              nameAr == null || nameAr.trim().isEmpty ? null : nameAr.trim(),
            ),
            iconName: Value(iconName),
            sortOrder: Value(maxOrder + 1),
            isSystem: const Value(false),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return id;
  }

  Future<void> update({
    required String id,
    required String name,
    String? nameAr,
    String? iconName,
  }) async {
    await (_db.update(_db.categories)..where((t) => t.id.equals(id))).write(
      CategoriesCompanion(
        name: Value(name.trim()),
        nameAr: Value(
          nameAr == null || nameAr.trim().isEmpty ? null : nameAr.trim(),
        ),
        iconName: iconName == null ? const Value.absent() : Value(iconName),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<bool> delete(String id) async {
    final row = await (_db.select(_db.categories)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (row == null) return false;
    if (row.isSystem) return false;

    await (_db.delete(_db.wordCategories)
          ..where((t) => t.categoryId.equals(id)))
        .go();
    await (_db.delete(_db.sentenceCategories)
          ..where((t) => t.categoryId.equals(id)))
        .go();
    await (_db.delete(_db.patternCategories)
          ..where((t) => t.categoryId.equals(id)))
        .go();
    await (_db.delete(_db.categories)..where((t) => t.id.equals(id))).go();
    return true;
  }

  Future<void> setWordCategories(String wordId, Set<String> categoryIds) async {
    await (_db.delete(_db.wordCategories)
          ..where((t) => t.wordId.equals(wordId)))
        .go();
    for (final categoryId in categoryIds) {
      await _db.into(_db.wordCategories).insert(
            WordCategoriesCompanion.insert(
              wordId: wordId,
              categoryId: categoryId,
            ),
          );
    }
  }

  Future<void> setSentenceCategories(
    String sentenceId,
    Set<String> categoryIds,
  ) async {
    await (_db.delete(_db.sentenceCategories)
          ..where((t) => t.sentenceId.equals(sentenceId)))
        .go();
    for (final categoryId in categoryIds) {
      await _db.into(_db.sentenceCategories).insert(
            SentenceCategoriesCompanion.insert(
              sentenceId: sentenceId,
              categoryId: categoryId,
            ),
          );
    }
  }

  Future<Set<String>> wordIdsForCategory(String categoryId) async {
    final rows = await (_db.select(_db.wordCategories)
          ..where((t) => t.categoryId.equals(categoryId)))
        .get();
    return rows.map((r) => r.wordId).toSet();
  }

  Future<Set<String>> sentenceIdsForCategory(String categoryId) async {
    final rows = await (_db.select(_db.sentenceCategories)
          ..where((t) => t.categoryId.equals(categoryId)))
        .get();
    return rows.map((r) => r.sentenceId).toSet();
  }
}
