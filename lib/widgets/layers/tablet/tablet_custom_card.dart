import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/widgets/common/custom_container.dart';
import 'package:dimension_machine_task/widgets/common/icon_text.dart';
import 'package:flutter/material.dart';

class TabletCustomCard extends StatelessWidget {
  final String? title;
  final String desc;
  const TabletCustomCard({
    super.key,
    required this.fontScale,
    required this.responsiveFontDefault,
    required this.responsiveIconSize,
    required this.responsiveFontTiny, 
    this.height, 
    this.width, this.title, required this.desc,
  });

  final double fontScale;
  final double responsiveFontDefault;
  final double responsiveIconSize;
  final double responsiveFontTiny;
  final double? height;
    final double? width;


  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width:width ?? MediaQuery.of(context).size.width * 0.6,
      height: height ?? MediaQuery.of(context).size.width * 0.20,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60 * fontScale,
                      width: 60 * fontScale,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppConstants.greyColor
                      ),
                    ),
                
                    const SizedBox(width: 20),
                
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            () {
                              if (title == null) return "US IT Technical";
                              
                              List<String> words = title!.split(' ');
                              if (words.length <= 2) {
                                return title!;  // Return as is if 2 or fewer words
                              } else {
                                return words.take(2).join(' ') + '...';  // First 2 words + ...
                              }
                            }(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                  
                        Text(
                          "Ora Apps Inc",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: responsiveFontDefault,
                            decoration: TextDecoration.underline
                          ),
                        )
                      ],
                    ),
                  ],
                ),
    
                Row(
                  children: [
                    Icon(
                      Icons.bookmark_border,
                      size: responsiveIconSize,
                      color: AppConstants.greyColor,
                    ),
                    Text(
                      "Save",
                      style: TextStyle(
                        color: AppConstants.greyColor,
                        fontSize: responsiveFontTiny
                      ),
                    )
                  ],
                )
              ],
            ),
          
            const SizedBox(height: 20),
    
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconText(
                      icon: Icons.location_on, 
                      text: "Remote or Hyattville, MD, US",
                      fontSize: responsiveFontDefault,
                      iconSize: responsiveIconSize,
                    ),
                    IconText(
                      icon: Icons.shopping_bag,
                      text: "2 to 8 years",
                      fontSize: responsiveFontDefault,
                      iconSize: responsiveIconSize,
                    ),
                    IconText(
                      icon: Icons.currency_rupee,
                      text: "Not Disclosed",
                      fontSize: responsiveFontDefault,
                      iconSize: responsiveIconSize,
                    )
                  ],
                ),
              ],
            ),
      
            const SizedBox(height: 12),
    
            IconText(
              icon: Icons.note, 
              text:desc?? "Description",
              fontSize: responsiveFontDefault,
              iconSize: responsiveIconSize,
            )
          ],
        ),
      ),
    );
  }
}




