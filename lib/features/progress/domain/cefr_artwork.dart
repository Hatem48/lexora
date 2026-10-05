import 'dart:math' as math;
import 'dart:ui';

/// How many organic reveal regions a level painting uses.
/// Enough to feel gradual, few enough to paint in one canvas pass.
const cefrArtRegionCount = 180;

/// Mastered catalog words only. Discovery and learning do not count.
double artProgressFraction({required int mastered, required int total}) {
  if (mastered <= 0 || total <= 0) return 0;
  if (mastered >= total) return 1;
  return mastered / total;
}

/// Regions revealed for [mastered] of [total]. Same inputs always match.
int visibleArtRegions({
  required int mastered,
  required int total,
  int regions = cefrArtRegionCount,
}) {
  if (regions <= 0 || mastered <= 0 || total <= 0) return 0;
  if (mastered >= total) return regions;
  final count = (regions * mastered / total).round();
  if (count < 1) return 1;
  if (count > regions) return regions;
  return count;
}

int stableHash(String value) {
  var hash = 2166136261;
  for (final unit in value.codeUnits) {
    hash ^= unit;
    hash = (hash * 16777619) & 0x7fffffff;
  }
  return hash;
}

class ArtRegion {
  const ArtRegion({
    required this.order,
    required this.x,
    required this.y,
    required this.rx,
    required this.ry,
    required this.rotation,
  });

  final int order;
  final double x;
  final double y;
  final double rx;
  final double ry;
  final double rotation;
}

/// Scattered soft masks. Order is shuffled by the level seed, not left to right.
List<ArtRegion> artRegionsFor(String level) {
  return _regionCache.putIfAbsent(level.toUpperCase(), () {
    final code = level.toUpperCase();
    final random = math.Random(stableHash('lexora-art-mask-$code'));
    const columns = 15;
    const rows = 12;
    final drafted = <ArtRegion>[];
    for (var row = 0; row < rows; row++) {
      for (var column = 0; column < columns; column++) {
        final jitterX = (random.nextDouble() - 0.5) * 0.045;
        final jitterY = (random.nextDouble() - 0.5) * 0.05;
        drafted.add(
          ArtRegion(
            order: 0,
            x: ((column + 0.5) / columns + jitterX).clamp(0.02, 0.98),
            y: ((row + 0.5) / rows + jitterY).clamp(0.02, 0.98),
            rx: 0.055 + random.nextDouble() * 0.03,
            ry: 0.06 + random.nextDouble() * 0.035,
            rotation: (random.nextDouble() - 0.5) * 1.2,
          ),
        );
      }
    }
    final ranked = [...drafted]..sort((a, b) {
        final left = stableHash('$code:${a.x.toStringAsFixed(4)}:${a.y.toStringAsFixed(4)}');
        final right = stableHash('$code:${b.x.toStringAsFixed(4)}:${b.y.toStringAsFixed(4)}');
        return left.compareTo(right);
      });
    return [
      for (var index = 0; index < ranked.length; index++)
        ArtRegion(
          order: index,
          x: ranked[index].x,
          y: ranked[index].y,
          rx: ranked[index].rx,
          ry: ranked[index].ry,
          rotation: ranked[index].rotation,
        ),
    ];
  });
}

final Map<String, List<ArtRegion>> _regionCache = {};

/// Scene anchors are the swappable art content. The reveal mask does not change
/// when a level's shapes are replaced, or later when a local image is used.
class SceneAnchor {
  const SceneAnchor({
    required this.x,
    required this.y,
    required this.w,
    required this.h,
    required this.kind,
    required this.color,
  });

  final double x;
  final double y;
  final double w;
  final double h;
  final int kind;
  final Color color;
}

List<SceneAnchor> sceneAnchorsFor(String level) {
  final code = level.toUpperCase();
  return switch (code) {
    'A1' => _a1,
    'A2' => _a2,
    'B1' => _b1,
    'B2' => _b2,
    'C1' => _c1,
    _ => _c2,
  };
}

const _sky = Color(0xFF8EB6FF);
const _sun = Color(0xFFFFD37A);
const _hill = Color(0xFF3D8F6E);
const _deep = Color(0xFF1E3A8A);
const _water = Color(0xFF5BA7D6);
const _stone = Color(0xFF64748B);
const _dusk = Color(0xFF6D5BD0);

const _a1 = [
  SceneAnchor(x: 0, y: 0, w: 1, h: 0.72, kind: 0, color: Color(0xFFD7E7FF)),
  SceneAnchor(x: 0.68, y: 0.16, w: 0.22, h: 0.22, kind: 1, color: _sun),
  SceneAnchor(x: 0, y: 0.62, w: 1, h: 0.38, kind: 2, color: _hill),
];

