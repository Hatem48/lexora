/// Placeholder for future speech scoring.
/// Do not fabricate accuracy scores.
abstract class SpeakingPracticeService {
  Future<SpeakingAttemptResult> evaluate({
    required String targetText,
    required String recordingPath,
  });
}

class SpeakingAttemptResult {
  const SpeakingAttemptResult({
    required this.available,
    this.message =
        'Pronunciation scoring will be available in a future update.',
  });

  final bool available;
  final String message;
}

class PlaceholderSpeakingPracticeService implements SpeakingPracticeService {
  @override
  Future<SpeakingAttemptResult> evaluate({
    required String targetText,
    required String recordingPath,
  }) async {
    return const SpeakingAttemptResult(available: false);
  }
}
