import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:flutter/material.dart';

class ProfileBanner extends StatelessWidget {
  const ProfileBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final responsive = ResponsiveCalculator.fromContextDesktop(context);
    
    return Container(
      height: screenHeight * 0.12,
      width: double.infinity,
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
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.012),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * 0.037,
                  height: screenWidth * 0.037,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: CircleAvatar(
                    radius: screenWidth * 0.017,
                    backgroundImage: const NetworkImage(
                      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.009),
                Column(
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
                    SizedBox(height: screenHeight * 0.002),
                    Text(
                      "Senior Data Base Analytic at Orr Appdata Inc",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: responsive.responsiveFontTiny,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.22,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                      SizedBox(height: screenHeight * 0.012),
                      Container(
                        height: 2,
                        width: screenWidth * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: screenWidth * 0.015),
                Container(
                  height: screenHeight * 0.035,
                  width: screenWidth * 0.088,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit,
                        size: responsive.responsiveIconSize,
                        color: AppConstants.secondaryColor,
                      ),
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
      ),
    );
  }
}