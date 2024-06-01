import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/widget/patient_details_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

typedef ItemTextBuilder<T> = String Function(T item);
typedef ItemWidgetBuilder<T> = Widget Function(T item);

class PatientWidgetView<T> extends StatefulWidget {
  final String label1;
  final String label2;
  final String label3;
  final List<T> items;
  final ItemTextBuilder<T> itemNameBuilder;
  final ItemWidgetBuilder<T> itemEditWidgetBuilder;
  final ItemWidgetBuilder<T>? itemDeleteWidgetBuilder;

  const PatientWidgetView({
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
  State<PatientWidgetView<T>> createState() => _PatientWidgetViewState<T>();
}

class _PatientWidgetViewState<T> extends State<PatientWidgetView<T>> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return ListView(
          children: [
            DataTable(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              border: TableBorder.all(
                color: Colors.blue, // replace with Constants.theme.primaryColor if necessary
                width: 2,
              ),
              columnSpacing: 20,
              columns: [
                DataColumn(
                  label: Expanded(
                    child: SizedBox(
                      width: Constants.mediaQuery.width*0.45,
                      child: Text(
                        widget.label1,
                        textAlign: TextAlign.center,
                        style: Constants.theme.textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.001,
                      child: Text(
                        widget.label2,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                DataColumn(
                  label: Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.001,
                      child: Text(
                        widget.label3,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              rows: List<DataRow>.generate(
                widget.items.length,
                    (index) => DataRow(
                  cells: [
                    DataCell(
                      GestureDetector(
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
                          child: Text(
                            widget.itemNameBuilder(widget.items[index]),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    DataCell(
                      Container(
                        alignment: Alignment.center,
                        child: widget.itemEditWidgetBuilder(widget.items[index]),
                      ),
                    ),
                    DataCell(
                      Container(
                        alignment: Alignment.center,
                        child: widget.itemDeleteWidgetBuilder != null
                            ? widget.itemDeleteWidgetBuilder!(widget.items[index])
                            : Container(),
                      ),
                    ),
                  ],
                ),
              ),
            ).setVerticalPadding(context, enableMediaQuery: false, 20).setHorizontalPadding(context, enableMediaQuery: false, 30),
          ],
        );
      },
    );
  }
}
