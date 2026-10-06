import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/services/topics/imported_content_marks.dart';

class ImportedContentMarksController extends AsyncNotifier<ImportedContentMarks> {
  @override
  Future<ImportedContentMarks> build() {
    return ImportedContentStore(ref.watch(appDatabaseProvider)).read();
  }

  Future<void> markTopicSeen(String id) async {
    final next = await ImportedContentStore(
      ref.read(appDatabaseProvider),
    ).markTopicSeen(id);
    state = AsyncData(next);
  }

  Future<void> markCategorySeen(String id) async {
    final next = await ImportedContentStore(
      ref.read(appDatabaseProvider),
    ).markCategorySeen(id);
    state = AsyncData(next);
  }
}

final importedContentMarksProvider =
    AsyncNotifierProvider<ImportedContentMarksController, ImportedContentMarks>(
  ImportedContentMarksController.new,
);
