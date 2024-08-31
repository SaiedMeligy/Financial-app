import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/widget/patient_details_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../../homeAdmin/allPatientsAdmin/widget/patient_details_admin_view.dart';

typedef ItemTextBuilder<T> = String Function(T item);
typedef ItemWidgetBuilder<T> = Widget Function(T item);

class PatientCyclebin<T> extends StatefulWidget {
  final String label1;
  final String label2;
  final List<T> items;
  final ItemTextBuilder<T> itemNameBuilder;
  final ItemWidgetBuilder<T>? itemDeleteWidgetBuilder;

  const PatientCyclebin({
    super.key,
    required this.label1,
    required this.label2,
    required this.items,
    required this.itemNameBuilder,
    this.itemDeleteWidgetBuilder,
  });

  @override
  State<PatientCyclebin<T>> createState() => _PatientCyclebinState<T>();
}

class _PatientCyclebinState<T> extends State<PatientCyclebin<T>> {
  @override
  Widget build(BuildContext context) {
    return
      ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return ListView(
            children: [
              Table(
                columnWidths: {
                  0 : FlexColumnWidth(4) ,
                  1 : FlexColumnWidth(1) ,

                },
                children: [
                  TableRow(
                      decoration: BoxDecoration(
                        color: Colors.black ,
                      ),
                      children: [
                        TableCell(
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                widget.label1,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 50,
                            child: Center(
                              child: Text(
                                widget.label2,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                  for(int index = 0; index < widget.items.length ; index++)...[
                    TableRow(
                        decoration: const BoxDecoration(
                          color: Colors.black38 ,
                        ),
                        children: [
                          TableCell(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PatientDetailsView(pationt_data: widget.items[index]),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Text(
                                    widget.itemNameBuilder(widget.items[index]),
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              child: widget.itemDeleteWidgetBuilder != null
                                  ? widget.itemDeleteWidgetBuilder!(widget.items[index])
                                  : Container(),
                            ),
                          ),
                        ]
                    ),
                  ]
                ],
              ),
            ],
          );
        },
      );
  }
}