const _a2 = [
  SceneAnchor(x: 0, y: 0, w: 1, h: 0.62, kind: 0, color: _sky),
  SceneAnchor(x: 0.12, y: 0.18, w: 0.16, h: 0.16, kind: 1, color: _sun),
  SceneAnchor(x: -0.05, y: 0.48, w: 0.7, h: 0.28, kind: 2, color: Color(0xFF2F8F62)),
  SceneAnchor(x: 0.4, y: 0.52, w: 0.7, h: 0.24, kind: 2, color: _hill),
  SceneAnchor(x: 0, y: 0.72, w: 1, h: 0.28, kind: 0, color: _water),
];

const _b1 = [
  SceneAnchor(x: 0, y: 0, w: 1, h: 0.55, kind: 0, color: Color(0xFFB9D4FF)),
  SceneAnchor(x: 0.08, y: 0.38, w: 0.12, h: 0.34, kind: 3, color: _stone),
  SceneAnchor(x: 0.24, y: 0.28, w: 0.16, h: 0.44, kind: 3, color: _deep),
  SceneAnchor(x: 0.44, y: 0.34, w: 0.14, h: 0.38, kind: 3, color: Color(0xFF334155)),
  SceneAnchor(x: 0.62, y: 0.22, w: 0.18, h: 0.5, kind: 3, color: Color(0xFF2F6BFF)),
  SceneAnchor(x: 0.84, y: 0.4, w: 0.12, h: 0.32, kind: 3, color: _stone),
  SceneAnchor(x: 0, y: 0.72, w: 1, h: 0.28, kind: 0, color: _water),
];

const _b2 = [
  SceneAnchor(x: 0, y: 0, w: 1, h: 0.7, kind: 0, color: _dusk),
  SceneAnchor(x: 0.7, y: 0.1, w: 0.18, h: 0.18, kind: 1, color: Color(0xFFFFC46B)),
  SceneAnchor(x: 0.06, y: 0.3, w: 0.14, h: 0.4, kind: 3, color: Color(0xFF1E293B)),
  SceneAnchor(x: 0.24, y: 0.22, w: 0.18, h: 0.48, kind: 3, color: Color(0xFF312E81)),
  SceneAnchor(x: 0.46, y: 0.26, w: 0.2, h: 0.44, kind: 3, color: Color(0xFF1D4ED8)),
  SceneAnchor(x: 0.7, y: 0.34, w: 0.16, h: 0.36, kind: 3, color: Color(0xFF0F172A)),
  SceneAnchor(x: 0.05, y: 0.68, w: 0.9, h: 0.05, kind: 4, color: Color(0xFFE2E8F0)),
  SceneAnchor(x: 0, y: 0.74, w: 1, h: 0.26, kind: 0, color: Color(0xFF1E3A5F)),
];

const _c1 = [
  SceneAnchor(x: 0, y: 0, w: 1, h: 0.58, kind: 0, color: Color(0xFF1E40AF)),
  SceneAnchor(x: 0.62, y: 0.08, w: 0.2, h: 0.2, kind: 1, color: Color(0xFFFDE68A)),
  SceneAnchor(x: -0.08, y: 0.4, w: 0.55, h: 0.28, kind: 2, color: Color(0xFF334155)),
  SceneAnchor(x: 0.28, y: 0.34, w: 0.6, h: 0.32, kind: 2, color: Color(0xFF475569)),
  SceneAnchor(x: 0.5, y: 0.46, w: 0.6, h: 0.22, kind: 2, color: Color(0xFF1F6B4A)),
  SceneAnchor(x: 0, y: 0.68, w: 1, h: 0.32, kind: 0, color: Color(0xFF0F2744)),
];

const _c2 = [
  SceneAnchor(x: 0, y: 0, w: 1, h: 0.62, kind: 0, color: Color(0xFF172554)),
  SceneAnchor(x: 0.58, y: 0.06, w: 0.16, h: 0.16, kind: 1, color: Color(0xFFFBBF24)),
  SceneAnchor(x: 0.08, y: 0.18, w: 0.7, h: 0.02, kind: 4, color: Color(0x66FDE68A)),
  SceneAnchor(x: -0.05, y: 0.36, w: 0.5, h: 0.26, kind: 2, color: Color(0xFF334155)),
  SceneAnchor(x: 0.22, y: 0.24, w: 0.14, h: 0.42, kind: 3, color: Color(0xFF1E3A8A)),
  SceneAnchor(x: 0.4, y: 0.16, w: 0.18, h: 0.5, kind: 3, color: Color(0xFF312E81)),
  SceneAnchor(x: 0.62, y: 0.28, w: 0.16, h: 0.38, kind: 3, color: Color(0xFF1D4ED8)),
  SceneAnchor(x: 0.82, y: 0.34, w: 0.12, h: 0.32, kind: 3, color: Color(0xFF0F172A)),
  SceneAnchor(x: 0, y: 0.66, w: 1, h: 0.34, kind: 0, color: Color(0xFF0B1F33)),
];

String levelArtPath(String level) => '/progress/level/${level.toUpperCase()}';

/// Every previous level stays open. Vocabulary progress never locks history.
bool levelArtIsOpen(String level) {
  const known = {'A1', 'A2', 'B1', 'B2', 'C1', 'C2'};
  return known.contains(level.toUpperCase());
}
