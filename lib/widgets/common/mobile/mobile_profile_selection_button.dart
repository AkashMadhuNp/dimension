import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:flutter/material.dart';

class MobileProfileSelectionButton extends StatelessWidget {
  const MobileProfileSelectionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCalculator.fromContext(context);
    
    return Container(
      height: 44,
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
              height: 44,
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
              height: 44,
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
              height: 44,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                ),
                color: Colors.white,
                border: Border.all(color: AppConstants.primaryColor),
              ),
              child: Center(
                child: Text(
                  "Alerts",
                  style: TextStyle(
                    color: AppConstants.secondaryColor,
                    fontSize: responsive.responsiveFontSmall,
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