import 'package:experts_app/core/config/app_theme_manager.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/HomeAdminModel.dart';

class TableWidget extends StatelessWidget {
  final List<String> headerData;
  final List<AdvisorsStatistics> advisorsStatistics;

  TableWidget({required this.advisorsStatistics, required this.headerData});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppThemeManager.borderColor ,
          width: 2.5
        )
      ),
      headingRowColor: MaterialStateProperty.all(AppThemeManager.drawerColor),
      dataRowColor: MaterialStateProperty.all(AppThemeManager.primaryColor),
      columnSpacing: 20,
      columns: [
        ...headerData.map((label) {
          return DataColumn(
            label: Text(
              label ,
              style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14,
              ),
            )
          );
        }).toList(),
      ],
      rows: advisorsStatistics.asMap().entries.map((entry) {
        AdvisorsStatistics advisor = entry.value;
        return DataRow(
          cells: [
            DataCell(
              Text(
                advisor.name.toString(),
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14,
                ),
              )
            ),
            DataCell(
              Text(
                advisor.asMainAdvisor.toString(),
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              )
            ),
            DataCell(
              Text(
                advisor.asPastAdvisor.toString(),
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black,
                ),
              )
            ),
          ],
        );
      }).toList(),
    );
  }
}
