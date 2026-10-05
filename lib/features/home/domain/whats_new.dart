const whatsNewSeenKey = 'lexora_whats_new_seen';

String whatsNewIdentity({required String version, required String buildNumber}) {
  return '${version.trim()}+${buildNumber.trim()}';
}

bool shouldShowWhatsNew({required String? seen, required String current}) {
  final next = current.trim();
  if (next.isEmpty || next == '+') return false;
  return seen != next;
}
