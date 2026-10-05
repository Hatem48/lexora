import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../core/constants/enums.dart';
import '../../../core/help/context_help_icon.dart';
import '../../../core/help/help_catalog.dart';
import '../domain/cefr_artwork.dart';

class CefrArtworkCard extends StatefulWidget {
  const CefrArtworkCard({
    super.key,
    required this.level,
    required this.mastered,
    required this.total,
    this.compact = false,
    this.help = false,
    this.onTap,
  });

  final String level;
  final int mastered;
  final int total;
  final bool compact;
  final bool help;
  final VoidCallback? onTap;

  @override
  State<CefrArtworkCard> createState() => _CefrArtworkCardState();
}

class _CefrArtworkCardState extends State<CefrArtworkCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _reveal;
  int _from = 0;
  int _to = 0;

  @override
  void initState() {
    super.initState();
    final visible = visibleArtRegions(mastered: widget.mastered, total: widget.total);
    _from = visible;
    _to = visible;
    _reveal = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 560),
      value: 1,
    );
  }

  @override
  void didUpdateWidget(CefrArtworkCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    final next = visibleArtRegions(mastered: widget.mastered, total: widget.total);
    final reduce = MediaQuery.disableAnimationsOf(context);
    if (!reduce && next > _to) {
      _from = _to;
      _to = next;
      _reveal.forward(from: 0);
    } else if (next != _to) {
      _from = next;
      _to = next;
      _reveal.value = 1;
    }
  }

  @override
  void dispose() {
    _reveal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final fraction = artProgressFraction(
      mastered: widget.mastered,
      total: widget.total,
    );
    final percent = (fraction * 100).round();
    final label = _bandLabel(l10n, widget.level);

    final card = ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.lg),
      child: SizedBox(
        height: widget.compact ? 168 : 188,
        width: double.infinity,
        child: AnimatedBuilder(
          animation: _reveal,
          builder: (context, _) {
            final shown = _from + ((_to - _from) * _reveal.value).round();
            final dark = Theme.of(context).brightness == Brightness.dark;
            final title = dark ? Colors.white : const Color(0xFF12233F);
            final muted = title.withValues(alpha: 0.82);
            return Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: CefrArtworkPainter(
                    level: widget.level,
                    visibleRegions: shown,
                    dark: dark,
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        (dark ? Colors.black : Colors.white).withValues(
                          alpha: dark ? 0.42 : 0.78,
                        ),
                      ],
                      stops: const [0.45, 1],
                    ),
                  ),
                ),
                if (widget.help)
                  const Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: ContextHelpIcon(topic: HelpTopic.levelArtwork),
                  ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
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
                        label,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      if (!widget.compact)
                        Text(
                          l10n.paintingWordsCount(widget.mastered, widget.total),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: muted,
                              ),
                        ),
                    ],
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

  String _bandLabel(AppLocalizations l10n, String level) {
    return switch (CefrLevel.fromCode(level)) {
      CefrLevel.a1 || CefrLevel.a2 => l10n.beginner,
      CefrLevel.b1 || CefrLevel.b2 => l10n.intermediate,
      CefrLevel.c1 || CefrLevel.c2 => l10n.advanced,
    };
  }
}

class CefrArtworkPainter extends CustomPainter {
  const CefrArtworkPainter({
    required this.level,
    required this.visibleRegions,
    required this.dark,
  });

  final String level;
  final int visibleRegions;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paper = dark
        ? const Color(0xFF1A2740)
        : const Color(0xFFE7EEF6);
    canvas.drawRect(rect, Paint()..color = paper);
    canvas.saveLayer(
      rect,
      Paint()
        ..color = Colors.white.withValues(alpha: dark ? 0.34 : 0.55),
    );
    _paintScene(canvas, size);
    canvas.restore();
    if (visibleRegions <= 0) return;
    canvas.saveLayer(rect, Paint());
    _paintScene(canvas, size);
    canvas.saveLayer(rect, Paint()..blendMode = BlendMode.dstIn);
    final regions = artRegionsFor(level);
    final brush = Paint()..color = Colors.white;
    if (visibleRegions >= regions.length && regions.isNotEmpty) {
      canvas.drawRect(rect, brush);
    } else {
      for (final region in regions) {
        if (region.order >= visibleRegions) continue;
        canvas.save();
        canvas.translate(region.x * size.width, region.y * size.height);
        canvas.rotate(region.rotation);
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset.zero,
            width: region.rx * size.width * 2.4,
            height: region.ry * size.height * 2.6,
          ),
          brush,
        );
        canvas.restore();
      }
    }
    canvas.restore();
    canvas.restore();
  }

  void _paintScene(Canvas canvas, Size size) {
    for (final anchor in sceneAnchorsFor(level)) {
      final paint = Paint()..color = anchor.color;
      final box = Rect.fromLTWH(
        anchor.x * size.width,
        anchor.y * size.height,
        anchor.w * size.width,
        anchor.h * size.height,
      );
      switch (anchor.kind) {
        case 1:
          canvas.drawCircle(box.center, math.min(box.width, box.height) / 2, paint);
        case 2:
          final path = Path()
            ..moveTo(box.left, box.bottom)
            ..quadraticBezierTo(
              box.center.dx,
              box.top,
              box.right,
              box.bottom,
            )
            ..close();
          canvas.drawPath(path, paint);
        case 3:
          canvas.drawRRect(
            RRect.fromRectAndRadius(box, const Radius.circular(4)),
            paint,
          );
        case 4:
          canvas.drawLine(
            box.centerLeft,
            box.centerRight,
            paint..strokeWidth = math.max(2, box.height),
          );
        default:
          canvas.drawRect(box, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CefrArtworkPainter oldDelegate) {
    return oldDelegate.level != level ||
        oldDelegate.visibleRegions != visibleRegions ||
        oldDelegate.dark != dark;
  }
}
