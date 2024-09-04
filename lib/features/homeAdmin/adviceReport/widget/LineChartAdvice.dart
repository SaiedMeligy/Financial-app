import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/domain/entities/AdviceReportModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'manager/cubit.dart';
import 'manager/states.dart';

class LineChartsAdvice extends StatefulWidget {
  const LineChartsAdvice({super.key});

  @override
  State<LineChartsAdvice> createState() => _LineChartsAdviceState();
}

class _LineChartsAdviceState extends State<LineChartsAdvice> {
  final LineChartAdviceCubit lineChartAdviceCubit = LineChartAdviceCubit();
  final ReportAdvice advice = ReportAdvice(
    advice: Advice(id: 1, text: "default"),
  );
  bool _isTableVisible = false;

  @override
  void initState() {
    super.initState();
    lineChartAdviceCubit.getAdviceReport(advice);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LineChartAdviceCubit, LineChartAdviceStates>(
      bloc: lineChartAdviceCubit,
      builder: (context, state) {
        if (state is LoadingLineChartAdviceState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessLineChartAdviceState) {
          var c = state;
          List<PointerData> countData = [];
          List<Color> colors = [Colors.green, Colors.blue, Colors.red, Colors.orange, Colors.purple]; // Add more colors if needed

          c.advice.asMap().forEach((index, element) {
            double percentage = element.totalPationts != 0
                ? (element.count! / element.totalPationts!) * 100
                : 0;
            countData.add(PointerData(element.advice?.text ?? "", element.count, percentage, colors[index % colors.length], // Assign color cyclically
            ));
          });

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: Constants.mediaQuery.height * 0.6,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Constants.theme.primaryColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black26),
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      Container(
                        height: Constants.mediaQuery.height*1.2,
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(
                            labelStyle: Constants.theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            labelRotation: 90,
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle: Constants.theme.textTheme.bodySmall,
                            minimum: 0,
                            maximum: 100,
                          ),
                          series: <ColumnSeries<PointerData, String>>[
                            ColumnSeries<PointerData, String>(
                              dataSource: countData,
                              xValueMapper: (PointerData data, _) => data.patiens,
                              yValueMapper: (PointerData data, _) => data.percentage,
                              pointColorMapper: (PointerData data, _) => data.color, // Use pointColorMapper
                            ),
                          ],
                          annotations: <CartesianChartAnnotation>[
                            for (var data in countData)
                              CartesianChartAnnotation(
                                x: data.patiens,
                                y: data.percentage,
                                widget: Column(
                                  children: [
                                    // Text(
                                    //   '${data.percentage.toStringAsFixed(2)}%',
                                    //   style: Constants.theme.textTheme.bodyMedium,
                                    // ),
                                  ],
                                ),
                                coordinateUnit: CoordinateUnit.point,
                                region: AnnotationRegion.chart,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTableVisible = !_isTableVisible;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              _isTableVisible
                                  ? CupertinoIcons.arrow_up_arrow_down_circle
                                  : CupertinoIcons.arrow_down_circle,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'جدول التوصيات',
                              style: Constants.theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _isTableVisible,
                        child: DataTable(
                          columns: <DataColumn>[
                            DataColumn(label: Text('المؤشر', style: Constants.theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ))),
                            DataColumn(label: Text('النسبة المئوية', style: Constants.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('عدد الحالات', style: Constants.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold))),
                          ],
                          rows: countData.map((data) => DataRow(
                            cells: <DataCell>[
                              DataCell(Text(data.patiens)),
                              DataCell(Text('${data.percentage.toStringAsFixed(2)}%')),
                              DataCell(Text(data.count.toString())),
                            ],
                          )).toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is ErrorLineChartAdviceState) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class PointerData {
  PointerData(this.patiens, this.count, this.percentage, this.color);
  final String patiens;
  final int? count;
  final double percentage;
  final Color color;
}
