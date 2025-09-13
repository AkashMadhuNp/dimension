import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:dimension_machine_task/widgets/common/mobile/mobile_profile_banner.dart';
import 'package:dimension_machine_task/widgets/common/mobile/mobile_profile_banner_second.dart';
import 'package:dimension_machine_task/widgets/common/mobile/mobile_profile_info.dart';
import 'package:dimension_machine_task/widgets/common/mobile/mobile_profile_selection_button.dart';
import 'package:dimension_machine_task/widgets/layers/mobile/mobile_appbar.dart';
import 'package:flutter/material.dart';

class MobileProfileScreenLayout extends StatefulWidget {
  final PreferredSizeWidget? appBar;
  
  const MobileProfileScreenLayout({super.key, this.appBar});

  @override
  State<MobileProfileScreenLayout> createState() => _MobileProfileScreenLayoutState();
}

class _MobileProfileScreenLayoutState extends State<MobileProfileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCalculator.fromContext(context);
    
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: MobileAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: const MobileProfileBanner(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const MobileProfileBannerSecond(),
            ),
            const SizedBox(height: 16),
            const MobileProfileSelectionButton(),
            MobileProfileInfo(responsive: responsive),
          ],
        ),
      ),
    );
  }
}






