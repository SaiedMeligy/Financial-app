import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/material.dart';

class RadioWidget extends StatefulWidget {
  final String titleRadio;
  final String? item1;
  final String? item2;
  final String? item3;

  RadioWidget({Key? key, required this.titleRadio, this.item1, this.item2, this.item3}) : super(key: key);

  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  String? selectedValue;
  bool isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.item1;
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
              width: Constants.mediaQuery.width*0.12,
              child: DropdownButton<String>(
                value: selectedValue,
                onChanged: (newValue) {
                  setState(() {
                    selectedValue = newValue;
                  });
                },
                items: [
                  if (widget.item1 != null)
                    DropdownMenuItem(
                      value: widget.item1,
                      alignment: Alignment.center,
                      child: Text(
                        widget.item1!,
                        style: Constants.theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  if (widget.item2 != null)
                    DropdownMenuItem(
                      value: widget.item2,
                      child: Text(
                        widget.item2!,
                        style: Constants.theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  if (widget.item3 != null)
                    DropdownMenuItem(
                      value: widget.item3,
                      child: Text(
                        widget.item3!,
                        style: Constants.theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


}
