import 'package:experts_app/core/widget/table_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditRecommendView extends StatefulWidget {
  const EditRecommendView({super.key});

  @override
  State<EditRecommendView> createState() => _EditRecommendViewState();
}

class _EditRecommendViewState extends State<EditRecommendView> {
  List<String> items =  List.generate(50, (index) => "item ${index}");
  @override
  Widget build(BuildContext context) {
    return
      TableWidget(label1: "التوصية", label2: "التعديل", label3: "الحذف", items: items, itemNameBuilder: (item) => item, itemEditWidgetBuilder: (item) => IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          // handle edit action
        },
      ),
        itemDeleteWidgetBuilder: (item) => IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
      );
  }
}
