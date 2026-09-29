import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/theme/app_colors.dart';

class LexoraLogo extends StatelessWidget {
  const LexoraLogo({
    super.key,
    this.size = 72,
    this.showWordmark = false,
  });

  final double size;
  final bool showWordmark;

  @override
  Widget build(BuildContext context) {
    if (showWordmark) {
      return Image.asset(
        'assets/branding/lexora_icon.png',
        width: size * 2.2,
        height: size * 2.2,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
      )
          .animate()
          .fadeIn(duration: 500.ms)
          .slideY(begin: 0.08, end: 0, curve: Curves.easeOutCubic);
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.28),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Image.asset(
        'assets/branding/lexora_icon.png',
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
