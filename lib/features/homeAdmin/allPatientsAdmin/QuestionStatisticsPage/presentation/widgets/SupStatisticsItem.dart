import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';

class SupStatisticsItem extends StatelessWidget {
  Icon icon ;
  String title ;
  String subtitle ;

  SupStatisticsItem({
    required this.title ,
    required this.subtitle ,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 70,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(5),
          border: Border.all(
            color: Color.fromRGBO(227, 231, 241, 1)
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 245, 253, 1) ,
                  borderRadius: BorderRadiusDirectional.circular(10)
              ),
              child: icon,
            ) ,
            SizedBox(width: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: title,
                  fontWeight: FontWeight.bold,
                ),
                TextWidget(
                  text: subtitle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
