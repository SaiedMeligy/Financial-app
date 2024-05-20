import 'package:experts_app/domain/entities/sales_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/config/constants.dart';

class CircleCharts extends StatefulWidget {
  const CircleCharts({super.key});

  @override
  State<CircleCharts> createState() => _CircleChartsState();
}

class _CircleChartsState extends State<CircleCharts> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context); // Initialize ScreenUtil

    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(10),
      width: Constants.mediaQuery.width*0.55,
      decoration: BoxDecoration(
        color: Constants.theme.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Colors.black26
          )
      ),
      child:  Column(
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  "Annual sales  by category" ,
                  style: TextStyle(
                      fontWeight: FontWeight.bold ,
                      fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                      child: Icon(CupertinoIcons.arrow_right_circle,color: Colors.white,)))
            ],
          ),
          SfCircularChart(
            series: <CircularSeries>[
              PieSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData('s', 35),
                  SalesData('a', 28),
                  SalesData('m', 34),
                  SalesData('e', 32),
                  SalesData('h', 32),
                  SalesData('space', 32),
                ],

                xValueMapper: (SalesData sales, _) => sales.year ,
                yValueMapper: (SalesData sales, _) => sales.sales ,
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside,
                  labelAlignment: ChartDataLabelAlignment.middle,
                  connectorLineSettings: ConnectorLineSettings(
                    length: '20%',
                    type: ConnectorType.curve ,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}


