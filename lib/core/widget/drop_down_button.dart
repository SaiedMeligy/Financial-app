import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  final Widget titleRadio;
  final List<String>? items;

  DropDownButton({Key? key, required this.titleRadio, this.items}) : super(key: key);

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  List<String> selectedValues = [];
  bool isDropdownOpen = false;

  void toggleDropdown() {
    setState(() {
      isDropdownOpen = !isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: toggleDropdown,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Constants.theme.primaryColor,
                  width: 2.5,
                ),
              ),
              child: SizedBox(
                width: Constants.mediaQuery.width * 0.1,
                child: Row(
                  children: [
                    widget.titleRadio,
                    SizedBox(width: 10),
                    Icon(Icons.arrow_drop_down),
                  ],
                )
              ),
            ),
          ),
          if (isDropdownOpen && widget.items != null)
            Column(
              children: widget.items!.map((item) {
                return CheckboxListTile(
                  title: Text(item),
                  value: selectedValues.contains(item),
                  onChanged: (value) {
                    setState(() {
                      if (value!) {
                        selectedValues.add(item);
                      } else {
                        selectedValues.remove(item);
                      }
                    });
                  },
                );
              }).toList(),
            ),
        ],
      ),
    );
  }
}
