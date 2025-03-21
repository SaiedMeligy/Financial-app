import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/config/constants.dart';

class ReportSessionWidget extends StatelessWidget {
  const ReportSessionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center( // Center to keep it aligned properly
      child: SizedBox(
        width: Constants.mediaQuery.width * 0.7, // Adjust the width as needed
        child: DataTable(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          border: TableBorder.all(
            color: Constants.theme.primaryColor,
            width: 2,
          ),
          columns: [
            DataColumn(
              label: DataColumnItem(title: "لا ينطبق"),
            ),
            DataColumn(
              label: DataColumnItem(title: "النتائج"),
            ),
            DataColumn(
              label: DataColumnItem(title: "التطبيق"),
            ),
            DataColumn(
              label: DataColumnItem(title: "ملائمة العنصر"),
            ),
            DataColumn(
              label: DataColumnItem(title: "تواجد العنصر"),
            ),
          ],
          dataRowMaxHeight: 70,
          columnSpacing: 8, // Reduce column spacing
          rows: [
            DataRow(
              cells: [
                DataCell(SizedBox( child: DataRowItem(title: "", range: "فارغ"))),
                DataCell(SizedBox( child: DataRowItem(title: "ممتاز", range: "10-9"))),
                DataCell(SizedBox( child: DataRowItem(title: "جيد جدا", range: "8-6"))),
                DataCell(SizedBox( child: DataRowItem(title: "جيد", range: "5-3"))),
                DataCell(SizedBox( child: DataRowItem(title: "ضعيف", range: "2-0"))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget DataColumnItem({required String title}) {
    return Center(
      child: SizedBox(
        width: Constants.mediaQuery.width * 0.12, // Reduce column width
        child: Text(
          title,
          style: Constants.theme.textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget DataRowItem({required String title, required String range}) {
    return Container(
      alignment: Alignment.center,
      height: 80, // Set desired height
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Constants.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold),
          ),
          Text(
            range,
            style: Constants.theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
