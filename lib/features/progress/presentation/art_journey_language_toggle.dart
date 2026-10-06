import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/settings_provider.dart';
import 'art_journey_language_controller.dart';

/// Switches Art Journey copy only. Labels stay English | العربية.
class ArtJourneyLanguageToggle extends ConsumerWidget {
  const ArtJourneyLanguageToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(artJourneyLanguageProvider).asData?.value;
    final fallback = ref.watch(settingsProvider).localeCode == 'ar' ? 'ar' : 'en';
    final selected = saved ?? fallback;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SegmentedButton<String>(
        style: const ButtonStyle(
          visualDensity: VisualDensity.compact,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        segments: const [
          ButtonSegment(
            value: 'en',
            label: Text('English', textDirection: TextDirection.ltr),
          ),
          ButtonSegment(
            value: 'ar',
            label: Text('العربية', textDirection: TextDirection.rtl),
          ),
        ],
        selected: {selected},
        onSelectionChanged: (value) {
          ref.read(artJourneyLanguageProvider.notifier).select(value.first);
        },
      ),
    );
  }
}
