import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';

class Headerwidget extends StatelessWidget {
  String text ;
  Headerwidget({super.key , required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          width: 5 ,
          color: Colors.white ,
        ),
        color: Constants.theme.primaryColor ,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextWidget(
            text: text ,
            fontSize: 16 ,
          ),
        ],
      ),
    );
  }
}
