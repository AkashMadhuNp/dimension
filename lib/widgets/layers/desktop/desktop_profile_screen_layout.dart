import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:dimension_machine_task/widgets/common/profile_first_header.dart';
import 'package:dimension_machine_task/widgets/common/profile_header_second.dart';
import 'package:dimension_machine_task/widgets/common/profile_info.dart';
import 'package:dimension_machine_task/widgets/common/profile_selectio_button.dart';
import 'package:dimension_machine_task/widgets/layers/desktop/desktop_appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreenLayout extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  
  const ProfileScreenLayout({super.key, this.appBar});

  @override
  State<ProfileScreenLayout> createState() => _ProfileScreenLayoutState();
}

class _ProfileScreenLayoutState extends State<ProfileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCalculator.fromContextDesktop(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    final bool isDesktop = screenWidth > 1024; 
    
    EdgeInsets bodyPadding;
    if (isDesktop) {
      
      final double horizontalPadding = screenWidth * 0.10;
      bodyPadding = EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: screenWidth * 0.015, 
      );
    } else {
      bodyPadding = EdgeInsets.all(screenWidth * 0.015);
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: widget.appBar ?? DesktopAppBar(),
      body: Padding(
        padding: bodyPadding,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileBanner(),
              const ProfileBannerSecond(),
              SizedBox(height: screenHeight * 0.025),
              const ProfileSelectionButton(),
              ProfileInfo(
                screenWidth: screenWidth,
                responsive: responsive,
                screenHeight: screenHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}