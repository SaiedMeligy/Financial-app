import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/cubit/pointer_types_cubit.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/ButtonWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TableCellWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextFaildWidget.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointerTypesTableViewWidget extends StatefulWidget {
  Function(Map<int,int> evalutions) save ;

  PointerTypesTableViewWidget({
    super.key ,
    required this.save ,
  });

  @override
  State<PointerTypesTableViewWidget> createState() => _PointerTypesTableViewWidgetState();
}

class _PointerTypesTableViewWidgetState extends State<PointerTypesTableViewWidget> {
  PointerTypeCubit pointersTypesCubit = PointerTypeCubit();

  @override
  void initState() {
    pointersTypesCubit.fetchPointerTypes();
    super.initState();
  }

  BoxDecoration decoration = BoxDecoration(
    color: Colors.black87 ,
  );

  double ceilsPadding = 8 ;
  Color ceilFontColor = Colors.white ;
  Map<int,int> evalutions = {} ;
  int counter = -1 ;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: pointersTypesCubit ,
      builder: (context, state) {
        if (state is PointerTypesLoading) {
          return Center(child: CircularProgressIndicator());
        }
        else if (state is PointerTypesLoaded) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              color: Colors.black87,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(20),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWidget(
                        text: "حفظ",
                        onPressed: (){
                          widget.save(evalutions);
                          Navigator.of(context).pop();
                        }
                      ),
                      IconButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          CupertinoIcons.xmark_circle ,
                          color: Colors.white,
                        )
                      )
                    ],
                  ),
                  Container(
                    color: Colors.white38,
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextWidget(
                          text: "تقييم مؤشرات الحاله" ,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  Table(
                    columnWidths: {
                      0 : FlexColumnWidth(1) ,
                      1 : FlexColumnWidth(8) ,
                      2 : FlexColumnWidth(1) ,
                    },
                    children: [
                      ...state.pointerTypelist.map((pointerType) {
                        return TableRow(
                          children: [
                            TableCellWidget(
                              padding: EdgeInsets.all(ceilsPadding),
                              child: TextWidget(
                                text: pointerType.desc ?? 'غير محدد' ,
                                color: ceilFontColor,
                              )
                            ),
                            TableCellWidget(
                              padding: EdgeInsets.all(ceilsPadding),
                              child: TextWidget(
                                text: pointerType.name ?? 'غير محدد' ,
                                color: ceilFontColor,
                              )
                            ),
                            TableCellWidget(
                              padding: EdgeInsets.all(ceilsPadding),
                              child: TextFieldWidget(
                                controller: TextEditingController(),
                                onChange: (value) {
                                  if(evalutions[pointerType.id] != null){
                                    evalutions[pointerType.id!] = int.parse(value);
                                  }else{
                                    evalutions.addAll({pointerType.id! : int.parse(value)});
                                  }
                                },
                                hintText: "التقييم" ,
                                borderColor: Colors.white,
                              )
                            ),
                          ],
                        );
                      }).toList(),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        else if (state is PointerTypesError) {
          return Center(
            child: TextWidget(
                text: state.message
            )
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
