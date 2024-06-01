

import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/second_table_widget.dart';

class SessionDate extends StatefulWidget {
  const SessionDate({super.key});

  @override
  State<SessionDate> createState() => _SessionDateState();
}

class _SessionDateState extends State<SessionDate> {
  List<String> items = List.generate(50, (index) => 'Item $index');
  @override
  Widget build(BuildContext context) {
    return Container();
    //   Column(
    //   children: [
    //     const CustomTextField(
    //       hint: "البحث",
    //       icon: Icons.search,
    //     ),
    //     SizedBox(height: 10,),
    //     Expanded(
    //         child: SecondTableWidget(
    //           label1: Text(
    //             "اسم الحالة",
    //             textAlign: TextAlign.center,
    //             style: Constants.theme.textTheme.bodyMedium
    //                 ?.copyWith(color: Colors.black,
    //             ),
    //           ),
    //           label2: Text(
    //             "التاريخ",
    //             textAlign: TextAlign.center,
    //             style: Constants.theme.textTheme.bodyMedium
    //                 ?.copyWith(
    //                 color: Colors.black),
    //           ),
    //           label3: Text(
    //             "الوقت",
    //             textAlign: TextAlign.center,
    //             style: Constants.theme.textTheme.bodyMedium
    //                 ?.copyWith(
    //                 color: Colors.black),
    //           ),
    //           label4: Text(
    //             "الحذف",
    //             textAlign: TextAlign.center,
    //             style: Constants.theme.textTheme.bodyMedium
    //                 ?.copyWith(
    //                 color: Colors.black),
    //           ),
    //           items: items,
    //           itemRow1: Text("20/5/2024",style: TextStyle(color: Colors.black),),
    //           itemRow2: Text("20:35",style: TextStyle(color: Colors.black),),
    //           itemRow3: Icon(Icons.delete),
    //         )),
    //   ],
    // ).setVerticalPadding(context, enableMediaQuery: false, 20).setHorizontalPadding(context,enableMediaQuery: false,20 );
  }
}
