import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatisticsWidget extends StatelessWidget {
  int number ;
  String name ;

  StatisticsWidget({required this.number, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Constants.theme.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black26
        )
      ),
      width: 115.w ,
      height: 130.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween ,
            children: [
              Text(
                name ,
                style: Constants.theme.textTheme.bodyMedium
              ),
              Icon(CupertinoIcons.arrow_right_circle,color: Colors.white,)
            ],
          ),
          Container(
            child: Text(
              "\$"+number.toString() ,
              style: Constants.theme.textTheme.bodyMedium
            ),
          )
        ],
      ),
    );
  }
}
