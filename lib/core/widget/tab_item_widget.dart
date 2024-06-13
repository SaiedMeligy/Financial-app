
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
      Directionality(
        textDirection: TextDirection.rtl,
        child: DefaultTabController(
          length: myTabs.length,
          child: Scaffold(
            backgroundColor: Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 0,
            elevation: 0.0,
            titleSpacing: 0.0,
            bottom: TabBar(
              labelStyle: Constants.theme.textTheme.titleLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle:Constants.theme.textTheme.bodyLarge,
              unselectedLabelColor: Colors.white,
              tabs: myTabs, // use the tabs we defined earlier
            ),
          ),
          body: TabBarView(
            children: myTabViews, // use the tab views we defined earlier
          ),
              ),
        ),
      );

  }
}
