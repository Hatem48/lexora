import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

const noticeReadsKey = 'in_app_notification_reads';

/// Remembers which derived notices were opened. The notices themselves stay
/// computed from reviews, streaks, and achievements.
class NoticeReadStore {
  NoticeReadStore(this._db);

  final AppDatabase _db;

  Future<Set<String>> readIds() async {
    final row = await (_db.select(_db.appStatistics)
          ..where((item) => item.key.equals(noticeReadsKey)))
        .getSingleOrNull();
    if (row == null || row.value.isEmpty) return {};
    try {
      final decoded = jsonDecode(row.value);
      if (decoded is! List) return {};
      return decoded.whereType<String>().toSet();
    } catch (_) {
      return {};
    }
  }

  Future<void> markRead(Iterable<String> ids) async {
    final next = await readIds();
    next.addAll(ids.where((id) => id.isNotEmpty));
    final trimmed = next.toList()..sort();
    final stored = trimmed.length > 200
        ? trimmed.sublist(trimmed.length - 200)
        : trimmed;
    await _db.into(_db.appStatistics).insert(
          AppStatisticsCompanion.insert(
            key: noticeReadsKey,
            value: jsonEncode(stored),
            updatedAt: DateTime.now().toUtc(),
          ),
          mode: InsertMode.insertOrReplace,
        );
  }
}
