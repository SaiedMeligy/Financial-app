
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/second_table_widget.dart';

class CasesView extends StatefulWidget {
  const CasesView({super.key});

  @override
  State<CasesView> createState() => _CasesViewState();
}

class _CasesViewState extends State<CasesView> {
  List<String> items = List.generate(50, (index) => 'Item $index');

  @override
  Widget build(BuildContext context) {
    return
      Column(
      children: [
        const CustomTextField(
          hint: "البحث",
          icon: Icons.search,
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child:
            SecondTableWidget(
          label1: Text(
            "اسم الحالة",
            textAlign: TextAlign.center,
            style: Constants.theme.textTheme.bodyMedium
                ?.copyWith(color: Colors.black,
            ),
          ),
          label2: Text(
            "الحذف",
            textAlign: TextAlign.center,
            style: Constants.theme.textTheme.bodyMedium
                ?.copyWith(
                color: Colors.black),
          ),
          items: items,
          itemRow1: const Icon(Icons.delete),
        )
        ),
      ],
    ).setVerticalPadding(context, enableMediaQuery: false, 20).setHorizontalPadding(context,enableMediaQuery: false,20 );
  }
}
