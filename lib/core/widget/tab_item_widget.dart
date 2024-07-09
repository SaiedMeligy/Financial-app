
import 'package:experts_app/core/config/constants.dart';

import 'package:experts_app/core/widget/check_box_question.dart';
import 'package:flutter/material.dart';



class TabItemWidget extends StatefulWidget {
  String? item1;
  String? item2;
  String? item3;
  Widget? firstWidget;
  Widget? secondWidget;
  Widget? thirdWidget;
   TabItemWidget({super.key,this.item1,this.item2,this.item3,this.firstWidget,this.secondWidget,this.thirdWidget});

  @override
  State<TabItemWidget> createState() => _TabItemWidgetState();
}

class _TabItemWidgetState extends State<TabItemWidget> {
  bool isMobile =false;
  @override
  Widget build(BuildContext context) {
    final List<Tab> myTabs = <Tab>[
      Tab(text: widget.item1),
      Tab(text: widget.item2),
      Tab(text: widget.item3),
    ];
    final List<Widget> myTabViews = <Widget>[
      widget.firstWidget!,
      widget.secondWidget!,
      widget.thirdWidget!,


    ];
    return
      LayoutBuilder(
        builder: (context, constraints) {
          isMobile = constraints.maxWidth < 600;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: DefaultTabController(
            length: myTabs.length,
            child: Scaffold(
              backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              toolbarHeight:0,
              elevation: 0.0,
              titleSpacing: 0.0,
              leadingWidth: 0,
              bottom: TabBar(
                labelStyle: Constants.theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile? 12 : 15,

                ),
                unselectedLabelStyle:Constants.theme.textTheme.bodyLarge?.copyWith(
                  fontSize: isMobile? 12 : 15,
                ),
                unselectedLabelColor: Colors.white,
                tabs: myTabs,
                labelPadding: EdgeInsets.only(right: 5),
              ),
            ),
            body: TabBarView(
              children: myTabViews,
            ),
                ),
          ),
        );
        }
      );

  }
}
