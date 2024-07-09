import 'package:experts_app/core/config/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return  Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
              opacity: 0.8
            ),
          ),
          child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:Colors.black,
                            width: 2,
                          )
                      ),
                      child: Text("مؤشرات الحالات", style: Constants.theme.textTheme
                          .titleLarge?.copyWith(
                          color: Colors.black,
                          fontSize: 27
                      ),),
                    ),
                  ],
                ),
                Expanded(
                  child: TabItemWidget(
                    item1: "السيناريوالأول(الحالات المتوازنة نسبيا)",
                    item2: "السيناريوالثاني(للحالات الغير متوازنة في الصرف)",
                    item3: "السيناريوالثالث(للحالات المتعثرة ماليا)",
                    firstWidget: LineCharts(senario_id: 1,),
                    secondWidget: LineCharts(senario_id: 2,),
                    thirdWidget: LineCharts(senario_id: 3,),

                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
