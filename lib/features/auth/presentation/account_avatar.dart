import 'dart:io';

import 'package:flutter/material.dart';

import '../../../app/theme/app_colors.dart';
import '../../../core/services/account/profile_image_store.dart';
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
    final stored = previewPath ?? user?.photoPath;
    return FutureBuilder<File?>(
      future: ProfileImageStore.resolve(stored),
      builder: (context, snapshot) {
        final file = snapshot.data;
        final image = file == null ? null : FileImage(file);
        return _avatar(image);
      },
    );
  }

  Widget _avatar(ImageProvider? image) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.primary.withValues(alpha: 0.15),
      backgroundImage: image,
      child: image == null
          ? Text(
              user?.avatarLetter ?? '?',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontSize: radius * 0.8,
              ),
            )
          : null,
    );
  }
}
