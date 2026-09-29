import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/app.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/services/topics/topic_repository.dart';
import '../../../core/widgets/lexora_widgets.dart';
import 'topic_icons.dart';
import 'topic_providers.dart';

class TopicDetailScreen extends ConsumerStatefulWidget {
  const TopicDetailScreen({super.key, required this.topicId});

  final String topicId;

  @override
  ConsumerState<TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends ConsumerState<TopicDetailScreen> {
  String? _cefr;
  TopicWordFilter _filter = TopicWordFilter.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final board = ref.watch(topicBoardProvider);
    final cards = board.asData?.value.cards;
    TopicCardData? card;
    if (cards != null) {
      for (final item in cards) {
        if (item.id == widget.topicId) card = item;
      }
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            card == null
                ? l10n.topicsTitle
                : localizedPair(context, card.nameEn, card.nameAr),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.topicVocabulary),
              Tab(text: l10n.topicSentences),
              Tab(text: l10n.topicProgressTab),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 52,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                children: [
                  for (final level in [null, ...CefrLevel.values.map((e) => e.code)])
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(level ?? l10n.all),
                        selected: _cefr == level,
                        onSelected: (_) => setState(() => _cefr = level),
                      ),
                    ),
                  for (final filter in TopicWordFilter.values)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(_filterLabel(l10n, filter)),
                        selected: _filter == filter,
                        onSelected: (_) => setState(() => _filter = filter),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _WordsTab(
                    topicId: widget.topicId,
                    cefr: _cefr,
                    filter: _filter,
                  ),
                  _SentencesTab(topicId: widget.topicId, cefr: _cefr),
                  _ProgressTab(topicId: widget.topicId),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _filterLabel(AppLocalizations l10n, TopicWordFilter filter) {
    return switch (filter) {
      TopicWordFilter.all => l10n.all,
      TopicWordFilter.locked => l10n.filterLocked,
      TopicWordFilter.discovered => l10n.filterDiscovered,
      TopicWordFilter.learning => l10n.filterLearning,
      TopicWordFilter.reviewing => l10n.filterReviewing,
      TopicWordFilter.mastered => l10n.filterMastered,
    };
  }
}

class _WordsTab extends ConsumerWidget {
  const _WordsTab({
    required this.topicId,
    required this.cefr,
    required this.filter,
  });

  final String topicId;
  final String? cefr;
  final TopicWordFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final words = ref.watch(
      topicWordsProvider((id: topicId, cefr: cefr, filter: filter)),
    );
    final pronunciation = ref.watch(pronunciationServiceProvider);
    final accent = ref.watch(settingsProvider).accent;

    return words.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('$error')),
      data: (items) {
        if (items.isEmpty) {
          return EmptyState(
            title: l10n.topicEmptyWords,
            message: l10n.topicsSubtitle,
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final word = items[index];
            return LexoraCard(
              onTap: () => context.push('/vocabulary/${word.entryId}'),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          word.lemma,
                          textDirection: TextDirection.ltr,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(word.arabicMeaning),
                      ],
                    ),
                  ),
                  CefrBadge(level: word.cefr, compact: true),
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: l10n.listen,
                    onPressed: () => pronunciation.speak(
                      word.lemma,
                      accent: accent,
                    ),
                    icon: const Icon(Icons.volume_up_rounded),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _SentencesTab extends ConsumerWidget {
  const _SentencesTab({required this.topicId, required this.cefr});

  final String topicId;
  final String? cefr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final sentences = ref.watch(
      topicSentencesProvider((id: topicId, cefr: cefr)),
    );
    final pronunciation = ref.watch(pronunciationServiceProvider);
    final accent = ref.watch(settingsProvider).accent;

    return sentences.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('$error')),
      data: (items) {
        if (items.isEmpty) {
          return EmptyState(
            title: l10n.topicEmptySentences,
            message: l10n.topicsSubtitle,
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final sentence = items[index];
            return LexoraCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CefrBadge(level: sentence.cefr, compact: true),
                      const Spacer(),
                      IconButton(
                        tooltip: l10n.listen,
                        onPressed: () => pronunciation.speak(
                          sentence.sentenceEn,
                          accent: accent,
                        ),
                        icon: const Icon(Icons.volume_up_rounded),
                      ),
                    ],
                  ),
                  Text(
                    sentence.sentenceEn,
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(sentence.sentenceAr),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ProgressTab extends ConsumerWidget {
  const _ProgressTab({required this.topicId});

  final String topicId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final progress = ref.watch(topicProgressProvider(topicId));
    return progress.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('$error')),
      data: (data) {
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          children: [
            Text(l10n.catalogStatsNote),
            const SizedBox(height: 12),
            LexoraCard(
              child: Column(
                children: [
                  _Row(label: l10n.topicVocabulary, value: '${data.total}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterLocked, value: '${data.locked}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterDiscovered, value: '${data.discovered}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterLearning, value: '${data.learning}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterReviewing, value: '${data.reviewing}'),
                  const Divider(height: 24),
                  _Row(label: l10n.filterMastered, value: '${data.mastered}'),
                  const Divider(height: 24),
                  _Row(
                    label: l10n.discoveredThisWeek,
                    value: '${data.discoveredThisWeek}',
                  ),
                  const Divider(height: 24),
                  _Row(
                    label: l10n.topicProgressTab,
                    value: '${(data.progress * 100).round()}%',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            LexoraCard(
              child: Column(
                children: [
                  for (final level in data.levels) ...[
                    _Row(
                      label: level.level,
                      value: l10n.topicDiscoveredOf(level.unlocked, level.total),
                    ),
                    if (level != data.levels.last) const Divider(height: 24),
                  ],
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label)),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
