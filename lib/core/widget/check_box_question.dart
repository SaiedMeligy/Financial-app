import 'package:flutter/material.dart';
import 'package:experts_app/core/config/constants.dart';

class CheckBoxQuestion extends StatefulWidget {
  final List<dynamic> items;
  final List<int> previous;
  final ValueChanged<List<int>?> onChanged;

  const CheckBoxQuestion({
    super.key,
    required this.items,
    required this.previous,
    required this.onChanged,
  });

  @override
  State<CheckBoxQuestion> createState() => _CheckBoxQuestionState();
}

class _CheckBoxQuestionState extends State<CheckBoxQuestion> {
  late List<bool> checked;
  List<int> selected = [];

  @override
  void initState() {
    super.initState();
    checked = List<bool>.filled(widget.items.length, false);
    for (int index = 0; index < widget.items.length; index++) {
      if (widget.previous.contains(widget.items[index].id)) {
        checked[index] = true;
        selected.add(widget.items[index].id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: Constants.mediaQuery.height * 0.5,
        width: Constants.mediaQuery.height * 0.5,
        child: ListView.builder(
          itemCount: widget.items.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              checkColor: Colors.white,
              title: Text(widget.items[index].runtimeType.toString() == "Questions" ? widget.items[index].title : widget.items[index].text ,style: Constants.theme.textTheme.bodyMedium,),
              value: checked[index],
              selected: checked[index],
              onChanged: (bool? value) {
                setState(() {
                  checked[index] = value!;
                  if (value) {
                    selected.add(widget.items[index].id);
                  } else {
                    selected.remove(widget.items[index].id);
                  }
                  widget.onChanged(selected);
                });
              },
            );
          },
        ),
      ),
    );
  }
}
