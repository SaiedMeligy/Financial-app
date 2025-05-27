import 'package:experts_app/features/homeAdmin/PointerTypes/data/models/PointerTypeModel.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TableCellWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';

class PointerTypesTableWidget extends StatelessWidget {
  Function(PointerTypeModel pointerType) edit ;
  Function(PointerTypeModel pointerType) delete ;
  List<PointerTypeModel> allPointerType = [] ;

  // themes
  BoxDecoration decoration = BoxDecoration(
    color: Colors.black87 ,
  );
  double ceilsPadding = 8 ;
  Color ceilFontColor = Colors.white ;

  PointerTypesTableWidget({
    super.key ,
    required this.edit ,
    required this.delete ,
    required this.allPointerType
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          children: [
            TableRow(
              decoration: decoration,
              children: [
                TableCellWidget(
                  padding: EdgeInsets.all(8),
                  child: TextWidget(
                    text: "التصنيف",
                    color: ceilFontColor,
                  ),
                ),
                TableCellWidget(
                  padding: EdgeInsets.all(8),
                  child: TextWidget(
                    text: "المؤشر",
                    color: ceilFontColor,
                  ),
                ),
                TableCellWidget(
                  padding: EdgeInsets.all(8),
                  child: TextWidget(
                    text: "تعديل",
                    color: ceilFontColor,
                  ),
                ),
                TableCellWidget(
                  padding: EdgeInsets.all(8),
                  child: TextWidget(
                    text: "حذف",
                    color: ceilFontColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              children: [
                ...allPointerType.map((pointerType) {
                  return TableRow(
                    decoration: decoration.copyWith(
                      color: Colors.black45,
                    ),
                    children: [
                      TableCellWidget(
                        padding: EdgeInsets.all(ceilsPadding),
                        child: TextWidget(
                          text: pointerType.desc ?? 'غير محدد',
                          color: ceilFontColor,
                        ),
                      ),
                      TableCellWidget(
                        padding: EdgeInsets.all(ceilsPadding),
                        child: TextWidget(
                          text: pointerType.name ?? 'غير محدد',
                          color: ceilFontColor,
                        ),
                      ),
                      TableCellWidget(
                        padding: EdgeInsets.all(ceilsPadding),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: ceilFontColor,
                          ),
                          onPressed: () => edit(pointerType),
                        ),
                      ),
                      TableCellWidget(
                        padding: EdgeInsets.all(ceilsPadding),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: ceilFontColor,
                          ),
                          onPressed: () {
                            print('===========) ${pointerType.id}');
                            delete(pointerType);
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
