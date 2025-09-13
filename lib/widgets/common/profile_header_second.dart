import 'package:dimension_machine_task/widgets/common/icon_text.dart';
import 'package:flutter/material.dart';

class ProfileBannerSecond extends StatelessWidget {
  const ProfileBannerSecond({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.17,
      width: double.infinity,
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
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: screenWidth * 0.022, 
          right: screenWidth * 0.05
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconText(icon: Icons.location_on, text: "Location"),
                IconText(icon: Icons.location_on, text: "Location"),
                IconText(icon: Icons.location_on, text: "Location"),
              ],
            ),
            SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconText(icon: Icons.location_on, text: "Location"),
                IconText(icon: Icons.location_on, text: "Location"),
                IconText(icon: Icons.location_on, text: "Location"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
