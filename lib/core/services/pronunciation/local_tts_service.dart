import 'package:flutter_tts/flutter_tts.dart';

import '../../constants/enums.dart';
import 'pronunciation_service.dart';

/// Device TTS fallback. Replace/augment with RemoteNeuralTtsService later.
class LocalTtsService implements PronunciationService {
  LocalTtsService({FlutterTts? tts}) : _tts = tts ?? FlutterTts();

  final FlutterTts _tts;
  bool _ready = false;

  Future<void> _ensureReady() async {
    if (_ready) return;
    await _tts.setSharedInstance(true);
    await _tts.awaitSpeakCompletion(true);
    _ready = true;
  }

  @override
  Future<void> speak(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  }) async {
    await _ensureReady();
    final locale = accent == PronunciationAccent.british ? 'en-GB' : 'en-US';
    await _tts.setLanguage(locale);
    await _tts.setSpeechRate(speed.rate);
    await _tts.setPitch(1.0);
    await _tts.speak(text);
  }

  @override
  Future<void> stop() => _tts.stop();

  @override
  Future<bool> isCached(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  }) async =>
      false;

  @override
  Future<String?> cacheAudio(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  }) async =>
      null;

  @override
  Future<void> dispose() async {
    await _tts.stop();
  }
}
