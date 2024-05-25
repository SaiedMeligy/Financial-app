import 'package:flutter/material.dart';
import '../../../../core/config/constants.dart';
import 'PointsWidget.dart';

class PointsDashboard extends StatelessWidget {
  const PointsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: Constants.mediaQuery.width*0.4,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color:Constants.theme.primaryColor.withOpacity(0.2) ,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black26
          )
        ),
        child: Column(

          children: [
            PointsWidget(
                name : "This Montly Sales" ,
                data : const {
                  "AAAAAAAAAAAAAAAAAAAAAAAAAAAA" : 44 ,
                  "BBBBBBBBBBBBBBBBBBBBBBBBBBBB" : 56 ,
                  "CCCCCCCCCCCCCCCCCCCCCCCCCCCC" : 54 ,
                  "DDDDDDDDDDDDDDDDDDDDDDDDDDDD" : 64 ,
                }
            ),
            PointsWidget(
                name : "This Montly Sales" ,
                data : const {
                  "AAAAAAAAAAAAAAAAAAAAAAAAAAAA" : 44 ,
                  "BBBBBBBBBBBBBBBBBBBBBBBBBBBB" : 56 ,
                  "CCCCCCCCCCCCCCCCCCCCCCCCCCCC" : 54 ,
                  "DDDDDDDDDDDDDDDDDDDDDDDDDDDD" : 64 ,
                }
            ),
            PointsWidget(
                name : "This Montly Sales" ,
                data : {
                  "AAAAAAAAAAAAAAAAAAAAAAAAAAAA" : 44 ,
                  "BBBBBBBBBBBBBBBBBBBBBBBBBBBB" : 56 ,
                  "CCCCCCCCCCCCCCCCCCCCCCCCCCCC" : 54 ,
                  "DDDDDDDDDDDDDDDDDDDDDDDDDDDD" : 64 ,
                }
            ),
            PointsWidget(
                name : "This Montly Sales" ,
                data : {
                  "AAAAAAAAAAAAAAAAAAAAAAAAAAAA" : 44 ,
                  "BBBBBBBBBBBBBBBBBBBBBBBBBBBB" : 56 ,
                  "CCCCCCCCCCCCCCCCCCCCCCCCCCCC" : 54 ,
                  "DDDDDDDDDDDDDDDDDDDDDDDDDDDD" : 64 ,
                }
            ),
          ],
        ),
      ),
    );
  }
}
