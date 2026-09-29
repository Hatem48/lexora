import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lexora/l10n/app_localizations.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../../app/app.dart';
import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/widgets/lexora_widgets.dart';
import '../domain/speaking_practice_service.dart';

final speakingSentencesProvider = StreamProvider<List<SentenceRow>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.sentences)
        ..orderBy([
          (t) => OrderingTerm.asc(t.hasPronunciationPractice),
          (t) => OrderingTerm.desc(t.createdAt),
        ]))
      .watch();
});

class SpeakingScreen extends ConsumerStatefulWidget {
  const SpeakingScreen({super.key, this.sentenceId});

  final String? sentenceId;

  @override
  ConsumerState<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends ConsumerState<SpeakingScreen> {
  final _recorder = AudioRecorder();
  final _player = AudioPlayer();
  int _index = 0;
  bool _recording = false;
  String? _recordingPath;
  bool _busy = false;

  @override
  void dispose() {
    _recorder.dispose();
    _player.dispose();
    super.dispose();
  }

  SentenceRow? _current(List<SentenceRow> items) {
    if (items.isEmpty) return null;
    if (widget.sentenceId != null) {
      for (final item in items) {
        if (item.id == widget.sentenceId) return item;
      }
    }
    return items[_index.clamp(0, items.length - 1)];
  }

  Future<void> _listen(SentenceRow sentence) async {
    final settings = ref.read(settingsProvider);
    await ref.read(pronunciationServiceProvider).speak(
          sentence.sentence,
          accent: settings.accent,
          speed: settings.playbackSpeed,
        );
  }

  Future<void> _toggleRecord() async {
    if (_recording) {
      final path = await _recorder.stop();
      setState(() {
        _recording = false;
        _recordingPath = path;
      });
      return;
    }

    final allowed = await _recorder.hasPermission();
    if (!allowed) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.microphonePermissionDenied)),
      );
      return;
    }

    final dir = await getTemporaryDirectory();
    final path = p.join(
      dir.path,
      'lexora_practice_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
    await _recorder.start(const RecordConfig(encoder: AudioEncoder.aacLc), path: path);
    setState(() {
      _recording = true;
      _recordingPath = null;
    });
  }

  Future<void> _playRecording() async {
    final path = _recordingPath;
    if (path == null || !File(path).existsSync()) return;
    await _player.stop();
    await _player.play(DeviceFileSource(path));
  }

  Future<void> _markPracticed(SentenceRow sentence) async {
    setState(() => _busy = true);
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.sentences)..where((t) => t.id.equals(sentence.id))).write(
      SentencesCompanion(
        hasPronunciationPractice: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );

    final path = _recordingPath;
    if (path != null) {
      final scorer = PlaceholderSpeakingPracticeService();
      await scorer.evaluate(targetText: sentence.sentence, recordingPath: path);
    }

    if (!mounted) return;
    setState(() => _busy = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).markedPracticed)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final async = ref.watch(speakingSentencesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.speakingPractice)),
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => EmptyState(
          title: l10n.errorGeneric,
          message: e.toString(),
        ),
        data: (items) {
          final sentence = _current(items);
          if (sentence == null) {
            return EmptyState(
              title: l10n.noSentencesYet,
              message: l10n.noSentencesYetMessage,
              icon: Icons.mic_none_rounded,
            );
          }
          final position = items.indexWhere((s) => s.id == sentence.id);
          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              Text(
                l10n.speakingHint,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: AppSpacing.lg),
              LexoraCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LtrText(sentence.sentence, style: theme.textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.sm),
                    RtlText(
                      sentence.arabicTranslation,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    CefrBadge(level: sentence.cefrLevel),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              LexoraPrimaryButton(
                label: l10n.listen,
                icon: Icons.volume_up_rounded,
                onPressed: () => _listen(sentence),
              ),
              const SizedBox(height: AppSpacing.sm),
              LexoraPrimaryButton(
                label: _recording ? l10n.stopRecording : l10n.record,
                icon: _recording ? Icons.stop_rounded : Icons.mic_rounded,
                onPressed: _toggleRecord,
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: _recordingPath == null ? null : _playRecording,
                icon: const Icon(Icons.play_arrow_rounded),
                label: Text(l10n.playRecording),
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                onPressed: _busy ? null : () => _markPracticed(sentence),
                icon: const Icon(Icons.check_rounded),
                label: Text(l10n.markPracticed),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.scoringUnavailable,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  IconButton(
                    onPressed: position <= 0
                        ? null
                        : () => setState(() {
                              _index = position - 1;
                              _recordingPath = null;
                            }),
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  Expanded(
                    child: Text(
                      '${position + 1} / ${items.length}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: position >= items.length - 1
                        ? null
                        : () => setState(() {
                              _index = position + 1;
                              _recordingPath = null;
                            }),
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
