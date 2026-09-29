import '../../constants/enums.dart';

/// Picks the clearest installed English voice for the selected accent.
/// Prefers neural / enhanced / premium voices when the device has them.
int scoreVoice(Map<dynamic, dynamic> voice, PronunciationAccent accent) {
  final locale = (voice['locale'] ?? '').toString().replaceAll('_', '-');
  final lower = locale.toLowerCase();
  if (!lower.startsWith('en')) return -1;

  final want = accent == PronunciationAccent.british ? 'en-gb' : 'en-us';
  var score = lower.startsWith(want) ? 20 : 6;

  final name = (voice['name'] ?? '').toString().toLowerCase();
  const premium = ['neural', 'wavenet', 'enhanced', 'premium', 'natural'];
  if (premium.any(name.contains)) score += 30;

  final quality = (voice['quality'] ?? voice['network_connection_required'])
      .toString()
      .toLowerCase();
  if (quality.contains('very high') || quality == 'high') score += 12;
  if (quality == 'true') score += 4;

  return score;
}

Map<String, String>? bestVoice(
  List<dynamic> voices,
  PronunciationAccent accent,
) {
  Map<String, String>? winner;
  var best = -1;
  for (final raw in voices) {
    if (raw is! Map) continue;
    final score = scoreVoice(raw, accent);
    if (score > best) {
      final name = raw['name']?.toString();
      final locale = raw['locale']?.toString();
      if (name == null || locale == null || name.isEmpty || locale.isEmpty) {
        continue;
      }
      best = score;
      winner = {'name': name, 'locale': locale};
    }
  }
  return winner;
}
