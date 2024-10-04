import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../core/config/constants.dart';

class CircleCharts extends StatelessWidget {
  final List<SalesData> advisorData;

  const CircleCharts({Key? key, required this.advisorData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      width: Constants.mediaQuery.width * 0.55,
      decoration: BoxDecoration(
        color: Constants.theme.primaryColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black26),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Expanded(
                child: Text(
                  "الاستشارين",
                  style:Constants.theme.textTheme.bodyLarge?.copyWith(
                    color: Colors.black

                  )
                ),
              ),
              // Expanded(
              //   child: Container(
              //     alignment: Alignment.centerLeft,
              //     child: Icon(CupertinoIcons.arrow_right_circle, color: Colors.white),
              //   ),
              // ),
            ],
          ),
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries<SalesData, String>(
                dataSource: advisorData,
                xValueMapper: (SalesData sales, _) => sales.advisorName,
                yValueMapper: (SalesData sales, _) => sales.patientCount,
                dataLabelMapper: (SalesData sales, _) => '${sales.advisorName}: ${sales.patientCount}',
                dataLabelSettings:  DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  labelAlignment: ChartDataLabelAlignment.middle,
                  connectorLineSettings: ConnectorLineSettings(
                    length: '20%',
                    type: ConnectorType.curve,
                  ),
                    textStyle: Constants.theme.textTheme.bodyMedium?.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    alignment: ChartAlignment.center,

                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SalesData {
  final String advisorName;
  final double patientCount;

  SalesData(this.advisorName, this.patientCount);
}
