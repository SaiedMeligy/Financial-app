import 'package:flutter/material.dart';
import 'package:experts_app/core/config/constants.dart';

class RadioWidget extends StatefulWidget {
  final String titleRadio;
  final List<MapEntry> items;
  
  final ValueChanged<int?> onChanged;

  RadioWidget({
    Key? key,
    required this.titleRadio,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  int? selectedValue;
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.items.first.value;
  }

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: toggleDropdown,
          child: Container(
            padding: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Constants.theme.primaryColor,
                width: 2.5,
              ),
            ),
            child: SizedBox(
              width: Constants.mediaQuery.width * 0.12,
              child: DropdownButton<int>(
                value: selectedValue,

                items: widget.items.map((item) {
                  return DropdownMenuItem<int>(
                    value: item.value,
                    child: Text(item.key),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                  widget.onChanged(newValue);
                },
                //  [

                //   if (widget.item1 != null)
                //     DropdownMenuItem(
                //       value: widget.item1,
                //       alignment: Alignment.center,
                //       child: Text(
                //         widget.item1!,
                //         style: Constants.theme.textTheme.bodyMedium?.copyWith(
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   if (widget.item2 != null)
                //     DropdownMenuItem(
                //       value: widget.item2,
                //       child: Text(
                //         widget.item2!,
                //         style: Constants.theme.textTheme.bodyMedium?.copyWith(
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                //   if (widget.item3 != null)
                //     DropdownMenuItem(
                //       value: widget.item3,
                //       child: Text(
                //         widget.item3!,
                //         style: Constants.theme.textTheme.bodyMedium?.copyWith(
                //           color: Colors.black,
                //         ),
                //       ),
                //     ),
                // ]
              ),
            ),
          ),
        ),
      ],
    );
  }
}
