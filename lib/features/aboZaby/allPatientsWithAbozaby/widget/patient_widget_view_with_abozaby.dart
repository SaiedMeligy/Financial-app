import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/aboZaby/allPatientsWithAbozaby/widget/patient_details_abozaby_view.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/widget/patient_details_admin_view.dart';
import 'package:flutter/material.dart';

typedef ItemTextBuilder<T> = String Function(T item);
typedef ItemWidgetBuilder<T> = Widget Function(T item);

class PatientWidgetViewWithAbozaby<T> extends StatefulWidget {
  final String label1;
  final List<T> items;
  final ItemTextBuilder<T> itemNameBuilder;


  const PatientWidgetViewWithAbozaby({
    Key? key,
    required this.label1,
    required this.items,
    required this.itemNameBuilder,
  }) : super(key: key);

  @override
  State<PatientWidgetViewWithAbozaby<T>> createState() => _PatientWidgetViewWithAbozabyState<T>();
}

class _PatientWidgetViewWithAbozabyState<T> extends State<PatientWidgetViewWithAbozaby<T>> {
  bool isMobile = false;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          isMobile = constraints.maxWidth < 600;
          return ListView(
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(4),

                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Colors.black),
                    children: [
                      _buildTableHeaderCell(widget.label1, context),
                    ],
                  ),
                  for (int index = 0; index < widget.items.length; index++)
                    TableRow(
                      decoration: const BoxDecoration(color: Colors.black45),
                      children: [
                        _buildNameCell(widget.items[index], context),
                      ],
                    ),
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  TableCell _buildTableHeaderCell(String label, BuildContext context) {
    return TableCell(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: isMobile?16:20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  TableCell _buildNameCell(T item, BuildContext context) {
    return TableCell(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetailsAbozabyView(pationt_data: item),
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.itemNameBuilder(item),
            style: isMobile?Constants.theme.textTheme.bodyMedium:Constants.theme.textTheme.bodyLarge
          ),
        ),
      ),
    );
  }


}
