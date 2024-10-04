import 'package:flutter/material.dart';
import 'package:experts_app/core/config/constants.dart';

class RadioAnswerWidget extends StatefulWidget {
  final String titleRadio;
  final List<MapEntry> items;
  final ValueChanged<int?> onChanged;
  final String? errorMessage;

  RadioAnswerWidget({
    Key? key,
    required this.titleRadio,
    required this.items,
    required this.onChanged,
    this.errorMessage,
  }) : super(key: key);

  @override
  State<RadioAnswerWidget> createState() => _RadioAnswerWidgetState();
}

class _RadioAnswerWidgetState extends State<RadioAnswerWidget> {
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
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: toggleDropdown,
                child: Container(
                  padding: isMobile?EdgeInsets.zero:EdgeInsets.only(right: 5,top: 5,bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Constants.theme.primaryColor,
                      width: 2.5,
                    ),
                  ),
                  child:
                  SizedBox(
                    width:  Constants.mediaQuery.width * 0.28,
                    child: DropdownButton<int>(
                      value: selectedValue,
                      dropdownColor: Constants.theme.primaryColor.withOpacity(0.9),
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      isExpanded: true,
                      items: widget.items.map((item) {
                        return DropdownMenuItem<int>(
                          value: item.value,
                          child: Text(
                            item.key,
                            style: isMobile?Constants.theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12
                            ):Constants.theme.textTheme.bodyMedium
                          ),
                        );
                      }).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                        widget.onChanged(newValue);
                      },
                    ),
                  )

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
          ),
        );
      },
    );
  }
}
