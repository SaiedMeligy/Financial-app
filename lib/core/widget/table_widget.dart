import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../features/homeAdvisor/allPatients/widget/patient_details_view.dart';
import '../config/constants.dart';

typedef ItemTextBuilder<T> = String Function(T item);
typedef ItemWidgetBuilder<T> = Widget Function(T item);

class TableWidget<T> extends StatefulWidget {
  final String label1;
  final String label2;
  final String label3;
  final List<T> items;
  final ItemTextBuilder<T> itemNameBuilder;
  final ItemWidgetBuilder<T> itemEditWidgetBuilder;
  final ItemWidgetBuilder<T>? itemDeleteWidgetBuilder;

  const TableWidget({
    super.key,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.items,
    required this.itemNameBuilder,
    required this.itemEditWidgetBuilder,
    this.itemDeleteWidgetBuilder,
  });

  @override
  State<TableWidget<T>> createState() => _TableWidgetState<T>();
}

class _TableWidgetState<T> extends State<TableWidget<T>> {
  bool isMobile = false;
  @override
  Widget build(BuildContext context) {
    return

      LayoutBuilder(
        builder: (context, constraints) {
          isMobile = constraints.maxWidth < 600;

          return ListView(
            children: [
              Table(
                columnWidths: {
                  0 : FlexColumnWidth(4) ,
                  1 : FlexColumnWidth(1) ,
                  2 : FlexColumnWidth(1) ,
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
                                  fontSize: isMobile?18:22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Container(
                            height: 50 ,
                            child: Center(
                              child: Text(
                                widget.label2,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: isMobile?18:22,
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
                                widget.label3,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontSize: isMobile?18:22,
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
                        decoration: BoxDecoration(
                          color: Colors.black45 ,
                        ),
                        children: [
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  widget.itemNameBuilder(widget.items[index]),
                                  style: isMobile?Constants.theme.textTheme.bodyMedium:Constants.theme.textTheme.bodyLarge
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Container(
                              alignment: Alignment.center,
                              child: widget.itemEditWidgetBuilder(widget.items[index]),
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
      ).setHorizontalPadding(context,enableMediaQuery: false ,20);
  }
}
