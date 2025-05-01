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
              color: Color(0xFF1C1C1C) ,
              width: 5
          )
      ),
      headingRowColor: MaterialStateProperty.all(Color(0xFF222222)),
      dataRowColor: MaterialStateProperty.all(Color(0xFF1C1C1C)),
      columnSpacing: 20,
      columns: [
        DataColumn(
            label: Text(
              '#' ,
              style: TextStyle(
                fontFamily: "Cairo",
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 14,
              ),
            )
        ),
        ...headerData.map((label) {
          return DataColumn(
              label: Text(
                label ,
                style: TextStyle(
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14,
                ),
              )
          );
        }).toList(),
      ],
      rows: advisorsStatistics.asMap().entries.map((entry) {
        int index = entry.key;
        AdvisorsStatistics advisor = entry.value;
        return DataRow(
          cells: [
            DataCell(
                Text(
                  (index + 1).toString() ,
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
            ),
            DataCell(
                Text(
                  advisor.name.toString(),
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
            ),
            DataCell(
                Text(
                  advisor.asPastAdvisor.toString(),
                  style: TextStyle(
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                )
            ),
          ],
        );
      }).toList(),
    );
  }
}
