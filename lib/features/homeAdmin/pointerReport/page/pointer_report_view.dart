import 'package:flutter/cupertino.dart';

import '../widget/LineChart.dart';

class PointerReportView extends StatefulWidget {
  const PointerReportView({super.key});

  @override
  State<PointerReportView> createState() => _PointerReportViewState();
}

class _PointerReportViewState extends State<PointerReportView> {
  @override
  Widget build(BuildContext context) {
    return

      Column(
      children: [
        LineCharts(
            data:{
              "saied":10
            }

        ),
      ],
    );
  }
}
