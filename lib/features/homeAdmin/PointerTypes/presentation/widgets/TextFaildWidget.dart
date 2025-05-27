import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController controller ;
  String hintText ;
  Color? borderColor ;
  Function(String value)? onChange ;
  TextFieldWidget({
    super.key ,
    required this.controller,
    required this.hintText,
    this.borderColor,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ,
      onChanged: (value){onChange!(value);},
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5) ,
          borderSide: BorderSide(
            color: borderColor ?? Colors.black45
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: borderColor ?? Colors.black45,
            width: 2.0,
          ),
        ),
      ),
      style: TextStyle(
        color: borderColor ?? Colors.black45,
        fontSize: 15
      ),
    );
  }
}
