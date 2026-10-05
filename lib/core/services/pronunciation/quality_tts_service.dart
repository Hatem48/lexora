import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../constants/enums.dart';
import 'pronunciation_service.dart';
import 'voice_ranker.dart';

/// Device TTS that prefers the clearest English voice installed
/// (neural / enhanced / premium when available) and replays cached audio.
class QualityTtsService implements PronunciationService {
  QualityTtsService({FlutterTts? tts, AudioPlayer? player})
      : _tts = tts ?? FlutterTts(),
        _player = player ?? AudioPlayer();

  final FlutterTts _tts;
  final AudioPlayer _player;
  bool _ready = false;
  PronunciationAccent? _appliedAccent;

  Future<void> _ensureReady(PronunciationAccent accent) async {
    if (!_ready) {
      await _tts.setSharedInstance(true);
      await _tts.awaitSpeakCompletion(true);
      _ready = true;
    }
    if (_appliedAccent == accent) return;
    final locale = accent == PronunciationAccent.british ? 'en-GB' : 'en-US';
    await _tts.setLanguage(locale);
    try {
      final voices = await _tts.getVoices;
      if (voices is List) {
        final best = bestVoice(voices, accent);
        if (best != null) {
          await _tts.setVoice(best);
        }
      }
    } catch (e) {
      if (kDebugMode) debugPrint('Voice selection skipped: $e');
    }
    _appliedAccent = accent;
  }

  String _fileKey(String text, PronunciationAccent accent, PlaybackSpeed speed) {
    final raw = '$text|${accent.storageValue}|${speed.name}|calm-rate';
    return base64Url.encode(utf8.encode(raw)).replaceAll('=', '');
  }

  Future<File> _cacheFile(
    String text,
    PronunciationAccent accent,
    PlaybackSpeed speed,
  ) async {
    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory(p.join(dir.path, 'pronunciation'));
    if (!folder.existsSync()) await folder.create(recursive: true);
    return File(p.join(folder.path, '${_fileKey(text, accent, speed)}.wav'));
  }

  @override
  Future<bool> isCached(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  }) async {
    final file = await _cacheFile(text, accent, speed);
    return file.existsSync() && file.lengthSync() > 0;
  }

  @override
  Future<String?> cacheAudio(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  }) async {
    final existing = await _cacheFile(text, accent, speed);
    if (existing.existsSync() && existing.lengthSync() > 0) {
      return existing.path;
    }
    await _ensureReady(accent);
    await _tts.setSpeechRate(
      speechRateFor(speed, platform: defaultTargetPlatform),
    );
    final result = await _tts.synthesizeToFile(text, existing.path);
    if (existing.existsSync() && existing.lengthSync() > 0) {
      return existing.path;
    }
    if (kDebugMode) debugPrint('synthesizeToFile returned $result');
    return null;
  }

  @override
  Future<void> speak(
    String text, {
    PronunciationAccent accent = PronunciationAccent.american,
    PlaybackSpeed speed = PlaybackSpeed.normal,
  }) async {
    await stop();
    final cached = await cacheAudio(text, accent: accent, speed: speed);
    if (cached != null) {
      await _player.play(DeviceFileSource(cached));
      return;
    }
    await _ensureReady(accent);
    await _tts.setSpeechRate(
      speechRateFor(speed, platform: defaultTargetPlatform),
    );
    await _tts.setPitch(1.0);
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    await _tts.stop();
  }

  @override
  Future<void> dispose() async {
    await stop();
    await _player.dispose();
  }
}
