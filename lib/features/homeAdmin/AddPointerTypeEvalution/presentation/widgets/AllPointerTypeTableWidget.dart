import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/PointerImprovement.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TableCellWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';

class AllPointerTypeTableWidget extends StatelessWidget {
  List<PointerImprovement> allPointerImprovement = [] ;
  AllPointerTypeTableWidget({super.key , required this.allPointerImprovement});
  int maxLength = 0 ;
  @override
  Widget build(BuildContext context) {
    allPointerImprovement.forEach((element) {
      if(element.evaluationsBySession.length > maxLength)
        maxLength = element.evaluationsBySession.length ;
    });
    print('==) $maxLength');
    return Table(
      columnWidths: {
        0 : FlexColumnWidth(8)
      },
      border: TableBorder.all(
        width: 5 ,
        color: Colors.white ,
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: Colors.black
          ),
          children: [
            TableCellWidget(
              padding: EdgeInsets.all(10),
              child: TextWidget(
                text: "" ,
                color: Colors.white,
              )
            ),
            for(int i = 0 ; i < maxLength ; i++)...[
              TableCellWidget(
                padding: EdgeInsets.all(10),
                child: TextWidget(
                  text: numbers[i+1].toString() ,
                  color: Colors.white,
                )
              ),
            ] ,
            TableCellWidget(
              padding: EdgeInsets.all(10),
              child: TextWidget(
                text: "التحسن" ,
                color: Colors.white,
              )
            ),
          ]
        ),
        ...allPointerImprovement.map((pointerImprovement) {
          return TableRow(
            decoration: BoxDecoration(
              color: Constants.theme.primaryColor
            ),
            children: [
              TableCellWidget(
                padding: EdgeInsets.all(10),
                child: TextWidget(
                  text: pointerImprovement.pointerName ,
                )
              ),
              for(int i = 0 ; i < maxLength ; i++)...[
                TableCellWidget(
                  padding: EdgeInsets.all(10),
                  child: TextWidget(
                    text: pointerImprovement.evaluationsBySession[i+1] == null ? "" : pointerImprovement.evaluationsBySession[i+1].toString() ,
                  )
                ),
              ],
              TableCellWidget(
                padding: EdgeInsets.all(10),
                child: TextWidget(
                  text: getEhanceState(pointerImprovement.evaluationsBySession) ,
                )
              ),
            ]
          );
        }).toList() ,
      ],
    );
  }

  Map<int , String> numbers = {
    1 : "الاولى",
    2 : "الثانيه",
    3 : "الثالثه",
    4 : "الرابعه",
    5 : "الخامسه",
    6 : "السادسه",
    7 : "السابعه",
    8 : "الثامنه",
    9 : "التاسعه",
    10 : "العاشره",
  };

  String getEhanceState(Map<int, double> data){
    double value = 0 ;
    for(int i = maxLength ; i > 0 ; i--) {
      try {
        value = data[i]! ;
        break;
      }catch(e){

      }
    }
    if(value >= 8.5)
      return "ممتاز" ;
    else if(value >= 7)
      return "جيد جدا" ;
    else if(value >= 6)
      return "جيد" ;
    else
      return "ضعيف" ;
  }
}
