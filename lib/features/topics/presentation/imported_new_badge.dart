import 'package:flutter/material.dart';
import 'package:lexora/l10n/app_localizations.dart';

import '../../../app/theme/app_colors.dart';

class ImportedNewBadge extends StatelessWidget {
  const ImportedNewBadge({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: isDark ? 0.22 : 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        AppLocalizations.of(context).contentNew,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
              height: 1.1,
            ),
      ),
    );
  }
}
