import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/AllSessionPointersTypeEvaluation.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TableCellWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';

class PointerTypeEvalutionTable extends StatelessWidget {
  Function(SessionPointersEvaluations sessionPointersEvaluations) edit ;
  Function(SessionPointersEvaluations sessionPointersEvaluations) delete ;
  List<SessionPointersEvaluations> allPointersEvaluations = [] ;

  // themes
  BoxDecoration decoration = BoxDecoration(
    color: Colors.black87 ,
  );

  double ceilsPadding = 8 ;
  Color ceilFontColor = Colors.black ;

  PointerTypeEvalutionTable({
    super.key ,
    required this.edit ,
    required this.delete ,
    required this.allPointersEvaluations
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Constants.theme.primaryColor.withOpacity(0.4)
      ),
      child: Table(
        columnWidths: {
          0: FlexColumnWidth(6),
          1: FlexColumnWidth(1) ,
          2: FlexColumnWidth(1) ,
          3: FlexColumnWidth(1) ,
        },
        children: [
          ...allPointersEvaluations.map((pointerEvalution) {
            return TableRow(
              decoration: decoration.copyWith(
                color: Colors.black12 ,
              ),
              children: [
                TableCellWidget(
                  padding: EdgeInsets.all(ceilsPadding),
                  child: TextWidget(
                    text: pointerEvalution.pointerName ?? 'غير محدد' ,
                    color: ceilFontColor,
                  )
                ),
                TableCellWidget(
                  padding: EdgeInsets.all(ceilsPadding),
                  child: TextWidget(
                    text: pointerEvalution.evaluation.toString() ?? 'غير محدد' ,
                    color: ceilFontColor,
                  )
                ),

                TableCellWidget(
                  padding: EdgeInsets.all(ceilsPadding),
                  child: IconButton(
                    icon: Icon(
                      Icons.edit ,
                      color: ceilFontColor,
                    ),
                    onPressed: () => edit(pointerEvalution),
                  )
                ),
                TableCellWidget(
                  padding: EdgeInsets.all(ceilsPadding),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete ,
                      color: ceilFontColor,
                    ),
                    onPressed: () => delete(pointerEvalution),
                  )
                ),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
