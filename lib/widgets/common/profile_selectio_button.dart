import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:flutter/material.dart';

class ProfileSelectionButton extends StatelessWidget {
  const ProfileSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsive = ResponsiveCalculator.fromContextDesktop(context);
    
    double buttonWidth = screenWidth > 1400 
        ? screenWidth * 0.25 
        : screenWidth > 1000 
            ? screenWidth * 0.35 
            : screenWidth * 0.5;
    
    return Container(
      height: screenWidth * 0.022,
      width: buttonWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: screenWidth * 0.022,
              decoration: const BoxDecoration(
                color: AppConstants.secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  "Profile",
                  style: TextStyle(
                    color: AppConstants.backgroundColor,
                    fontSize: responsive.responsiveFontSmall,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: screenWidth * 0.022,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppConstants.primaryColor),
              ),
              child: Center(
                child: Text(
                  "Saved Jobs",
                  style: TextStyle(
                    color: AppConstants.secondaryColor,
                    fontSize: responsive.responsiveFontSmall,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: screenWidth * 0.022,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                ),
                color: Colors.white,
                border: Border.all(color: AppConstants.primaryColor),
              ),
              child: Center(
                child: Text(
                  "Custom Job Alerts",
                  style: TextStyle(
                    color: AppConstants.secondaryColor,
                    fontSize: responsive.responsiveFontTiny,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}