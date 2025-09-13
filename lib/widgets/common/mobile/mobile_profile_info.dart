
import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:dimension_machine_task/widgets/common/custom_container.dart';
import 'package:dimension_machine_task/widgets/common/icon_text.dart';
import 'package:dimension_machine_task/widgets/common/quick_edit.dart';
import 'package:flutter/material.dart';

class MobileProfileInfo extends StatelessWidget {
  const MobileProfileInfo({
    super.key,
    required this.responsive,
  });

  final ResponsiveCalculator responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppConstants.greyColor),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: QuickEditsSection(responsive: responsive),
          ),
          const Divider(height: 1),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Attach Resume Section
                _buildResumeSection(),
                const SizedBox(height: 16),
                
                // Resume Headline Section
                _buildResumeHeadlineSection(),
                const SizedBox(height: 16),
                
                // Employment Section
                _buildEmploymentSection(),
                const SizedBox(height: 16),



              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeSection() {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Attach Resume",
                  style: TextStyle(
                    fontSize: responsive.responsiveFontMedium,
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
            const SizedBox(height: 12),
            Text(
              "Resume is the most important document recruiters look for. Recruiters generally do not look profiles without resumes",
              style: TextStyle(
                fontSize: responsive.responsiveFontExtraSmall,
                color: AppConstants.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "JohnWick_Resume_docx",
                  style: TextStyle(
                    fontSize: responsive.responsiveFontMedium,
                    color: AppConstants.secondaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Updated on Dec 21,2021",
                  style: TextStyle(
                    fontSize: responsive.responsiveFontExtraSmall,
                    color: AppConstants.greyColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "ATTACH NEW RESUME",
                  style: TextStyle(
                    fontSize: responsive.responsiveFontMedium,
                    decoration: TextDecoration.underline,
                    color: AppConstants.secondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResumeHeadlineSection() {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Resume Headline",
              style: TextStyle(
                fontSize: responsive.responsiveFontMedium,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Resume is the most important document recruiters look for. Recruiters generally do not look profiles without resumes",
              style: TextStyle(
                fontSize: responsive.responsiveFontExtraSmall,
                color: AppConstants.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "UPDATE",
              style: TextStyle(
                fontSize: responsive.responsiveFontMedium,
                color: AppConstants.secondaryColor,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmploymentSection() {
    return CustomContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade100.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "Senior Data Base",
                          style: TextStyle(
                            fontSize: responsive.responsiveFontMedium,
                            color: AppConstants.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const IconText(icon: Icons.edit, text: "Edit Job")
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Orr AppData Inc",
                    style: TextStyle(
                      fontSize: responsive.responsiveFontSmall,
                      color: AppConstants.secondaryColor,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Jan 2019 to present (3 years 1 month)",
                    style: TextStyle(
                      fontSize: responsive.responsiveFontSmall,
                      color: Colors.amber[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia",
                    style: TextStyle(
                      fontSize: responsive.responsiveFontSmall,
                      color: AppConstants.greyColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Projects Included in this Place",
                      style: TextStyle(
                        fontSize: responsive.responsiveFontSmall,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "ADD NEW EMPLOYMENT",
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
    );
  }
}