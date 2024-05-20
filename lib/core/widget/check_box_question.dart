import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:experts_app/core/config/constants.dart';

class CheckBoxQuestion extends StatefulWidget {
  final List<dynamic> items;
  final ValueChanged<List<int>?> onChanged;

  const CheckBoxQuestion({
    super.key,
    required this.items,
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
    checked = List.generate(widget.items.length, (index) => false);
  }

  @override
  void didUpdateWidget(CheckBoxQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items != widget.items) {
      checked = List.generate(widget.items.length, (index) => false);
      selected.clear();
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
              title: Text(widget.items[index].text),
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
