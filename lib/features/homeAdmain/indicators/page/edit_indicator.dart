import 'package:experts_app/core/widget/table_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/tab_item_widget.dart';

class EditIndicator extends StatefulWidget {
  const EditIndicator({super.key});

  @override
  State<EditIndicator> createState() => _EditIndicatorState();
}

class _EditIndicatorState extends State<EditIndicator> {
  List<String> items = List.generate(50, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return TabItemWidget(
      item1: "السيناريو الاول",
      item2: "السيناريو التاني",
      item3: "السيناريو التالت",
      firstWidget: TableWidget<String>(
        label1: 'المؤشر',
        label2: 'التعديل',
        label3: 'الحذف',
        items: items,
        itemNameBuilder: (item) => item,
        itemEditWidgetBuilder: (item) => IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // handle edit action
          },
        ),
        itemDeleteWidgetBuilder: (item) => IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // handle delete action
          },
        ),
      ),
      secondWidget: TableWidget<String>(
        label1: 'المؤشر',
        label2: 'التعديل',
        label3: 'الحذف',
        items: items,
        itemNameBuilder: (item) => item,
        itemEditWidgetBuilder: (item) => IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // handle edit action
          },
        ),
        itemDeleteWidgetBuilder: (item) => IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // handle delete action
          },
        ),
      ),
      thirdWidget: TableWidget<String>(
        label1: 'المؤشر',
        label2: 'التعديل',
        label3: 'الحذف',
        items: items,
        itemNameBuilder: (item) => item,
        itemEditWidgetBuilder: (item) => IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // handle edit action
          },
        ),
        itemDeleteWidgetBuilder: (item) => IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // handle delete action
          },
        ),
      ),
    );
  }
}
