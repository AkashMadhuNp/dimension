import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:flutter/material.dart';

class QuickEditsSection extends StatelessWidget {
  final ResponsiveCalculator responsive;
  
  const QuickEditsSection({super.key, required this.responsive});

  static const List<String> _menuItems = [
    "Quick Edits",
    "Attach Resume",
    "Resume HeadLine",
    "KeySkill",
    "Employement",
    "Education",
    "IT Skills",
    "Project",
    "Profile Summary",
    "Accomplishments",
    "Career Profile",
    "Personal Details",
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    final bool isMobile = screenWidth < 768;
    
    if (isMobile) {
      return _buildMobileGridLayout();
    } else {
      return _buildDesktopListLayout(screenHeight);
    }
  }

  Widget _buildMobileGridLayout() {
    final gridItems = _menuItems.skip(1).toList();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            "Quick Edits",
            style: TextStyle(
              fontSize: responsive.responsiveFontMedium,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 6,
            mainAxisSpacing: 8,
            childAspectRatio: 2, 
          ),
          itemCount: gridItems.length,
          itemBuilder: (context, index) {
            return _buildGridItem(gridItems[index]);
          },
        ),
      ],
    );
  }

  Widget _buildGridItem(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: responsive.responsiveFontExtraSmall,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopListLayout(double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _menuItems
          .map((item) => Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: responsive.responsiveFontSmall,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.012),
                ],
              ))
          .toList(),
    );
  }
}