import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/help/context_help_icon.dart';
import '../../../core/help/help_catalog.dart';
import '../domain/cefr_artwork.dart';

class CefrArtworkCard extends StatefulWidget {
  const CefrArtworkCard({
    super.key,
    required this.level,
    required this.mastered,
    required this.total,
    this.masteredEntryIds = const [],
    this.compact = false,
    this.help = false,
    this.languageCode,
    this.onTap,
  });

  final String level;
  final int mastered;
  final int total;
  final List<String> masteredEntryIds;
  final bool compact;
  final bool help;

  /// Art Journey copy only. Null follows the app locale.
  final String? languageCode;
  final VoidCallback? onTap;

  @override
  State<CefrArtworkCard> createState() => _CefrArtworkCardState();
}

class _CefrArtworkCardState extends State<CefrArtworkCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _appear;
  List<String> _ids = const [];
  String? _appearingId;

  @override
  void initState() {
    super.initState();
    _ids = List<String>.of(widget.masteredEntryIds);
    _appear = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
      value: 1,
    );
    _appear.addStatusListener((status) {
      if (status == AnimationStatus.completed && _appearingId != null && mounted) {
        setState(() => _appearingId = null);
      }
    });
  }

  @override
  void didUpdateWidget(CefrArtworkCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final next = widget.masteredEntryIds;
    if (_sameIds(_ids, next)) return;
    final previous = _ids.toSet();
    final added = [
      for (final id in next)
        if (!previous.contains(id)) id,
    ];
    _ids = List<String>.of(next);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (!reduceMotion && added.length == 1) {
      _appearingId = added.single;
      _appear.forward(from: 0);
    } else {
      _appearingId = null;
      _appear.value = 1;
    }
  }

  @override
  void dispose() {
    _appear.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final language = widget.languageCode ??
        Localizations.localeOf(context).languageCode;
    final arabic = language == 'ar';
    final l10n = lookupAppLocalizations(Locale(arabic ? 'ar' : 'en'));
    final fraction = artProgressFraction(
      mastered: widget.mastered,
      total: widget.total,
    );
    final percent = (fraction * 100).round();
    const title = Color(0xFF06135F);
    const muted = Color(0xFF071D83);

    final card = ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: SizedBox(
        height: widget.compact ? 168 : 188,
        width: double.infinity,
        child: AnimatedBuilder(
          animation: _appear,
          builder: (context, _) {
            return Stack(
              fit: StackFit.expand,
              children: [
                RepaintBoundary(
                  child: CustomPaint(
                    painter: CefrWordArtPainter(
                      level: widget.level,
                      entryIds: widget.masteredEntryIds,
                      appearingId: _appearingId,
                      appearProgress: _appearingId == null ? 1 : _appear.value,
                    ),
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        artCanvasScrim,
                      ],
                      stops: [0.62, 1],
                    ),
                  ),
                ),
                if (widget.help)
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: ContextHelpIcon(
                      topic: HelpTopic.levelArtwork,
                      languageCode: arabic ? 'ar' : 'en',
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Directionality(
                    textDirection: arabic ? TextDirection.rtl : TextDirection.ltr,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          widget.level.toUpperCase(),
                          textDirection: TextDirection.ltr,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: title,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        Text(
                          '${_grouped(widget.mastered)} / ${_grouped(widget.total)} ${l10n.mastered}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: muted,
                              ),
                        ),
                        Text(
                          '$percent%',
                          textDirection: TextDirection.ltr,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: title,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );

    if (widget.onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: card,
      ),
    );
  }
}

bool _sameIds(List<String> left, List<String> right) {
  if (left.length != right.length) return false;
  for (var index = 0; index < left.length; index++) {
    if (left[index] != right[index]) return false;
  }
  return true;
}

String _grouped(int value) {
  final text = value.toString();
  final buffer = StringBuffer();
  for (var index = 0; index < text.length; index++) {
    if (index > 0 && (text.length - index) % 3 == 0) buffer.write(',');
    buffer.write(text[index]);
  }
  return buffer.toString();
}

class CefrWordArtPainter extends CustomPainter {
  CefrWordArtPainter({
    required this.level,
    required List<String> entryIds,
    this.appearingId,
    this.appearProgress = 1,
  }) : entryIds = List<String>.unmodifiable(entryIds);

  final String level;
  final List<String> entryIds;
  final String? appearingId;
  final double appearProgress;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = artCanvasColor);
    if (entryIds.isEmpty || size.isEmpty) return;
    final blobs = paintBlobsFor(level: level, masteredEntryIds: entryIds);
    for (final blob in blobs) {
      final appearing = blob.entryId == appearingId;
      final progress = appearing ? appearProgress.clamp(0.0, 1.0) : 1.0;
      if (progress <= 0) continue;
      final path = _blobPath(blob, size);
      final center = Offset(blob.x * size.width, blob.y * size.height);
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.scale(progress);
      canvas.translate(-center.dx, -center.dy);
      canvas.drawPath(
        path,
        Paint()
          ..color = blob.color.withValues(alpha: blob.opacity * progress)
          ..isAntiAlias = true,
      );
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.scale(0.38);
      canvas.translate(-center.dx - blob.baseSize * 0.12, -center.dy + blob.baseSize * 0.16);
      canvas.drawPath(
        path,
        Paint()..color = const Color(0x38FFFFFF),
      );
      canvas.restore();
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CefrWordArtPainter oldDelegate) {
    if (oldDelegate.level != level ||
        oldDelegate.appearingId != appearingId ||
        oldDelegate.appearProgress != appearProgress ||
        oldDelegate.entryIds.length != entryIds.length) {
      return true;
    }
    for (var index = 0; index < entryIds.length; index++) {
      if (oldDelegate.entryIds[index] != entryIds[index]) return true;
    }
    return false;
  }
}

final Map<String, Path> _blobPathCache = {};

Path _blobPath(PaintBlob blob, Size size) {
  final key =
      '${blob.level}:${blob.entryId}:${size.width.toStringAsFixed(1)}x${size.height.toStringAsFixed(1)}';
  return _blobPathCache.putIfAbsent(key, () => _buildBlobPath(blob, size));
}

Path _buildBlobPath(PaintBlob blob, Size size) {
  final scale = (math.min(size.width, size.height) / 180).clamp(0.7, 1.8);
  final center = Offset(blob.x * size.width, blob.y * size.height);
  final base = blob.baseSize * scale;
  final count = blob.pointCount;
  final points = <Offset>[];
  for (var index = 0; index < count; index++) {
    final angle = index / count * math.pi * 2;
    final localX = math.cos(angle) * base * blob.stretch * blob.noiseX[index];
    final localY = math.sin(angle) * base * blob.noiseY[index];
    final cosR = math.cos(blob.rotation);
    final sinR = math.sin(blob.rotation);
    points.add(
      Offset(
        center.dx + localX * cosR - localY * sinR,
        center.dy + localX * sinR + localY * cosR,
      ),
    );
  }
  final path = Path();
  final firstMid = Offset(
    (points.last.dx + points.first.dx) / 2,
    (points.last.dy + points.first.dy) / 2,
  );
  path.moveTo(firstMid.dx, firstMid.dy);
  for (var index = 0; index < points.length; index++) {
    final current = points[index];
    final next = points[(index + 1) % points.length];
    final mid = Offset(
      (current.dx + next.dx) / 2,
      (current.dy + next.dy) / 2,
    );
    path.quadraticBezierTo(current.dx, current.dy, mid.dx, mid.dy);
  }
  path.close();
  return path;
}
