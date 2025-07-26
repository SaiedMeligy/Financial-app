import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EhancePercentageChart extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  const EhancePercentageChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final double maxY = data.map((e) => e['value'] as double).reduce((a, b) => a > b ? a : b) + 5;
    return Container(
      margin: EdgeInsets.all(10),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxY,
          barGroups: [
            ...List.generate(data.length-1, (index) {
              final item = data[index];
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: double.parse((item['value'] as num).toDouble().toStringAsFixed(2)),
                    width: 16,
                    color: (item['value'] as num).toDouble() < 0 ? Colors.red : Colors.teal,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ],
              );
            }).toList(),
          ],
          titlesData: FlTitlesData(
            show: true,
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value.toInt() >= data.length) return const SizedBox();
                  return TextWidget(
                    text: data[value.toInt()]['name'] + " %${data[value.toInt()]['value'].toStringAsFixed(2)}",
                    color: Colors.black,
                  );
                },
              ),
            ),
            topTitles: AxisTitles(
              // drawBehindEverything: false,
              sideTitles: SideTitles(
                showTitles: false,
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value.toInt() >= data.length) return const SizedBox();
                  return TextWidget(
                    text: data[value.toInt()]['name'] + " %${data[value.toInt()]['value']}",
                    color: Colors.black,
                  );
                },
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          barTouchData: BarTouchData(
            enabled: false
          ),
        ),
      ),
    );
  }
}
