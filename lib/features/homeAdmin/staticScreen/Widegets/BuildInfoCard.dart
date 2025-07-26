import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experts_app/core/config/app_theme_manager.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/material.dart';

class BuildInfoCard extends StatelessWidget {
  String title ;
  String count ;
  Icon icon ;
  Function()? onTap ;

  BuildInfoCard({
    required this.title ,
    required this.count ,
    required this.icon  ,
    this.onTap ,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ,
      child: Container(
        width: 220,
        height: 120,
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppThemeManager.primaryColor ,
          border: Border.all(
            color: AppThemeManager.borderColor ,
            width: 2.5 ,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ,
                SizedBox(width: 10,),
                Text(
                  title ,
                  textAlign: TextAlign.start,
                  style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
            Center(
              child: Text(
                count,
                textAlign: TextAlign.center,
                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
