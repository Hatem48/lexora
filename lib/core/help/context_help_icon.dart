import 'package:flutter/material.dart';

import '../../app/theme/app_spacing.dart';
import 'help_catalog.dart';

class ContextHelpIcon extends StatelessWidget {
  const ContextHelpIcon({super.key, required this.topic});

  final HelpTopic topic;

  @override
  Widget build(BuildContext context) {
    final entry = HelpCatalog.of(topic);
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
      onPressed: () => showHelpSheet(context, topic),
    );
  }
}

Future<void> showHelpSheet(BuildContext context, HelpTopic topic) {
  final entry = HelpCatalog.of(topic);
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (context) {
      return Directionality(
        textDirection: TextDirection.rtl,
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
