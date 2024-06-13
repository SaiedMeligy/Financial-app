import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/domain/entities/PointerReportModel.dart';
import 'package:experts_app/features/homeAdmin/pointerReport/widget/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/pointerReport/widget/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineCharts extends StatefulWidget {
   final int senario_id;
  LineCharts({super.key,required this.senario_id});

  @override
  State<LineCharts> createState() => _LineChartsState();
}

class _LineChartsState extends State<LineCharts> {
  final LineChartCubit lineChartCubit = LineChartCubit();
  final Report report = Report(pointer: Pointer(senarioId: 2));
  bool _isTableVisible = false;
  _LineChartsState();

  @override
  void initState() {
    super.initState();
    if(report.pointer!=null) {
      lineChartCubit.getPointerReport(report,widget.senario_id);

    }
    else {
      print("Report pointer is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LineChartCubit, LineChartStates>(
      bloc: lineChartCubit,
      builder: (context, state) {
        if (state is LoadingLineChartState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessLineChartState) {
          var c = state;
          List<PointerData> countData = [];
          List<Color> colors = [Colors.green, Colors.blue, Colors.red, Colors.orange, Colors.purple];
          c.report.asMap().forEach((index, element) {
            double percentage = element.totalPationts != 0
                ? (element.count! / element.totalPationts!) * 100
                : 0 ;
            countData.add(PointerData(element.pointer?.text ?? "", element.count, percentage,colors[index % colors.length],));
          });
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              height: Constants.mediaQuery.height*0.6,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              width: Constants.mediaQuery.width * 0.4,
              decoration: BoxDecoration(
                color: Constants.theme.primaryColor.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black26),
              ),
              child: ListView(
                children: [
                  Column(
                    children: [
                      SfCartesianChart(
                        primaryXAxis: CategoryAxis(
                          labelStyle: Constants.theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold
                          ),
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
                              x: data.patiens, // Add the x parameter
                              y: data.percentage, // Add the y parameter
                              widget: Column(
                                children: [
                                  Text(
                                    '${data.percentage.toStringAsFixed(2)}%',
                                    style: Constants.theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              coordinateUnit: CoordinateUnit.point,
                              region: AnnotationRegion.chart,
                            ),

                        ],
                      ),
                      SizedBox(height: 10),
                //                 ListView.builder(
                //                     shrinkWrap: true,
                //                     itemCount: countData.length,
                //                     itemBuilder: (context, index) {
                //                       final data = countData[index];
                //                       return
                //                         Text(
                //                         '${data.patiens}: ${data.percentage.toStringAsFixed(2)}%',
                //                         style: Constants.theme.textTheme.bodyLarge?.copyWith(
                //                           fontWeight: FontWeight.bold,
                //                         ),
                //     );
                //     }
                // ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isTableVisible = !_isTableVisible;
                          });
                        },
                        child: Row(
                          children: [
                            Icon(
                              _isTableVisible ? CupertinoIcons.arrow_up_arrow_down_circle : CupertinoIcons.arrow_down_circle,
                              color: Colors.white,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'جدول المؤشرات',
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
                          columns:  <DataColumn>[
                            DataColumn(label: Text('المؤشر',style: Constants.theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),)),
                            DataColumn(label: Text('النسبة المئوية',style: Constants.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold,),)),
                            DataColumn(label: Text('عدد الحالات',style: Constants.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold,),)),
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

        } else if (state is ErrorLineChartState) {
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




