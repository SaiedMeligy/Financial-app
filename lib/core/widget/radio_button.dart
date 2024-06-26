import 'package:flutter/material.dart';
import 'package:experts_app/core/config/constants.dart';

class RadioWidget extends StatefulWidget {
  final String titleRadio;
  final List<MapEntry> items;
  final ValueChanged<int?> onChanged;
  final String? errorMessage;

  RadioWidget({
    Key? key,
    required this.titleRadio,
    required this.items,
    required this.onChanged,
    this.errorMessage,
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
                    child: Text(item.key,style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black
                    ),),
                  );
                }).toList(),
                onChanged: (int? newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                  widget.onChanged(newValue);
                },

              ),
            ),
          ),
        ),
        if (widget.errorMessage != null && selectedValue == widget.items.first.value)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              widget.errorMessage!,
              style: TextStyle(color: Colors.red),
            ),
          ),
      ],
    );
  }
}
