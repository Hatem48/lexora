import 'package:flutter/material.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/services/topics/topic_question_payload.dart';
import '../../../core/widgets/lexora_widgets.dart';

class TopicQuestionCard extends StatefulWidget {
  const TopicQuestionCard({
    super.key,
    required this.promptEn,
    required this.promptAr,
    required this.payload,
    required this.answerController,
    required this.onSubmit,
  });

  final String promptEn;
  final String promptAr;
  final TopicQuestionPayload payload;
  final TextEditingController answerController;
  final VoidCallback onSubmit;

  @override
  State<TopicQuestionCard> createState() => _TopicQuestionCardState();
}

class _TopicQuestionCardState extends State<TopicQuestionCard> {
  var _revealed = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final answers = widget.payload.suggestedAnswers;
    final motion = MediaQuery.disableAnimationsOf(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.promptEn.trim().isNotEmpty) ...[
          Text(l10n.englishQuestion, style: theme.textTheme.labelMedium),
          const SizedBox(height: 4),
          LtrText(widget.promptEn, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (widget.promptAr.trim().isNotEmpty) ...[
          Text(l10n.arabicQuestion, style: theme.textTheme.labelMedium),
          const SizedBox(height: 4),
          Text(
            widget.promptAr,
            textDirection: TextDirection.rtl,
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (widget.payload.type == 'multiple_choice')
          for (final option in widget.payload.options) ...[
            if (option.en.trim().isNotEmpty)
              LtrText('${option.id}. ${option.en}'),
            if (option.ar.trim().isNotEmpty)
              Text(
                '${option.id}. ${option.ar}',
                textDirection: TextDirection.rtl,
              ),
            const SizedBox(height: 4),
          ],
        TextField(
          controller: widget.answerController,
          textDirection: TextDirection.ltr,
          minLines: 2,
          maxLines: 4,
          decoration: InputDecoration(labelText: l10n.yourAnswer),
        ),
        if (widget.payload.hasSuggestedAnswer) ...[
          const SizedBox(height: 8),
          OutlinedButton(
            onPressed: () => setState(() => _revealed = !_revealed),
            child: Text(_revealed ? l10n.hideAnswer : l10n.showAnswer),
          ),
          AnimatedSize(
            duration: motion ? Duration.zero : const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: _revealed
                ? Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l10n.suggestedAnswer,
                          style: theme.textTheme.labelMedium,
                        ),
                        if (answers.en.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            l10n.englishAnswer,
                            style: theme.textTheme.labelMedium,
                          ),
                          const SizedBox(height: 2),
                          LtrText(answers.en),
                        ],
                        if (answers.ar.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            l10n.arabicAnswer,
                            style: theme.textTheme.labelMedium,
                          ),
                          const SizedBox(height: 2),
                          Text(answers.ar, textDirection: TextDirection.rtl),
                        ],
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity),
          ),
        ],
        const SizedBox(height: 8),
        LexoraPrimaryButton(
          label: l10n.submitAnswer,
          onPressed: widget.onSubmit,
        ),
      ],
    );
  }
}
