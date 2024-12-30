import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/widget/patient_details_view.dart';
import 'package:flutter/material.dart';

typedef ItemTextBuilder<T> = String Function(T item);
typedef ItemWidgetBuilder<T> = Widget Function(T item);

class PatientWidgetView<T> extends StatefulWidget {
  final String label1;
  final String label2;
  final String label3;
  final String label4;
  final List<T> items;
  final ItemTextBuilder<T> itemNameBuilder;
  final ItemTextBuilder<T> itemSessionCountBuilder;

  final ItemWidgetBuilder<T> itemEditWidgetBuilder;
  final ItemWidgetBuilder<T>? itemDeleteWidgetBuilder;
  final ScrollController? scrollController;
  final bool isLastPage;

  const PatientWidgetView({
    super.key,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.items,
    required this.itemNameBuilder,
    required this.itemEditWidgetBuilder,
    this.itemDeleteWidgetBuilder,
    this.scrollController,
    this.isLastPage = false, required this.label4, required this.itemSessionCountBuilder,
  });

  @override
  State<PatientWidgetView<T>> createState() => _PatientWidgetViewState<T>();
}

class _PatientWidgetViewState<T> extends State<PatientWidgetView<T>> {
  bool isMobile = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;
        return Column(
          children: [
            Table(
              columnWidths: {
                0: const FlexColumnWidth(4),
                1: const FlexColumnWidth(1),
                2: const FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  children: [
                    _buildHeaderCell(widget.label1, isMobile),
                    _buildHeaderCell(widget.label2, isMobile),
                    _buildHeaderCell(widget.label3, isMobile),
                    _buildHeaderCell(widget.label4, isMobile),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                controller: widget.scrollController,
                itemCount: widget.items.length + 1,
                itemBuilder: (context, index) {
                  if (index == widget.items.length) {
                    return const SizedBox.shrink();
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
                          _buildDataCell(context, item, widget.itemNameBuilder, isMobile,),
                          _buildSessionCell(context, item, widget.itemSessionCountBuilder, isMobile,),
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
      },
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
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: isMobile ? 18 : 22,
                color: Colors.white,
              ),
        ),
      ),
    );
  }

  TableCell _buildDataCell(BuildContext context, T item, ItemTextBuilder<T> nameBuilder, bool isMobile) {
    return TableCell(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PatientDetailsView(pationt_data: item),
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            nameBuilder(item),
            style: isMobile
                ? Constants.theme.textTheme.bodyMedium
                : Constants.theme.textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
  TableCell _buildSessionCell(BuildContext context, T item, ItemTextBuilder<T> nameBuilder, bool isMobile) {
    return TableCell(
      child: GestureDetector(
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
