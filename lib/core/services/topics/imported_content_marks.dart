import 'dart:convert';

import '../../database/app_database.dart';

/// Preference row for categories and topics created by content import.
/// Separate from vocabulary-review state.
const importedContentNewKey = 'imported_content_new';

class ImportedContentMarks {
  const ImportedContentMarks({
    this.topicIds = const {},
    this.categoryIds = const {},
  });

  static const empty = ImportedContentMarks();

  final Set<String> topicIds;
  final Set<String> categoryIds;

  bool topicIsNew(String id) => topicIds.contains(id);

  bool categoryIsNew(String id) => categoryIds.contains(id);
}

class ImportedContentStore {
  ImportedContentStore(this._db);

  final AppDatabase _db;

  Future<ImportedContentMarks> read() async {
    final row = await (_db.select(_db.userPreferences)
          ..where((item) => item.key.equals(importedContentNewKey)))
        .getSingleOrNull();
    if (row == null) return ImportedContentMarks.empty;
    return decodeImportedContentMarks(row.value);
  }

  /// Adds ids that this import created. Existing ids are not passed in, so an
  /// update cannot become new again after the user has opened it.
  Future<void> rememberCreated({
    required Iterable<String> topicIds,
    required Iterable<String> categoryIds,
  }) async {
    final topics = topicIds.where((id) => id.isNotEmpty).toSet();
    final categories = categoryIds.where((id) => id.isNotEmpty).toSet();
    if (topics.isEmpty && categories.isEmpty) return;
    final current = await read();
    await _write(
      ImportedContentMarks(
        topicIds: {...current.topicIds, ...topics},
        categoryIds: {...current.categoryIds, ...categories},
      ),
    );
  }

  Future<ImportedContentMarks> markTopicSeen(String id) async {
    final current = await read();
    if (!current.topicIds.contains(id)) return current;
    final next = ImportedContentMarks(
      topicIds: {...current.topicIds}..remove(id),
      categoryIds: current.categoryIds,
    );
    await _write(next);
    return next;
  }

  Future<ImportedContentMarks> markCategorySeen(String id) async {
    final current = await read();
    if (!current.categoryIds.contains(id)) return current;
    final next = ImportedContentMarks(
      topicIds: current.topicIds,
      categoryIds: {...current.categoryIds}..remove(id),
    );
    await _write(next);
    return next;
  }

  Future<void> _write(ImportedContentMarks marks) {
    return _db.into(_db.userPreferences).insertOnConflictUpdate(
          UserPreferencesCompanion.insert(
            key: importedContentNewKey,
            value: encodeImportedContentMarks(marks),
            updatedAt: DateTime.now(),
          ),
        );
  }
}

String encodeImportedContentMarks(ImportedContentMarks marks) {
  final topics = marks.topicIds.toList()..sort();
  final categories = marks.categoryIds.toList()..sort();
  return jsonEncode({
    'topics': topics,
    'categories': categories,
  });
}

ImportedContentMarks decodeImportedContentMarks(String raw) {
  try {
    final decoded = jsonDecode(raw);
    if (decoded is! Map<String, dynamic>) return ImportedContentMarks.empty;
    return ImportedContentMarks(
      topicIds: _ids(decoded['topics']),
      categoryIds: _ids(decoded['categories']),
    );
  } catch (_) {
    return ImportedContentMarks.empty;
  }
}

Set<String> _ids(Object? value) {
  if (value is! List) return const {};
  return {
    for (final item in value)
      if (item is String && item.isNotEmpty) item,
  };
}
