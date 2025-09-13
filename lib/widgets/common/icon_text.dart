import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  final double? fontSize;
  final double? iconSize;
  
  const IconText({
    super.key, 
    required this.icon, 
    required this.text,
    this.fontSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
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
    
    final double responsiveFontSize = fontSize ?? (12.0 * fontScale);
    final double responsiveIconSize = iconSize ?? (12.0 * fontScale);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: responsiveIconSize,
        ),
        const SizedBox(width: 4),
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: responsiveFontSize
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        )
      ],
    );
  }
}