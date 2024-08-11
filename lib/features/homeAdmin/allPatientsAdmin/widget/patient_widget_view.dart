// import 'package:experts_app/features/homeAdmin/allPatientsAdmin/widget/patient_details_abozaby_view.dart';
// import 'package:experts_app/features/homeAdvisor/allPatients/widget/patient_details_view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:responsive_builder/responsive_builder.dart';
//
// typedef ItemTextBuilder<T> = String Function(T item);
// typedef ItemWidgetBuilder<T> = Widget Function(T item);
//
// class PatientWidgetViewWithAdmin<T> extends StatefulWidget {
//   final String label1;
//   final String label2;
//   final String label3;
//   final List<T> items;
//   final ItemTextBuilder<T> itemNameBuilder;
//   final ItemWidgetBuilder<T> itemEditWidgetBuilder;
//   final ItemWidgetBuilder<T>? itemDeleteWidgetBuilder;
//
//   const PatientWidgetViewWithAdmin({
//     super.key,
//     required this.label1,
//     required this.label2,
//     required this.label3,
//     required this.items,
//     required this.itemNameBuilder,
//     required this.itemEditWidgetBuilder,
//     this.itemDeleteWidgetBuilder,
//   });
//
//   @override
//   State<PatientWidgetViewWithAdmin<T>> createState() => _PatientWidgetViewWithAdminState<T>();
// }
//
// class _PatientWidgetViewWithAdminState<T> extends State<PatientWidgetViewWithAdmin<T>> {
//   @override
//   Widget build(BuildContext context) {
//     return
//        Expanded(
//          child: ListView(
//             children: [
//               Table(
//                 columnWidths: {
//                   0 : FlexColumnWidth(4) ,
//                   1 : FlexColumnWidth(1) ,
//                   2 : FlexColumnWidth(1) ,
//                 },
//                 children: [
//                   TableRow(
//                     decoration: BoxDecoration(
//                       color: Colors.black ,
//                     ),
//                     children: [
//                       TableCell(
//                         child: Container(
//                           height: 50,
//                           child: Center(
//                             child: Text(
//                               widget.label1,
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Container(
//                           height: 50 ,
//                           child: Center(
//                             child: Text(
//                               widget.label2,
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       TableCell(
//                         child: Container(
//                           height: 50,
//                           child: Center(
//                             child: Text(
//                               widget.label3,
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 fontSize: 20,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]
//                   ),
//                   for(int index = 0; index < widget.items.length ; index++)...[
//                     TableRow(
//                       decoration: BoxDecoration(
//                         color: Colors.black38 ,
//                       ),
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PatientDetailsAdminView(pationt_data: widget.items[index]),
//                               ),
//                             );
//                           },
//                           child: TableCell(
//                             child:
//                             Container(
//                               alignment: Alignment.center,
//                               child: Center(
//                                 child: Text(
//                                   widget.itemNameBuilder(widget.items[index]),
//                                   style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         TableCell(
//                           child: Container(
//                             alignment: Alignment.center,
//                             child: widget.itemEditWidgetBuilder(widget.items[index]),
//                           ),
//                         ),
//                         TableCell(
//                           child: Container(
//                             alignment: Alignment.center,
//                             child: widget.itemDeleteWidgetBuilder != null
//                                 ? widget.itemDeleteWidgetBuilder!(widget.items[index])
//                               : Container(),
//                           ),
//                         ),
//                       ]
//                     ),
//                   ]
//                 ],
//               ),
//             ],
//           ),
//        );
//   }
// }
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/widget/patient_details_admin_view.dart';
import 'package:flutter/material.dart';

typedef ItemTextBuilder<T> = String Function(T item);
typedef ItemWidgetBuilder<T> = Widget Function(T item);

class PatientWidgetViewWithAdmin<T> extends StatefulWidget {
  final String label1;
  final String label2;
  final String label3;
  final List<T> items;
  final ItemTextBuilder<T> itemNameBuilder;
  final ItemWidgetBuilder<T> itemEditWidgetBuilder;
  final ItemWidgetBuilder<T>? itemDeleteWidgetBuilder;

  const PatientWidgetViewWithAdmin({
    Key? key,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.items,
    required this.itemNameBuilder,
    required this.itemEditWidgetBuilder,
    this.itemDeleteWidgetBuilder,
  }) : super(key: key);

  @override
  State<PatientWidgetViewWithAdmin<T>> createState() => _PatientWidgetViewWithAdminState<T>();
}

class _PatientWidgetViewWithAdminState<T> extends State<PatientWidgetViewWithAdmin<T>> {
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
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: const BoxDecoration(color: Colors.black),
                    children: [
                      _buildTableHeaderCell(widget.label1, context),
                      _buildTableHeaderCell(widget.label2, context),
                      _buildTableHeaderCell(widget.label3, context),
                    ],
                  ),
                  for (int index = 0; index < widget.items.length; index++)
                    TableRow(
                      decoration: const BoxDecoration(color: Colors.black45),
                      children: [
                        _buildNameCell(widget.items[index], context),
                        _buildEditCell(widget.items[index], context),
                        _buildDeleteCell(widget.items[index], context),
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
              builder: (context) => PatientDetailsAdminView(pationt_data: item),
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

  TableCell _buildEditCell(T item, BuildContext context) {
    return TableCell(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: widget.itemEditWidgetBuilder(item),
      ),
    );
  }

  TableCell _buildDeleteCell(T item, BuildContext context) {
    return TableCell(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: widget.itemDeleteWidgetBuilder != null
            ? widget.itemDeleteWidgetBuilder!(item)
            : Container(),
      ),
    );
  }
}
