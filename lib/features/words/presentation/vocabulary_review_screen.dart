import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../../progress/presentation/catalog_progress_section.dart';
import '../data/vocabulary_correction_store.dart';
import '../domain/vocabulary_correction.dart';

final vocabularyReviewQueueProvider =
    FutureProvider<List<VocabularyReviewIssue>>((ref) async {
  return VocabularyCorrectionStore(ref.watch(appDatabaseProvider)).currentQueue();
});

class VocabularyReviewScreen extends ConsumerStatefulWidget {
  const VocabularyReviewScreen({super.key});

  @override
  ConsumerState<VocabularyReviewScreen> createState() =>
      _VocabularyReviewScreenState();
}

class _VocabularyReviewScreenState extends ConsumerState<VocabularyReviewScreen> {
  List<VocabularyReviewIssue> _issues = const [];
  var _loading = true;
  var _version = 1;
  var _spellingFixed = 0;
  var _meaningsImproved = 0;
  var _kept = 0;
  var _seen = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final store = VocabularyCorrectionStore(ref.read(appDatabaseProvider));
    await store.ensureScanned();
    final queue = await store.currentQueue();
    final version = await store.storedVersion();
    if (!mounted) return;
    setState(() {
      _version = version;
      _issues = queue;
      _seen = queue.isEmpty ? 0 : 1;
      _loading = false;
    });
    _refresh();
  }

  void _refresh() {
    ref.invalidate(vocabularyReviewQueueProvider);
    ref.invalidate(catalogProgressProvider);
  }

  Future<void> _choose(ReviewCandidate candidate) async {
    final issue = _issues.first;
    final store = VocabularyCorrectionStore(ref.read(appDatabaseProvider));
    final next = await store.applyCandidate(
      issue: issue,
      candidate: candidate,
      version: _version,
    );
    if (!mounted) return;
    setState(() {
      if (issue.kind == VocabularyReviewKind.spelling) {
        _spellingFixed++;
      } else {
        _meaningsImproved++;
      }
      _issues = next;
      if (next.isNotEmpty) _seen++;
    });
    _refresh();
  }

  Future<void> _keep() async {
    final issue = _issues.first;
    final store = VocabularyCorrectionStore(ref.read(appDatabaseProvider));
    final next = await store.keepOriginal(issue: issue, version: _version);
    if (!mounted) return;
    setState(() {
      _kept++;
      _issues = next;
      if (next.isNotEmpty) _seen++;
    });
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.wordReviewNoticeTitle)),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _issues.isEmpty
              ? _done(l10n)
              : _card(l10n, _issues.first),
    );
  }

  Widget _done(AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      children: [
        Text(l10n.wordReviewDone, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: AppSpacing.md),
        Text(l10n.wordReviewSpellingFixed(_spellingFixed)),
        Text(l10n.wordReviewMeaningsImproved(_meaningsImproved)),
        Text(l10n.wordReviewKept(_kept)),
      ],
    );
  }

  Widget _card(AppLocalizations l10n, VocabularyReviewIssue issue) {
    final total = _seen + _issues.length - 1;
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPadding),
      children: [
        Text(l10n.wordReviewProgress(_seen, total)),
        const SizedBox(height: AppSpacing.md),
        LexoraCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                issue.kind == VocabularyReviewKind.spelling
                    ? l10n.wordMayBeMisspelled
                    : l10n.wordMeaningImprovement,
              ),
              const SizedBox(height: AppSpacing.sm),
              LtrText(
                issue.written,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (issue.currentArabic.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(l10n.wordCurrentMeaning),
                RtlText(issue.currentArabic),
              ],
              if (issue.kind == VocabularyReviewKind.content &&
                  issue.currentExampleEn.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(l10n.wordCurrentExample),
                LtrText(issue.currentExampleEn),
                if (issue.currentExampleAr.isNotEmpty) RtlText(issue.currentExampleAr),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (issue.kind == VocabularyReviewKind.spelling)
          Text(l10n.wordDidYouMean),
        for (final candidate in issue.candidates) ...[
          const SizedBox(height: AppSpacing.sm),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
            onPressed: () => _choose(candidate),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LtrText(candidate.lemma),
                if (candidate.arabic.isNotEmpty) RtlText(candidate.arabic),
                if (issue.kind == VocabularyReviewKind.content &&
                    candidate.exampleEn.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(l10n.wordSuggestedExample),
                  LtrText(candidate.exampleEn),
                  if (candidate.exampleAr.isNotEmpty) RtlText(candidate.exampleAr),
                ],
              ],
            ),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        TextButton(
          onPressed: _keep,
          child: Text(l10n.wordKeepOriginal(issue.written)),
        ),
      ],
    );
  }
}
