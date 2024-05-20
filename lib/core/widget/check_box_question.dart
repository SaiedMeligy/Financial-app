import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckBoxQuestion extends StatefulWidget {
  const CheckBoxQuestion({super.key});

  @override
  State<CheckBoxQuestion> createState() => _CheckBoxQuestionState();
}

class _CheckBoxQuestionState extends State<CheckBoxQuestion> {
  List<String> items = List.generate(50, (index) => 'Item $index');
  List<bool> checked = List.generate(50, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: Constants.mediaQuery.height*0.5,
        width: Constants.mediaQuery.height*0.5,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(items[index]),
              value: checked[index],
              onChanged: (bool? value) {
                setState(() {
                  checked[index] = value!;
                });
              },
            );
          },
        ),
      ),
    );
  }
}
