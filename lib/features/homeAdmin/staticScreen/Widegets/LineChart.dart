import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/domain/entities/sales_data_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineCharts extends StatefulWidget {
  const LineCharts({super.key});

  @override
  State<LineCharts> createState() => _LineChartsState();
}

class _LineChartsState extends State<LineCharts> {
  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: Text(
                  "Monthly Income" ,
                  style:Constants.theme.textTheme.bodyLarge,
                ),
              ),
              Expanded(child:
              Container(
                alignment: Alignment.centerLeft,
                  child: const Icon(CupertinoIcons.arrow_right_circle,color: Colors.white,)))
            ],
          ),
          SfCartesianChart(
            primaryXAxis:  CategoryAxis(
              labelStyle: Constants.theme.textTheme.bodySmall,
            ),
            primaryYAxis: CategoryAxis(
              labelStyle: Constants.theme.textTheme.bodySmall,
            ),
            series: <ColumnSeries<SalesData, String>>[
              ColumnSeries<SalesData, String>(
                dataSource: <SalesData>[
                  SalesData('Product A', 30),
                  SalesData('Product B', 40),
                  SalesData('Product C', 50),
                  SalesData('Product D', 40),
                  SalesData('Product E', 35),
                  SalesData('Product F', 90),
                  SalesData('Product G', 70),
                  SalesData('Product H', 69),
                  SalesData('Product I', 78),
                ],
                xValueMapper: (SalesData data, _) => data.year,
                yValueMapper: (SalesData data, _) => data.sales,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

