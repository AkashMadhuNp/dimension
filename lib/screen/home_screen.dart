import 'package:dimension_machine_task/widgets/layers/desktop/desktop_home_layout.dart';
import 'package:dimension_machine_task/widgets/layers/mobile/mobile_home_layout.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/table_home_layout.dart';
import 'package:flutter/material.dart';
import '../../core/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: const MobileHomeLayout(),
      tablet: const TabletHomeLayout(),
      desktop: const DesktopHomeLayout(),
    );
  }
}