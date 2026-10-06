import 'dart:math' as math;
import 'dart:ui';

const artCanvasColor = Color(0xFFF4F7FB);

/// Bottom fade uses the same canvas color so an empty painting stays cool neutral.
const artCanvasScrim = Color(0xD9F4F7FB);

const paintPalette = <Color>[
  Color(0xFF06135F),
  Color(0xFF071D83),
  Color(0xFF0036B5),
  Color(0xFF0057D9),
  Color(0xFF0089E6),
  Color(0xFF00B6DF),
  Color(0xFF32CDE5),
  Color(0xFF72DFEB),
  Color(0xFFFFE32C),
  Color(0xFFFFD000),
  Color(0xFFFFB300),
  Color(0xFFFF9400),
  Color(0xFFFF7200),
  Color(0xFFFF4A18),
  Color(0xFFF32625),
  Color(0xFFEF164F),
  Color(0xFFEE006D),
  Color(0xFFF01583),
  Color(0xFFC00082),
  Color(0xFF8E007B),
  Color(0xFF60007D),
  Color(0xFF35106F),
];

double artProgressFraction({required int mastered, required int total}) {
  if (mastered <= 0 || total <= 0) return 0;
  if (mastered >= total) return 1;
  return mastered / total;
}

/// FNV-1a. Stable across runs and platforms, unlike [String.hashCode].
int stableHash(String value) {
  var hash = 2166136261;
  for (final unit in value.codeUnits) {
    hash ^= unit;
    hash = (hash * 16777619) & 0x7fffffff;
  }
  return hash;
}

class CatalogWordPaintStatus {
  const CatalogWordPaintStatus({
    required this.id,
    required this.level,
    required this.status,
  });

  final String id;
  final String level;
  final String status;
}

/// Mastered catalog words of [level] only. Discovered and learning add nothing.
List<String> masteredIdsForLevel(
  String level,
  Iterable<CatalogWordPaintStatus> words,
) {
  final code = level.toUpperCase();
  final ids = [
    for (final word in words)
      if (word.level.toUpperCase() == code && word.status == 'mastered') word.id,
  ];
  ids.sort();
  return ids;
}

class PaintBlob {
  const PaintBlob({
    required this.entryId,
    required this.level,
    required this.x,
    required this.y,
    required this.color,
    required this.baseSize,
    required this.stretch,
    required this.rotation,
    required this.opacity,
    required this.noiseX,
    required this.noiseY,
    required this.layer,
  });

  final String entryId;
  final String level;
  final double x;
  final double y;
  final Color color;
  final double baseSize;
  final double stretch;
  final double rotation;
  final double opacity;
  final List<double> noiseX;
  final List<double> noiseY;
  final int layer;

  int get pointCount => noiseX.length;
}

PaintBlob paintBlobFor({required String level, required String entryId}) {
  final code = level.toUpperCase();
  final key = '$code:$entryId';
  return _blobCache.putIfAbsent(key, () => _createBlob(code, entryId));
}

/// One blob per mastered catalog entry. Duplicate ids still count once.
List<PaintBlob> paintBlobsFor({
  required String level,
  required List<String> masteredEntryIds,
}) {
  final unique = masteredEntryIds.toSet().toList()..sort();
  final blobs = [
    for (final id in unique) paintBlobFor(level: level, entryId: id),
  ];
  blobs.sort((a, b) {
    final byLayer = a.layer.compareTo(b.layer);
    if (byLayer != 0) return byLayer;
    return a.entryId.compareTo(b.entryId);
  });
  return blobs;
}

final Map<String, PaintBlob> _blobCache = {};

PaintBlob _createBlob(String level, String entryId) {
  final rng = _StableRng(stableHash('$level:$entryId'));
  final towardCenter = rng.nextDouble() < 0.18;
  var x = 0.02 + rng.nextDouble() * 0.96;
  var y = 0.02 + rng.nextDouble() * 0.96;
  if (towardCenter) {
    x = 0.5 + (x - 0.5) * 0.72;
    y = 0.5 + (y - 0.5) * 0.72;
  }
  final color = paintPalette[(rng.nextDouble() * paintPalette.length).floor()];
  final baseSize = 5 + rng.nextDouble() * 11;
  final stretch = 0.8 + rng.nextDouble() * 2.3;
  final rotation = rng.nextDouble() * math.pi * 2;
  final opacity = 0.86 + rng.nextDouble() * 0.14;
  final pointCount = 8 + (rng.nextDouble() * 5).floor();
  final noiseX = List<double>.generate(
    pointCount,
    (_) => 0.78 + rng.nextDouble() * 0.42,
  );
  final noiseY = List<double>.generate(
    pointCount,
    (_) => 0.78 + rng.nextDouble() * 0.42,
  );
  return PaintBlob(
    entryId: entryId,
    level: level,
    x: x,
    y: y,
    color: color,
    baseSize: baseSize,
    stretch: stretch,
    rotation: rotation,
    opacity: opacity,
    noiseX: noiseX,
    noiseY: noiseY,
    layer: stableHash('$level:$entryId:layer'),
  );
}

class _StableRng {
  _StableRng(int seed) : _state = seed & 0x7fffffff;

  int _state;

  double nextDouble() {
    var x = _state == 0 ? 1 : _state;
    x ^= (x << 13) & 0x7fffffff;
    x ^= x >> 17;
    x = (x ^ ((x << 5) & 0x7fffffff)) & 0x7fffffff;
    if (x == 0) x = 1;
    _state = x;
    return x / 2147483648.0;
  }
}

String levelArtPath(String level) => '/progress/level/${level.toUpperCase()}';

/// Every previous level stays open. Vocabulary progress never locks history.
bool levelArtIsOpen(String level) {
  const known = {'A1', 'A2', 'B1', 'B2', 'C1', 'C2'};
  return known.contains(level.toUpperCase());
}
