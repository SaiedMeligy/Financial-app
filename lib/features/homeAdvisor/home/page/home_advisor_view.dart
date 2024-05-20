
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/constants.dart';

class HomeAdvisorView extends StatelessWidget {
  const HomeAdvisorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: Constants.mediaQuery.width*0.16,
            height: Constants.mediaQuery.height*0.15,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(
                color: Colors.black54,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(10)
            ),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.access_time_rounded),
                  SizedBox(height: 15,),
                  Center(
                    child: Text("مواعيد الجلسات",textAlign:TextAlign.center ,style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black
                    ),),
                  )
                ],
              )
        ),
          Container(
              width: Constants.mediaQuery.width*0.16,
              height: Constants.mediaQuery.height*0.15,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(
                    color: Colors.black54,
                    width: 2.5,
                  ),
                  borderRadius: BorderRadius.circular(10)
              ),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.back_hand_rounded,),
                  SizedBox(height: 15,),
                  Center(
                    child: Text("حالاتك",textAlign:TextAlign.center ,style: Constants.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black
                    ),),
                  )
                ],
              )
          ),
      ],
    ).setVerticalPadding(context,enableMediaQuery: false,50),
    ]
    );
  }
}
