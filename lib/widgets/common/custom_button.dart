import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:flutter/material.dart';

class CustomButtonSContainer extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? height;
  final double? width;
  
  const CustomButtonSContainer({
    super.key,
    required this.text,
    this.fontSize, this.height, this.width,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth =width ?? MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double responsiveFontSize = fontSize ?? 12.0;
    double responsivePadding = screenWidth * 0.015;
    double responsiveBorderRadius = 8.0;

    return Container(
      height: height??screenHeight * 0.055,
      constraints: BoxConstraints(
        minWidth: screenWidth * 0.12,
        maxWidth: screenWidth * 0.15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(responsiveBorderRadius),
        border: Border.all(
          color: AppConstants.secondaryColor,
          width: 1.5,
        ),
        color: Colors.transparent,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: responsivePadding,
            vertical: 4,
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: responsiveFontSize,
              fontWeight: FontWeight.w600,
              color: AppConstants.secondaryColor,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}