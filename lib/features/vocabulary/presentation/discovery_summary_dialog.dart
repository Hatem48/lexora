import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../core/services/vocabulary/vocabulary_discovery_repository.dart';
import '../../../core/widgets/lexora_widgets.dart';

Future<void> showDiscoverySummary(
  BuildContext context,
  DiscoverySummary summary,
) {
  final l10n = AppLocalizations.of(context);
  return showDialog<void>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          summary.newCount == 0
              ? l10n.noNewWords
              : l10n.newWordsDiscovered(summary.newCount),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.blogStatsLine(
                  summary.tokenCount,
                  summary.uniqueClassified,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final entry in summary.cefrDistribution.entries)
                    CefrBadge(level: entry.key, compact: true),
                ],
              ),
              if (summary.detectedTopics.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(l10n.detectedTopics),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final topic in summary.detectedTopics)
                      ActionChip(
                        label: Text(
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? topic.nameAr
                              : topic.nameEn,
                        ),
                        onPressed: () => context.push('/topics/${topic.topicId}'),
                      ),
                  ],
                ),
              ],
              if (summary.newlyDiscovered.isNotEmpty) ...[
                const SizedBox(height: 16),
                for (final word in summary.newlyDiscovered)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(word.lemma),
                    trailing: CefrBadge(level: word.cefr, compact: true),
                    onTap: () => context.push('/vocabulary/${word.entryId}'),
                  ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.done),
          ),
        ],
      );
    },
  );
}
