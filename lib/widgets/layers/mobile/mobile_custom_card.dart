import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/widgets/common/custom_container.dart';
import 'package:dimension_machine_task/widgets/common/icon_text.dart';
import 'package:flutter/material.dart';

class MobileCustomCard extends StatelessWidget {
  final String title;
  final String desc;
  const MobileCustomCard({
    super.key, required this.title, required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: MediaQuery.of(context).size.height*0.22,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppConstants.greyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
    
                    SizedBox(width: 10,),
    
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        (title ?? "US IT Technical Recruiter")
                            .split(' ')
                            .take(4)
                            .join(' '),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,
                      ),
    
    
                      Text(
                  "Ora Apps Inc",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    decoration: TextDecoration.underline
                  ),
                  
                  )
                  ],
                ),
                  ],
                ),
    
                
    
    
                Row(
                  children: [
                    Icon(Icons.bookmark_border,size: 12,color: AppConstants.greyColor,),
                    Text("Save",style: TextStyle(
                      color: AppConstants.greyColor,
                      fontSize: 10
                    ),)
                  ],
                )
    
    
                  
              ],
            ),
    
            SizedBox(height: 12,),
    
    
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconText(icon: Icons.location_on, text:  "Remote or Hyattville, MD, US",),
                    IconText(icon: Icons.shopping_bag,text: "2 to 8 years",),
                    
                  ],
                ),
                IconText(icon: Icons.currency_rupee,text: "Not Disclosed",),
              ],
            ),
    
            SizedBox(height: 12,),
    
    
            IconText(icon: Icons.note, text:desc?? "Description")
            
          ],
        ),
      ),
    
    );
  }
}