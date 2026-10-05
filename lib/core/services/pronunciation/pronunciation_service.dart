import 'package:flutter/foundation.dart';

import '../../constants/enums.dart';

/// iOS treats 0.5 as normal and 1.0 as the fastest. Android treats 1.0 as normal.
double speechRateFor(
  PlaybackSpeed speed, {
  TargetPlatform platform = TargetPlatform.android,
}) {
  final apple =
      platform == TargetPlatform.iOS || platform == TargetPlatform.macOS;
  return switch (speed) {
    PlaybackSpeed.normal => apple ? 0.40 : 0.78,
    PlaybackSpeed.slow => apple ? 0.28 : 0.50,
  };
}

/// Abstraction for pronunciation playback.
/// UI must depend on this — never a concrete TTS provider.
abstract class PronunciationService {
  Future<void> speak(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  });

  Future<void> stop();

  Future<bool> isCached(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  });

  /// Generate/download high-quality audio for offline reuse.
  Future<String?> cacheAudio(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  });

  Future<void> dispose();
}
