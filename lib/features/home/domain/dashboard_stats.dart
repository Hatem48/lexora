import 'package:equatable/equatable.dart';

import '../../../core/constants/enums.dart';

class DashboardStats extends Equatable {
  const DashboardStats({
    required this.wordsCount,
    required this.sentencesCount,
    required this.masteredCount,
    required this.dueTodayCount,
    required this.dueWords,
    required this.dueSentences,
    required this.currentLevel,
    required this.levelProgress,
    required this.cefrProgress,
    required this.recommendations,
  });

  final int wordsCount;
  final int sentencesCount;
  final int masteredCount;
  final int dueTodayCount;
  final int dueWords;
  final int dueSentences;
  final CefrLevel currentLevel;
  final double levelProgress;
  final Map<CefrLevel, CefrLevelProgress> cefrProgress;
  final List<DashboardRecommendation> recommendations;

  @override
  List<Object?> get props => [
        wordsCount,
        sentencesCount,
        masteredCount,
        dueTodayCount,
        dueWords,
        dueSentences,
        currentLevel,
        levelProgress,
        cefrProgress,
        recommendations,
      ];
}

/// Words the learner has met at one CEFR level, against the catalog size.
class CefrLevelProgress extends Equatable {
  const CefrLevelProgress({required this.known, required this.total});

  final int known;
  final int total;

  double get fraction {
    if (total <= 0 || known <= 0) return 0;
    final value = known / total;
    return value > 1 ? 1 : value;
  }

  @override
  List<Object?> get props => [known, total];
}

class DashboardRecommendation extends Equatable {
  const DashboardRecommendation({
    required this.titleKey,
    required this.subtitleKey,
    this.count,
    this.icon = 'book',
  });

  final String titleKey;
  final String subtitleKey;
  final int? count;
  final String icon;

  @override
  List<Object?> get props => [titleKey, subtitleKey, count, icon];
}
