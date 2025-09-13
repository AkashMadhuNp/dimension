import 'package:dimension_machine_task/core/responsive_builder.dart';
import 'package:dimension_machine_task/widgets/layers/desktop/desktop_profile_screen_layout.dart';
import 'package:dimension_machine_task/widgets/layers/mobile/mobile_profile_screen_layout.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/tablet_appbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
       mobile: const MobileProfileScreenLayout(),
      tablet: const ProfileScreenLayout(appBar: TabletAppBar(),),
      desktop: const ProfileScreenLayout(),
    );
  }
}