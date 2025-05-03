import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  TextEditingController controller ;
  String hintText ;
  TextFieldWidget({
    super.key ,
    required this.controller,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5) ,
          borderSide: BorderSide(
            color: Colors.black45
          )
        )
      ),
      style: TextStyle(
        color: Colors.black87,
        fontSize: 15
      ),
    );
  }
}
