import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/widgets/common/custom_button.dart';
import 'package:dimension_machine_task/widgets/common/custom_container.dart';
import 'package:flutter/material.dart';

class ResponsiveProfileContainer extends StatelessWidget {
  const ResponsiveProfileContainer({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.fontScale,
    required this.responsiveFontLarge,
    required this.responsiveFontMedium,
    required this.responsiveFontSmall,
    required this.responsiveFontExtraSmall,
    this.isDesktop = false,
  });

  final double screenHeight;
  final double screenWidth;
  final double fontScale;
  final double responsiveFontLarge;
  final double responsiveFontMedium;
  final double responsiveFontSmall;
  final double responsiveFontExtraSmall;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final availableHeight = constraints.maxHeight;
        
        final containerWidth = availableWidth.clamp(200.0, 400.0);
        final containerHeight = isDesktop 
            ? (availableHeight * 0.6).clamp(300.0, 500.0)
            : (availableHeight * 0.7).clamp(350.0, 600.0);
        
        return _buildProfileContainer(containerWidth, containerHeight);
      },
    );
  }

  Widget _buildProfileContainer(double containerWidth, double containerHeight) {
    final profileSectionHeight = containerHeight * 0.4;
    final avatarSize = (containerWidth * 0.15).clamp(32.0, 48.0);
    final iconSize = (avatarSize * 0.6).clamp(20.0, 32.0);
    
    final mainPadding = (containerWidth * 0.04).clamp(8.0, 16.0);
    final horizontalSpacing = (containerWidth * 0.04).clamp(8.0, 20.0);
    final verticalSpacing = (containerHeight * 0.015).clamp(4.0, 12.0);
    final sectionSpacing = (containerHeight * 0.02).clamp(6.0, 16.0);
    final buttonSpacing = (containerWidth * 0.02).clamp(4.0, 10.0);

    return CustomContainer(
      height: containerHeight,
      width: containerWidth,
      child: Column(
        children: [
          Container(
            height: profileSectionHeight,
            width: containerWidth,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12)
              ),
              color: Colors.grey.shade200,
            ),
            child: Padding(
              padding: EdgeInsets.all(mainPadding),
              child: _buildProfileSection(
                avatarSize, 
                iconSize, 
                horizontalSpacing, 
                verticalSpacing
              ),
            ),
          ),
    
          Expanded(
            child: Container(
              width: containerWidth,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12)
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.all(mainPadding),
                child: _buildCompletionSection(
                  verticalSpacing, 
                  sectionSpacing, 
                  buttonSpacing
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(
    double avatarSize, 
    double iconSize, 
    double horizontalSpacing, 
    double verticalSpacing
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              CircleAvatar(
                radius: avatarSize,
                backgroundImage: NetworkImage(AppConstants.userProfileImage),
              ),
              // Container(
              //   width: avatarSize,
              //   height: avatarSize,
              //   decoration: BoxDecoration(
              //     color: AppConstants.secondaryColor.withOpacity(0.1),
              //     shape: BoxShape.circle,
              //     border: Border.all(
              //       color: AppConstants.secondaryColor.withOpacity(0.2),
              //       width: 2,
              //     ),
              //   ),
              //   child: Icon(
              //     Icons.person,
              //     size: iconSize,
              //     color: AppConstants.secondaryColor,
              //   ),
              // ),
        
              SizedBox(width: horizontalSpacing),
        
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Name
                    Flexible(
                      child: Text(
                        "John Wick Paul III",
                        style: TextStyle(
                          fontSize: responsiveFontLarge,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    
                    SizedBox(height: verticalSpacing * 0.5),
                    
                    Flexible(
                      child: Text(
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
                    ),
                    
                    SizedBox(height: verticalSpacing),

                    _buildActionLinks(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionLinks() {
    return Flexible(
      child: Wrap(
        spacing: 12.0,
        runSpacing: 4.0,
        children: [
          InkWell(
            onTap: () {},
            child: Text(
              "Edit Resume",
              style: TextStyle(
                fontSize: responsiveFontSmall,
                fontWeight: FontWeight.w500,
                color: AppConstants.secondaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Text(
              "Update Resume",
              style: TextStyle(
                fontSize: responsiveFontSmall,
                fontWeight: FontWeight.w500,
                color: AppConstants.secondaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionSection(
    double verticalSpacing, 
    double sectionSpacing, 
    double buttonSpacing
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
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
        
        SizedBox(height: verticalSpacing),
        
        // Progress Bar
        Container(
          height: 4,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        
        SizedBox(height: sectionSpacing),
        
        Flexible(
          child: Text(
            "Maintain your profile 100% to get more recruiter views",
            style: TextStyle(
              fontSize: responsiveFontExtraSmall,
              fontWeight: FontWeight.w400,
              color: AppConstants.greyColor,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        SizedBox(height: sectionSpacing),

        Flexible(
          child: Row(
            children: [
              Expanded(
                child: CustomButtonSContainer(
                  text: "Applied\nJobs",
                  fontSize: responsiveFontExtraSmall,
                ),
              ),
              
              SizedBox(width: buttonSpacing),
              
              Expanded(
                child: CustomButtonSContainer(
                  text: "Custom\nJob Alerts",
                  fontSize: responsiveFontExtraSmall,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}