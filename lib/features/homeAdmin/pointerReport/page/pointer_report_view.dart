import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/tab_item_widget.dart';
import '../../../../domain/entities/PointerReportModel.dart';
import '../widget/LineChart.dart';

class PointerReportView extends StatefulWidget {
  const PointerReportView({super.key});

  @override
  State<PointerReportView> createState() => _PointerReportViewState();
}

class _PointerReportViewState extends State<PointerReportView> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("مؤشرات الحالات",style: Constants.theme.textTheme.titleLarge,),
        centerTitle: true,
        backgroundColor: Colors.black87,
        elevation: 0.0,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
            opacity: 1.0
          )
        ),
        child:
        TabItemWidget(
          item1: "السيناريو الاول",
          item2: "السيناريو التاني",
          item3: "السيناريو التالت",
          firstWidget: LineCharts(senario_id: 1,),
          secondWidget: LineCharts(senario_id: 2,),
          thirdWidget: LineCharts(senario_id: 3,),

        )
      ),
    );
  }
}
