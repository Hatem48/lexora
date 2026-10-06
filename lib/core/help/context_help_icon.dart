import 'package:flutter/material.dart';

import '../../app/theme/app_spacing.dart';
import 'help_catalog.dart';

class ContextHelpIcon extends StatelessWidget {
  const ContextHelpIcon({super.key, required this.topic, this.languageCode});

  final HelpTopic topic;
  final String? languageCode;

  @override
  Widget build(BuildContext context) {
    final entry = HelpCatalog.of(topic, languageCode: languageCode);
    return IconButton(
      tooltip: entry.title,
      visualDensity: VisualDensity.compact,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
      icon: Icon(
        Icons.help_outline,
        size: 18,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      onPressed: () => showHelpSheet(context, topic, languageCode: languageCode),
    );
  }
}

Future<void> showHelpSheet(
  BuildContext context,
  HelpTopic topic, {
  String? languageCode,
}) {
  final entry = HelpCatalog.of(topic, languageCode: languageCode);
  final english = languageCode == 'en';
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return Directionality(
        textDirection: english ? TextDirection.ltr : TextDirection.rtl,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(entry.body, style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        ),
      );
    },
  );
}
