import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database/app_database.dart';
import '../../../core/providers/startup_provider.dart';
import '../../../core/services/topics/topic_repository.dart';

typedef TopicBoard = ({
  List<TopicGroupDataView> groups,
  List<TopicCardData> cards,
  List<LearningPathView> paths,
});

final topicBoardProvider = StreamProvider<TopicBoard>((ref) {
  ref.watch(startupTickProvider);
  final db = ref.watch(appDatabaseProvider);
  final repo = TopicRepository(db);
  return db.select(db.userVocabulary).watch().asyncMap((_) async {
    return (
      groups: await repo.groups(),
      cards: await repo.cards(),
      paths: await repo.paths(),
    );
  });
});

final topicWordsProvider = FutureProvider.autoDispose
    .family<List<TopicWordView>, ({String id, String? cefr, TopicWordFilter filter})>(
  (ref, query) async {
    final db = ref.watch(appDatabaseProvider);
    ref.watch(topicBoardProvider);
    return TopicRepository(db).words(
      topicId: query.id,
      cefr: query.cefr,
      filter: query.filter,
    );
  },
);

final topicSentencesProvider = FutureProvider.autoDispose
    .family<List<TopicSentenceView>, ({String id, String? cefr})>(  (ref, query) {
  ref.watch(startupTickProvider);
  final db = ref.watch(appDatabaseProvider);
  return TopicRepository(db).sentences(topicId: query.id, cefr: query.cefr);
});

final topicProgressProvider =
    FutureProvider.autoDispose.family<TopicProgressView, String>((ref, id) {
  final db = ref.watch(appDatabaseProvider);
  ref.watch(topicBoardProvider);
  return TopicRepository(db).progress(id);
});

final entryTopicsProvider =
    FutureProvider.autoDispose    .family<List<DetectedTopic>, String>((ref, id) {
  ref.watch(startupTickProvider);
  final db = ref.watch(appDatabaseProvider);
  return TopicRepository(db).topicsForEntry(id);
});

final blogTopicsProvider =
    FutureProvider.autoDispose<Map<String, List<DetectedTopic>>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  ref.watch(topicBoardProvider);
  return TopicRepository(db).labelsByBlog();
});
