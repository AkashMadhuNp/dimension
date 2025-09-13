import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/widgets/common/nav_item.dart';
import 'package:dimension_machine_task/widgets/common/user_profile.dart';
import 'package:flutter/material.dart';

class DesktopAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DesktopAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = screenWidth * 0.10; 

    return AppBar(
      backgroundColor: AppConstants.backgroundColor,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: Container(
        constraints: const BoxConstraints(maxWidth: 1600),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  NavItem(title:"Home", onTap: () => Navigator.pushReplacementNamed(context, '/')),
                  const SizedBox(width: 24),
                  NavItem(title:"Search Jobs", isActive: true, onTap: () => Navigator.pushNamed(context, '/jobs')),
                  const SizedBox(width: 24),
                  const NavItem(title:"Companies"),
                  const SizedBox(width: 24),
                  const NavItem(title:"Post Jobs"),
                ],
              ),
              const Text(
                AppConstants.appName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textColor,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.notifications_none, 
                      size: 24, color: AppConstants.greyColor),
                  const SizedBox(width: 16),
                   UserProfileWidget(avatarRadius: 16, nameSize: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}