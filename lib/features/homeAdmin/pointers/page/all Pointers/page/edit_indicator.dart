import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experts_app/core/widget/tab_item_widget.dart';
import 'package:experts_app/core/widget/table_widget.dart';
import 'package:experts_app/domain/entities/pointerModel.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/all%20Pointers/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/pointers/page/all%20Pointers/manager/states.dart';

import '../widget/page/dialog_delete_advice.dart';
import '../widget/page/dialog_edit_advice.dart';

class EditIndicator extends StatefulWidget {
  const EditIndicator({super.key});

  @override
  State<EditIndicator> createState() => _EditIndicatorState();
}

class _EditIndicatorState extends State<EditIndicator> {
  var allPointerCubit = AllPointersCubit();

  @override
  void initState() {
    super.initState();
    allPointerCubit.getAllPointers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPointersCubit, AllPointersStates>(
      bloc: allPointerCubit,
      builder: (context, state) {
        if (state is LoadingAllPointers) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessAllPointers) {
          return Scaffold(
            body: Container(
                  height: double.maxFinite,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/back.jpg"),
                          fit: BoxFit.cover,
                        opacity: 0.4
                      ),
                  ),

              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color:Colors.black,
                              width: 2,
                            )
                        ),
                        child: Text("المؤشرات", style: Constants.theme.textTheme
                            .titleLarge?.copyWith(
                            color: Colors.black,
                            fontSize: 27
                        ),),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabItemWidget(
                      item1: "السيناريوالأول(الحالات المتوازنة نسبيا)",
                      item2: "السيناريوالثاني(للحالات الغير متوازنة في الصرف)",
                      item3: "السيناريوالثالث(للحالات المتعثرة ماليا)",
                      firstWidget:
                      TableWidget<Pointers>(
                        label1: 'المؤشر',
                        label2: 'التعديل',
                        label3: 'الحذف',
                        items: state.pointers1,
                        itemNameBuilder: (item) => item.text ?? "No name",
                        itemEditWidgetBuilder: (item) =>
                        DialogEditPointer(
                          allPointerCubit: allPointerCubit,
                          pointerServices:item,
                        ),
                        itemDeleteWidgetBuilder: (item) =>
                            DialogDeletePointer(
                              allPointerCubit: allPointerCubit,
                              pointerServices:item,
                            )

                      ).setVerticalPadding(context,enableMediaQuery: false,20),
                      secondWidget: TableWidget<Pointers>(
                        label1: 'المؤشر',
                        label2: 'التعديل',
                        label3: 'الحذف',
                        items: state.pointers2,
                        itemNameBuilder: (item) => item.text ?? "",
                        itemEditWidgetBuilder: (item) =>
                            DialogEditPointer(
                              allPointerCubit: allPointerCubit,
                              pointerServices:item,
                            ),
                        itemDeleteWidgetBuilder: (item) =>
                            DialogDeletePointer(
                              allPointerCubit: allPointerCubit,
                              pointerServices:item,
                            )
                      ).setVerticalPadding(context,enableMediaQuery: false,20),
                      thirdWidget: TableWidget<Pointers>(
                        label1: 'المؤشر',
                        label2: 'التعديل',
                        label3: 'الحذف',
                        items: state.pointers3,
                        itemNameBuilder: (item) => item.text ?? "",
                        itemEditWidgetBuilder: (item) =>
                        DialogEditPointer(
                          allPointerCubit: allPointerCubit,
                          pointerServices:item,
                        ),
                        itemDeleteWidgetBuilder: (item) =>
                            DialogDeletePointer(
                              allPointerCubit: allPointerCubit,
                              pointerServices:item,
                            )
                      ).setVerticalPadding(context,enableMediaQuery: false,20),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ErrorAllPointers) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
