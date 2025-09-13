import 'package:flutter/material.dart';

class ResponsiveCalculator {
  final double screenWidth;
  final double screenHeight;
  final double fontScale;
  final double responsiveFontLarge;
  final double responsiveFontMedium;
  final double responsiveFontSmall;
  final double responsiveFontExtraSmall;
  final double responsiveFontDefault;
  final double responsiveFontTiny;
  final double responsiveIconSize;

  ResponsiveCalculator._({
    required this.screenWidth,
    required this.screenHeight,
    required this.fontScale,
    required this.responsiveFontLarge,
    required this.responsiveFontMedium,
    required this.responsiveFontSmall,
    required this.responsiveFontExtraSmall,
    required this.responsiveFontDefault,
    required this.responsiveFontTiny,
    required this.responsiveIconSize,
  });

  factory ResponsiveCalculator.fromContext(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    const double baseFontSizeLarge = 14.0;
    const double baseFontSizeMedium = 13.0;
    const double baseFontSizeSmall = 12.0;
    const double baseFontSizeExtraSmall = 11.0;
    const double baseFontSizeDefault = 12.0; 
    const double baseFontSizeTiny = 10.0;
    
    double fontScale = 1.0;
    if (screenWidth < 840) {
      fontScale = 0.9; 
    } else if (screenWidth < 1200) {
      fontScale = 1.0; 
    } else if (screenWidth < 1600) {
      fontScale = 1.1; 
    } else {
      fontScale = 1.2; 
    }
    
    return ResponsiveCalculator._(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      fontScale: fontScale,
      responsiveFontLarge: baseFontSizeLarge * fontScale,
      responsiveFontMedium: baseFontSizeMedium * fontScale,
      responsiveFontSmall: baseFontSizeSmall * fontScale,
      responsiveFontExtraSmall: baseFontSizeExtraSmall * fontScale,
      responsiveFontDefault: baseFontSizeDefault * fontScale,
      responsiveFontTiny: baseFontSizeTiny * fontScale,
      responsiveIconSize: 12.0 * fontScale,
    );
  }

  factory ResponsiveCalculator.fromContextDesktop(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    const double baseFontSizeLarge = 14.0;
    const double baseFontSizeMedium = 13.0;
    const double baseFontSizeSmall = 12.0;
    const double baseFontSizeExtraSmall = 11.0;
    
    double fontScale = 1.0;
    if (screenWidth < 1200) {
      fontScale = 0.9; 
    } else if (screenWidth < 1600) {
      fontScale = 1.0; 
    } else if (screenWidth < 2000) {
      fontScale = 1.1; 
    } else {
      fontScale = 1.2; 
    }
    
    return ResponsiveCalculator._(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      fontScale: fontScale,
      responsiveFontLarge: baseFontSizeLarge * fontScale,
      responsiveFontMedium: baseFontSizeMedium * fontScale,
      responsiveFontSmall: baseFontSizeSmall * fontScale,
      responsiveFontExtraSmall: baseFontSizeExtraSmall * fontScale,
      responsiveFontDefault: 12.0 * fontScale, 
      responsiveFontTiny: 10.0 * fontScale,
      responsiveIconSize: 12.0 * fontScale,
    );
  }
}