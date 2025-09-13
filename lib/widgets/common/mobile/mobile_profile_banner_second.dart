import 'package:dimension_machine_task/widgets/common/icon_text.dart';
import 'package:flutter/material.dart';

class MobileProfileBannerSecond extends StatelessWidget {
  const MobileProfileBannerSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
        color: Colors.white,
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconText(icon: Icons.location_on, text: "Location"),
              IconText(icon: Icons.location_on, text: "Location"),
              IconText(icon: Icons.location_on, text: "Location"),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconText(icon: Icons.location_on, text: "Location"),
              IconText(icon: Icons.location_on, text: "Location"),
              IconText(icon: Icons.location_on, text: "Location"),
            ],
          ),
        ],
      ),
    );
  }
}