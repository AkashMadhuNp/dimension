

import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/widgets/common/nav_item.dart';
import 'package:dimension_machine_task/widgets/common/user_profile.dart';
import 'package:flutter/material.dart';


class TabletAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TabletAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppConstants.backgroundColor,
      elevation: 1,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              NavItem(title: "Home",),
              const SizedBox(width: 16),
              NavItem(title:"Search Jobs", isActive: true, onTap: () => Navigator.pushNamed(context, '/jobs')),
              const SizedBox(width: 16),
              const NavItem(title:"Companies"),
              const SizedBox(width: 16),
              const NavItem(title:"Post Jobs"),
            ],
          ),
          const Text(
            AppConstants.appName,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppConstants.textColor,
            ),
          ),
          Row(
            children: [
              const Icon(Icons.notifications_none, color: AppConstants.greyColor),
              const SizedBox(width: 12),
              const UserProfileWidget(),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

