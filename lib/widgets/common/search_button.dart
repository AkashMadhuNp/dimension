import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Widget? child;
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  
  const SearchButton({
    super.key,
    required this.height,
    required this.width,
    this.onPressed,
    this.isLoading = false,
    this.child,
    this.text,
    this.backgroundColor,
    this.textColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;
    
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled 
              ? Colors.grey.shade300
              : backgroundColor ?? Colors.blue,
          foregroundColor: isDisabled 
              ? Colors.grey.shade500
              : textColor ?? Colors.white,
          elevation: isDisabled ? 0 : 2,
          shadowColor: isDisabled ? Colors.transparent : Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? Colors.white,
                  ),
                ),
              )
            : child ??
                Text(
                  text ?? 'Search',
                  style: TextStyle(
                    fontSize: width > 100 ? 16 : 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
      ),
    );
  }
}