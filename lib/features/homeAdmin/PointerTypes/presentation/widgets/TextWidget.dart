import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  String text ;
  String? fontFamily ;
  double? fontSize ;
  FontWeight? fontWeight ;
  Color? color ;
  TextAlign? textAlign ;

  TextWidget({
    required this.text ,
    this.fontWeight ,
    this.fontSize ,
    this.fontFamily ,
    this.color ,
    this.textAlign ,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ,
      textAlign: textAlign ?? TextAlign.center,
      overflow: TextOverflow.ellipsis ,
      style: TextStyle(
        fontFamily: fontFamily ?? "ElMessiri",
        fontSize: fontSize ?? 15,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? Colors.black,
      ),
    );
  }
}
