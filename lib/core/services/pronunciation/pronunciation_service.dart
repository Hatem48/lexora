import '../../constants/enums.dart';

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
