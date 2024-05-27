
import 'package:flutter/cupertino.dart';

import '../Widegets/CircleCharts.dart';
import '../../pointerReport/widget/LineChart.dart';
import '../Widegets/PointsDashboard.dart';
import '../Widegets/statistics_widget.dart';

class StaticScreen extends StatelessWidget {
  const StaticScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children:[
          const CircleCharts(),
          //const LineCharts(),
          const PointsDashboard(),
          StatisticsWidget(number: 10, name: "saeed")

        ]
      ),
    );
  }
}
