import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TableCellWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import '../../data/models/SessionPointersEvaluations.dart';

class TotalPointerEvalutionTable extends StatelessWidget {
  List<SessionPointersEvaluations> sessionPointersEvaluations;
  String number;
  TotalPointerEvalutionTable({super.key , required this.sessionPointersEvaluations , required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 437 ,
      margin: EdgeInsets.all(3),
      child: Table(
        border: TableBorder.all(
          width: 5 ,
          color: Colors.white ,
        ),
        columnWidths: {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(5)
        },
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: Colors.black ,
            ),
            children: [
              TableCellWidget(
                padding: EdgeInsets.all(15),
                child: TextWidget(
                  text: "10-0" ,
                  color: Colors.white ,
                )
              ),
              TableCellWidget(
                padding: EdgeInsets.all(15),
                child: TextWidget(
                  text: "مؤشرات الجلسة $number" ,
                  color: Colors.white ,
                )
              ),
            ]
          ),
          ...sessionPointersEvaluations!.map((pointerEvaluation) {
            return TableRow(
              decoration: BoxDecoration(
                color: Constants.theme.primaryColor
              ),
              children: [
                TableCellWidget(
                  padding: EdgeInsets.all(15),
                  child: TextWidget(
                    text: "${pointerEvaluation.evaluation}"
                  )
                ),
                TableCellWidget(
                  padding: EdgeInsets.all(15),
                  child: TextWidget(
                    text: "${pointerEvaluation.pointerName}"
                  )
                ),
              ]
            );
          }).toList(),
          TableRow(
            decoration: BoxDecoration(
              color: Colors.black ,
            ),
            children: [
              TableCellWidget(
                padding: EdgeInsets.all(15),
                child: TextWidget(
                  text: "%${calculatePersentage(sessionPointersEvaluations).toStringAsFixed(1)}",
                  color: Colors.white,
                )
              ),
              TableCellWidget(
                padding: EdgeInsets.all(15),
                child: TextWidget(
                  text: "المجموع",
                  color: Colors.white,
                )
              ),
            ]
          )
        ],
      ),
    );
  }
  
  double calculatePersentage(List<SessionPointersEvaluations> sessionPointersEvaluations){
    double percentage = 0 ;
    sessionPointersEvaluations.forEach((element) {
      percentage += element.evaluation! ;
    });
    percentage = (percentage / sessionPointersEvaluations.length) * 10 ;
    return percentage ;
  }
}
