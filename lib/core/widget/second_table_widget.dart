import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../config/constants.dart';

class SecondTableWidget extends StatefulWidget {
  final Widget label1;
  final Widget label2;
  final Widget? label3;
  final Widget? label4;
  final Widget itemRow1;
  final Widget? itemRow2;
  final Widget? itemRow3;
  final List<String> items;
  SecondTableWidget({super.key, required this.label1,required this.label2,this.label3,this.label4,required this.items, required this.itemRow1,  this.itemRow2, this.itemRow3,});

  @override
  State<SecondTableWidget> createState() => _SecondTableWidgetState();
}

class _SecondTableWidgetState extends State<SecondTableWidget> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (context, sizingInformation) {
          return ListView(
              children: [
                DataTable(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  border: TableBorder.all(
                      color: Constants.theme.primaryColor,
                      width: 2
                  ),
                  columnSpacing: 20,
                  columns: [

                    DataColumn(
                      label: Expanded(
                        child: SizedBox(
                            width: Constants.mediaQuery.width * 0.48,
                            child: widget.label1
                          // Text(widget.label1, textAlign: TextAlign.center,
                          //   style: Constants.theme.textTheme.titleLarge?.copyWith(
                          //     color: Colors.black,
                          //     fontSize: 20,
                          //   ),),
                        ),
                      ),
                    ),
                    DataColumn(
                      label:
                      Expanded(
                        child: SizedBox(
                            width: Constants.mediaQuery.width * 0.001,
                            child: widget.label2
                          // Text(widget.label2, textAlign: TextAlign.center,
                          //   style: Constants.theme.textTheme.titleLarge?.copyWith(
                          //     color: Colors.black,
                          //     fontSize: 20,
                          //   ),),
                        ),
                      ),
                    ),
                    if (widget.label3!= null)
                      DataColumn(
                        label:
                        Expanded(
                          child: SizedBox(
                              width: Constants.mediaQuery.width * 0.001,
                              child: widget.label3
                            // Text(widget.label3!, textAlign: TextAlign.center,
                            //   style: Constants.theme.textTheme.titleLarge?.copyWith(
                            //     color: Colors.black,
                            //     fontSize: 20,
                            //   ),),
                          ),
                        ),
                      ),
                    if (widget.label4!= null)
                      DataColumn(
                        label:
                        Expanded(
                          child: SizedBox(
                              width: Constants.mediaQuery.width * 0.001,
                              child: widget.label4
                            // Text(widget.label4!, textAlign: TextAlign.center,
                            //   style: Constants.theme.textTheme.titleLarge?.copyWith(
                            //     color: Colors.black,
                            //     fontSize: 20,
                            //   ),),
                          ),
                        ),
                      ),

                  ],
                  rows: List<DataRow>.generate(

                    widget.items.length,
                        (index) =>
                        DataRow(
                          cells: [

                            DataCell(
                              Container(
                                alignment: Alignment.center,
                                child: Text(widget.items[index], style: Constants.theme
                                    .textTheme.bodyMedium?.copyWith(
                                    color: Colors.black
                                )
                                ),
                              ),
                            ),
                            DataCell(
                              Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  icon: widget.itemRow1,
                                  onPressed: () {

                                  },
                                ),
                              ),
                            ),
                            if (widget.itemRow2!= null)
                              DataCell(
                                Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    icon: widget.itemRow2!,
                                    onPressed: () {

                                    },
                                  ),
                                ),
                              ),
                            if (widget.itemRow3!= null)
                              DataCell(
                                Container(
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    icon: widget.itemRow3!,
                                    onPressed: () {

                                    },
                                  ),
                                ),
                              ),


                          ],
                        ),
                  ),
                )
              ]);
        });
  }
}
