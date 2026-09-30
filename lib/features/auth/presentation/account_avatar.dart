import 'dart:io';

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../data/auth_repository.dart';

class AccountAvatar extends StatelessWidget {
  const AccountAvatar({
    super.key,
    required this.user,
    this.radius = 22,
    this.previewPath,
  });

  final AuthUser? user;
  final double radius;
  final String? previewPath;

  @override
  Widget build(BuildContext context) {
    final path = previewPath ?? user?.photoPath;
    final file = path == null || path.isEmpty ? null : File(path);
    final hasPhoto = file != null && file.existsSync();

    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
      backgroundImage: hasPhoto ? FileImage(file) : null,
      child: hasPhoto
          ? null
          : Text(
              user?.avatarLetter ?? '?',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: radius * 0.8,
              ),
            ),
    );
  }
}
