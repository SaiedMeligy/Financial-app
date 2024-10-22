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
  final ScrollController? scrollController;
  final bool isLastPage;

  const PatientWidgetViewWithAdmin({
    Key? key,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.items,
    required this.itemNameBuilder,
    required this.itemEditWidgetBuilder,
    this.itemDeleteWidgetBuilder,
    this.scrollController,
    this.isLastPage=false,
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
            return Column(
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
                        _buildHeaderCell(widget.label1, isMobile),
                        _buildHeaderCell(widget.label2, isMobile),
                        _buildHeaderCell(widget.label3, isMobile),
                      ],
                    ),
                  ],
                ),
                // for (int index = 0; index < widget.items.length; index++)
                Expanded(
                  child: ListView.builder(
                    controller: widget.scrollController,
                    itemCount: widget.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index == widget.items.length) {
                        return widget.isLastPage
                            ? const SizedBox.shrink()
                            : const Center(child: CircularProgressIndicator());
                      }

                      var item = widget.items[index];
                      return Table(
                        columnWidths: {
                          0: const FlexColumnWidth(4),
                          1: const FlexColumnWidth(1),
                          2: const FlexColumnWidth(1),
                        },
                        children: [
                          TableRow(
                            decoration: const BoxDecoration(
                              color: Colors.black38,
                            ),
                            children: [
                              _buildDataCell(context, item, widget.itemNameBuilder, isMobile,
                              ),
                              _buildEditCell(item),
                              _buildDeleteCell(item),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),

              ],
            );
          }
      ),
    );
  }

  TableCell _buildHeaderCell(String label, bool isMobile) {
    return TableCell(
      child: Container(
        height: 50,
        alignment: Alignment.center,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme
              .of(context)
              .textTheme
              .titleLarge
              ?.copyWith(
            fontSize: isMobile ? 18 : 22,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  TableCell _buildDataCell(BuildContext context, T item,
      ItemTextBuilder<T> nameBuilder, bool isMobile) {
    return TableCell(
      child: GestureDetector(
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
          child: Text(
            nameBuilder(item),
            style: isMobile ? Constants.theme.textTheme.bodyMedium : Constants
                .theme.textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  TableCell _buildEditCell(T item) {
    return TableCell(
      child: Container(
        alignment: Alignment.center,
        child: widget.itemEditWidgetBuilder(item),
      ),
    );
  }

  TableCell _buildDeleteCell(T item) {
    return TableCell(
      child: Container(
        alignment: Alignment.center,
        child: widget.itemDeleteWidgetBuilder != null
            ? widget.itemDeleteWidgetBuilder!(item)
            : const SizedBox.shrink(),
      ),
    );
  }
}