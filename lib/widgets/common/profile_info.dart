import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:dimension_machine_task/widgets/common/custom_container.dart';
import 'package:dimension_machine_task/widgets/common/icon_text.dart';
import 'package:dimension_machine_task/widgets/common/quick_edit.dart';
import 'package:dimension_machine_task/widgets/layers/desktop/desktop_profile_screen_layout.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({
    super.key,
    required this.screenWidth,
    required this.responsive,
    required this.screenHeight,
  });

  final double screenWidth;
  final ResponsiveCalculator responsive;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppConstants.greyColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.015),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Quick edits sidebar - responsive width
              Expanded(
                flex: screenWidth > 1200 ? 2 : 1,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.008),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: QuickEditsSection(responsive: responsive),
                  ),
                ),
              ),
              // Main content area
              Expanded(
                flex: screenWidth > 1200 ? 8 : 6,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.008),
                  child: Container(
                    decoration: const BoxDecoration(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Attach Resume Section
                        CustomContainer(
                          height: screenHeight * 0.18,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.012),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Attach Resume",
                                      style: TextStyle(
                                        fontSize: responsive.responsiveFontLarge,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Delete Resume",
                                      style: TextStyle(
                                        fontSize: responsive.responsiveFontSmall,
                                        color: AppConstants.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: screenHeight * 0.012),
                                Text(
                                  "Resume is the most important document recruiters look for. Recruiters generallly do not look profiles without resumes",
                                  style: TextStyle(
                                    fontSize: responsive.responsiveFontExtraSmall,
                                    color: AppConstants.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.035),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "JohnWick_Resume_docx",
                                              style: TextStyle(
                                                fontSize: responsive.responsiveFontLarge,
                                                color: AppConstants.secondaryColor,
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.underline,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(width: screenWidth * 0.015),
                                          Text(
                                            "Updated on Dec 21,2021",
                                            style: TextStyle(
                                              fontSize: responsive.responsiveFontExtraSmall,
                                              color: AppConstants.greyColor,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    if (screenWidth > 800) // Hide on smaller screens
                                      Text(
                                        "ATTACH NEW RESUME",
                                        style: TextStyle(
                                          fontSize: responsive.responsiveFontLarge,
                                          decoration: TextDecoration.underline,
                                          color: AppConstants.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.012),
                        
                        // Resume Headline Section
                        CustomContainer(
                          height: screenHeight * 0.18,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.012),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Resume Headline",
                                  style: TextStyle(
                                    fontSize: responsive.responsiveFontLarge,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.012),
                                Text(
                                  "Resume is the most important document recruiters look for. Recruiters generallly do not look profiles without resumes",
                                  style: TextStyle(
                                    fontSize: responsive.responsiveFontExtraSmall,
                                    color: AppConstants.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.035),
                                Text(
                                  "UPDATE",
                                  style: TextStyle(
                                    fontSize: responsive.responsiveFontLarge,
                                    color: AppConstants.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.012),
                        
                        // Employment Section
                        CustomContainer(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.all(screenWidth * 0.012),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Employment",
                                  style: TextStyle(
                                    fontSize: responsive.responsiveFontMedium,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: screenHeight * 0.018),
    
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.yellow.shade100.withOpacity(0.2)
                                  ),
                                  width: double.infinity,
                                  child: Padding(
                                    padding: EdgeInsets.all(screenWidth * 0.012),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                "Senior Data Base",
                                                style: TextStyle(
                                                  fontSize: responsive.responsiveFontMedium,
                                                  color: AppConstants.textColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            IconText(icon: Icons.edit, text: "Edit Job")
                                          ],
                                        ),
    
                                        SizedBox(height: screenHeight * 0.012),
    
                                        Text(
                                          "Orr AppData Inc",
                                          style: TextStyle(
                                            fontSize: responsive.responsiveFontSmall,
                                            color: AppConstants.secondaryColor,
                                            fontWeight: FontWeight.bold,
                                            decoration: TextDecoration.underline
                                          ),
                                        ),
    
                                        SizedBox(height: screenHeight * 0.012),
    
                                        Text(
                                          "Jan 2019 to present(3 years 1 month)",
                                          style: TextStyle(
                                            fontSize: responsive.responsiveFontLarge,
                                            color: Colors.amber[200],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
    
                                        SizedBox(height: screenHeight * 0.012),
    
                                        Text(
                                          "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia",
                                          style: TextStyle(
                                            fontSize: responsive.responsiveFontSmall,
                                            color: AppConstants.greyColor,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
    
                                        SizedBox(height: screenHeight * 0.012),
    
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.blue.shade100,
                                            borderRadius: BorderRadius.circular(screenWidth * 0.004)
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(screenWidth * 0.009),
                                            child: Text(
                                              "Projects Included in this Place",
                                              style: TextStyle(
                                                fontSize: responsive.responsiveFontSmall,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
    
                                SizedBox(height: screenHeight * 0.012),
    
                                Text(
                                  "ADD NEW EMPLOYEMENT",
                                  style: TextStyle(
                                    fontSize: responsive.responsiveFontMedium,
                                    color: AppConstants.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
