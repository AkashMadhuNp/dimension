import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:flutter/material.dart';

class MobileProfileBanner extends StatelessWidget {
  const MobileProfileBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCalculator.fromContext(context);
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        gradient: const LinearGradient(
          colors: [Color(0xFF9C6ADE), Color(0xFFB07CE8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Wick Paul III",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: responsive.responsiveFontMedium,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Senior Data Base Analytic at Orr Appdata Inc",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: responsive.responsiveFontSmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Profile Completion",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: responsive.responsiveFontSmall,
                          ),
                        ),
                        Text(
                          "100%",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: responsive.responsiveFontSmall,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.edit,
                      size: responsive.responsiveIconSize,
                      color: AppConstants.secondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: responsive.responsiveFontSmall,
                        color: AppConstants.secondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}