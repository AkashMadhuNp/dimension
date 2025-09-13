import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/widgets/common/custom_button.dart';
import 'package:dimension_machine_task/widgets/common/custom_container.dart';
import 'package:flutter/material.dart';

class TableProfileConatiner extends StatelessWidget {
  const TableProfileConatiner({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.fontScale,
    required this.responsiveFontLarge,
    required this.responsiveFontMedium,
    required this.responsiveFontSmall,
    required this.responsiveFontExtraSmall,
  });

  final double screenHeight;
  final double screenWidth;
  final double fontScale;
  final double responsiveFontLarge;
  final double responsiveFontMedium;
  final double responsiveFontSmall;
  final double responsiveFontExtraSmall;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: screenHeight * 0.55,
      width: screenWidth * 0.30,
      child: Column(
        children: [
          
          Container(
            height: (screenHeight * 0.55) * 0.4, 
            width: screenWidth * 0.32,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12)
              ),
              color: Colors.grey.shade200,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 42.0 * fontScale,
                        height: 42.0 * fontScale,
                        decoration: BoxDecoration(
                          color: AppConstants.secondaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppConstants.secondaryColor.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          size: 30.0 * fontScale,
                          color: AppConstants.secondaryColor,
                        ),
                      ),
                
                      const SizedBox(width: 20),
                
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "John Wick Paul III",
                              style: TextStyle(
                                fontSize: responsiveFontLarge,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Senior Database Analyst\nOrr AppData Inc.",
                              style: TextStyle(
                                fontSize: responsiveFontMedium,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.greyColor,
                                height: 1.3,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
    
                            
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Edit Resume",
                                    style: TextStyle(
                                      fontSize: responsiveFontSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppConstants.secondaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
    
                                const SizedBox(width: 8), 
                                
                                Expanded(
                                  child: Text(
                                    "Update Resume",
                                    style: TextStyle(
                                      fontSize: responsiveFontSmall,
                                      fontWeight: FontWeight.w500,
                                      color: AppConstants.secondaryColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.end, 
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
    
          
          Expanded(
            child: Container(
              width: screenWidth * 0.32,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            "Profile Completion",
                            style: TextStyle(
                              fontSize: responsiveFontSmall,
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        
                        Text(
                          "100%",
                          style: TextStyle(
                            fontSize: responsiveFontSmall,
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Container(
                      height: 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    
                    const SizedBox(height: 12),
                    
                    Text(
                      "Maintain your profile 100% to get more recruiter views",
                      style: TextStyle(
                        fontSize: responsiveFontExtraSmall,
                        fontWeight: FontWeight.w500,
                        color: AppConstants.greyColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
    
                    const SizedBox(height: 16),
    
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButtonSContainer(
                            text: "Applied\nJobs",
                            fontSize: responsiveFontExtraSmall,
                          ),
                        ),
                        
                        const SizedBox(width: 8),
                        
                        Expanded(
                          child: CustomButtonSContainer(
                            text: "Custom\nJob Alerts",
                            fontSize: responsiveFontExtraSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}