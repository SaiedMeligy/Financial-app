
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/domain/entities/PointerReportModel.dart';
import 'package:experts_app/domain/entities/sales_data_model.dart';
import 'package:experts_app/features/homeAdmin/pointerReport/widget/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/pointerReport/widget/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineCharts extends StatefulWidget {
  Map<dynamic,dynamic> data ;
  LineCharts({required this.data});

  @override
  State<LineCharts> createState() => _LineChartsState(data);
}

class _LineChartsState extends State<LineCharts> {
  Map<dynamic,dynamic> data ;
  _LineChartsState(this.data);
  var lineChartCubit = LineChartCubit();
  PointerReportModel pointer = PointerReportModel();
  Map<dynamic,dynamic> dataChart = {} ;

  @override
  void initState() {
    super.initState();
    lineChartCubit.getPointerReport(pointer,1);
  }

  Widget build(BuildContext context) {
    return BlocBuilder<LineChartCubit,LineChartStates>(
      bloc: lineChartCubit,
      builder: (context, state) {
        if (state is LoadingLineChartState) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (state is SuccessLineChartState) {
          var c = state;
          c.report.forEach((element) {
            dataChart.addAll({element.pointer?.text : element.count});
          });
            return  Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            width: Constants.mediaQuery.width * 0.55,
            decoration: BoxDecoration(
              color: Constants.theme.primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black26
              )
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "",
                        style: Constants.theme.textTheme.bodyLarge,
                      ),
                    ),
                    Expanded(child:
                    Container(
                        alignment: Alignment.centerLeft,
                        child: const Icon(CupertinoIcons.arrow_right_circle,
                          color: Colors.white,)))
                  ],
                ),
                SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                    labelStyle: Constants.theme.textTheme.bodySmall,
                  ),
                  primaryYAxis: CategoryAxis(
                    labelStyle: Constants.theme.textTheme.bodySmall,
                  ),
                  series: <ColumnSeries<SalesData, String>>[
                    ColumnSeries<SalesData, String>(
                      dataSource: <SalesData>[
                        for (int i = 0; i < dataChart.length; i++)
                          SalesData(
                              dataChart.keys.toList()[i], dataChart.values.toList()[i])
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
        else if (state is ErrorLineChartState) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      }
    );
  }
}

