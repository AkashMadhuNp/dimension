import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback? onTap;

  const NavItem({
    super.key,
    required this.title,
    this.isActive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: isActive ? AppConstants.primaryColor : AppConstants.textColor,
            decoration: isActive ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
