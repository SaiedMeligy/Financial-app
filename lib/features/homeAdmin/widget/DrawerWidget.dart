import 'package:experts_app/core/config/app_theme_manager.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  int currentIndex ;
  Function(int index) onTap ;
  DrawerWidget({
    required this.currentIndex ,
    required this.onTap
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Expanded(
          child: ListView.builder(
            itemCount: Constants.titles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  widget.onTap(index) ;
                } ,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10) ,bottomLeft: Radius.circular(10)),
                      color: widget.currentIndex == index ? AppThemeManager.secondryColor : Colors.transparent,
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Constants.titles[index].icon ,
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              Constants.titles[index].title,
                              style: widget.currentIndex == index
                                  ? Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.white, fontSize: 16)
                                  : Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 14 ,color: Colors.black),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      dense: true,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
