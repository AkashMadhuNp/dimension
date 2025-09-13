import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:flutter/material.dart';

class UserProfileWidget extends StatelessWidget {
  final double avatarRadius;
  final bool showName;
  final double nameSize;

  const UserProfileWidget({
    super.key,
    this.avatarRadius = 15,
    this.showName = true,
    this.nameSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundImage: const NetworkImage(AppConstants.userProfileImage),
        ),
        if (showName) ...[
          const SizedBox(width: 8),
          Text(
            AppConstants.userName,
            style: TextStyle(
              fontSize: nameSize,
              fontWeight: FontWeight.bold,
              color: AppConstants.textColor,
            ),
          ),
        ],
      ],
    );
  }
}
