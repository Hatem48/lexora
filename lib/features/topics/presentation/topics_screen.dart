import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/services/topics/topic_repository.dart';
import '../../../core/widgets/lexora_widgets.dart';
import 'topic_icons.dart';
import 'topic_providers.dart';

class TopicsScreen extends ConsumerWidget {
  const TopicsScreen({super.key, this.pathId});

  final String? pathId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final board = ref.watch(topicBoardProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(pathId == null ? l10n.topicsTitle : l10n.learningPaths),
      ),
      body: board.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (data) {
          LearningPathView? path;
          if (pathId != null) {
            for (final item in data.paths) {
              if (item.id == pathId) path = item;
            }
          }
          final visible = path == null
              ? data.cards
              : [
                  for (final card in data.cards)
                    if (path.topicIds.contains(card.id)) card,
                ];
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              if (pathId == null && data.paths.isNotEmpty) ...[
                Text(
                  l10n.learningPaths,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 40,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.paths.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final item = data.paths[index];
                      return ActionChip(
                        label: Text(
                          localizedPair(context, item.nameEn, item.nameAr),
                        ),
                        onPressed: () => context.push('/topics/path/${item.id}'),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionGap),
              ],
              if (path != null) ...[
                Text(localizedPair(context, path.descriptionEn, path.descriptionAr)),
                const SizedBox(height: AppSpacing.md),
                for (final card in visible) ...[
                  _TopicCard(card: card),
                  const SizedBox(height: 12),
                ],
              ] else
                for (final group in data.groups) ...[
                  if (visible.any((card) => card.groupId == group.id)) ...[
                    Text(
                      localizedPair(context, group.nameEn, group.nameAr),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    for (final card in visible.where((item) => item.groupId == group.id)) ...[
                      _TopicCard(card: card),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 8),
                  ],
                ],
            ],
          );
        },
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.card});

  final TopicCardData card;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final percent = (card.progress * 100).round();
    return LexoraCard(
      onTap: () => context.push('/topics/${card.id}'),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(topicIcon(card.iconKey), color: AppColors.primary),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizedPair(context, card.nameEn, card.nameAr),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.topicDiscoveredOf(card.unlocked, card.wordCount),
                ),
                Text(l10n.topicMasteredCount(card.mastered)),
                Text(l10n.topicSentenceCount(card.sentenceCount)),
              ],
            ),
          ),
          Text(
            '$percent%',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.primary,
                ),
          ),
        ],
      ),
    );
  }
}
