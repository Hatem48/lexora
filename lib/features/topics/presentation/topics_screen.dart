import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/help/context_help_icon.dart';
import '../../../core/help/help_catalog.dart';
import '../../../core/services/topics/imported_content_marks.dart';
import '../../../core/services/topics/topic_repository.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../domain/topic_search.dart';
import 'imported_content_providers.dart';
import 'imported_new_badge.dart';
import 'topic_icons.dart';
import 'topic_providers.dart';

class TopicsScreen extends ConsumerStatefulWidget {
  const TopicsScreen({super.key, this.pathId});

  final String? pathId;

  @override
  ConsumerState<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends ConsumerState<TopicsScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _setQuery(String value) {
    setState(() => _query = value);
  }

  void _clearQuery() {
    _searchController.clear();
    _setQuery('');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final board = ref.watch(topicBoardProvider);
    final marks =
        ref.watch(importedContentMarksProvider).asData?.value ??
            ImportedContentMarks.empty;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pathId == null ? l10n.topicsTitle : l10n.learningPaths),
        actions: [
          ContextHelpIcon(
            topic: widget.pathId == null ? HelpTopic.topics : HelpTopic.learningPaths,
          ),
        ],
      ),
      body: board.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('$error')),
        data: (data) {
          LearningPathView? path;
          if (widget.pathId != null) {
            for (final item in data.paths) {
              if (item.id == widget.pathId) path = item;
            }
          }
          final searching = _query.trim().isNotEmpty;
          final sections = topicSearchSections(
            groups: data.groups,
            cards: data.cards,
            query: _query,
            newCategoryIds: marks.categoryIds,
            limitToTopicIds: path?.topicIds.toSet(),
          );
          final noResults = searching && sections.isEmpty;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screenPadding,
                  0,
                  AppSpacing.screenPadding,
                  8,
                ),
                child: LexoraSearchField(
                  controller: _searchController,
                  hintText: l10n.searchTopics,
                  onChanged: _setQuery,
                ),
              ),
              Expanded(
                child: noResults
                    ? EmptyState(
                        title: l10n.noTopicsFound,
                        message: '',
                        actionLabel: l10n.clearSearch,
                        onAction: _clearQuery,
                        icon: Icons.search_off_rounded,
                      )
                    : ListView(
                        padding: const EdgeInsets.fromLTRB(
                          AppSpacing.screenPadding,
                          0,
                          AppSpacing.screenPadding,
                          AppSpacing.screenPadding,
                        ),
                        children: [
                          if (widget.pathId == null &&
                              !searching &&
                              data.paths.isNotEmpty) ...[
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
                                separatorBuilder: (_, _) =>
                                    const SizedBox(width: 8),
                                itemBuilder: (context, index) {
                                  final item = data.paths[index];
                                  return ActionChip(
                                    label: Text(
                                      localizedPair(
                                        context,
                                        item.nameEn,
                                        item.nameAr,
                                      ),
                                    ),
                                    onPressed: () => context.push(
                                      '/topics/path/${item.id}',
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: AppSpacing.sectionGap),
                          ],
                          if (path != null) ...[
                            if (!searching) ...[
                              Text(
                                localizedPair(
                                  context,
                                  path.descriptionEn,
                                  path.descriptionAr,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.md),
                            ],
                            for (final section in sections)
                              for (final card in section.cards) ...[
                                _TopicCard(
                                  card: card,
                                  isNew: marks.topicIsNew(card.id),
                                ),
                                const SizedBox(height: 12),
                              ],
                          ] else
                            for (final section in sections) ...[
                              _CategoryHeader(
                                group: section.group,
                                isNew: marks.categoryIsNew(section.group.id),
                                onSeen: () => ref
                                    .read(importedContentMarksProvider.notifier)
                                    .markCategorySeen(section.group.id),
                              ),
                              const SizedBox(height: 8),
                              for (final card in section.cards) ...[
                                _TopicCard(
                                  card: card,
                                  isNew: marks.topicIsNew(card.id),
                                ),
                                const SizedBox(height: 12),
                              ],
                              const SizedBox(height: 8),
                            ],
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _CategoryHeader extends StatelessWidget {
  const _CategoryHeader({
    required this.group,
    required this.isNew,
    required this.onSeen,
  });

  final TopicGroupDataView group;
  final bool isNew;
  final VoidCallback onSeen;

  @override
  Widget build(BuildContext context) {
    final title = Text(
      localizedPair(context, group.nameEn, group.nameAr),
      style: Theme.of(context).textTheme.titleMedium,
    );
    return InkWell(
      onTap: isNew ? onSeen : null,
      child: Row(
        children: [
          Flexible(child: title),
          if (isNew) ...[
            const SizedBox(width: 8),
            const ImportedNewBadge(),
          ],
        ],
      ),
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.card, required this.isNew});

  final TopicCardData card;
  final bool isNew;

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
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        localizedPair(context, card.nameEn, card.nameAr),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    if (isNew) ...[
                      const SizedBox(width: 8),
                      const ImportedNewBadge(),
                    ],
                  ],
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
