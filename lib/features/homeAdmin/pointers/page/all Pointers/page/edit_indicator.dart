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
          return TabItemWidget(
            item1: "السيناريو الاول",
            item2: "السيناريو التاني",
            item3: "السيناريو التالت",
            firstWidget: TableWidget<Pointers>(
              label1: 'المؤشر',
              label2: 'التعديل',
              label3: 'الحذف',
              items: state.pointers1,
              itemNameBuilder: (item) => item.text ?? "No name",
              itemEditWidgetBuilder: (item) =>
              //     IconButton(
              //   icon: Icon(Icons.edit),
              //   onPressed: () {
              //     // handle edit action
              //   },
              // ),
              DialogEditPointer(
                allPointerCubit: allPointerCubit,
                pointerServices:item,
              ),
              itemDeleteWidgetBuilder: (item) =>
                  DialogDeletePointer(
                    allPointerCubit: allPointerCubit,
                    pointerServices:item,
                  )

              //     IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: () {
              //     // handle delete action
              //   },
              // ),
            ),
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

              //     IconButton(
              //   icon: Icon(Icons.edit),
              //   onPressed: () {
              //     // handle edit action
              //   },
              // ),
              itemDeleteWidgetBuilder: (item) =>
                  DialogDeletePointer(
                    allPointerCubit: allPointerCubit,
                    pointerServices:item,
                  )
              //     IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: () {
              //     // handle delete action
              //   },
              // ),
            ),
            thirdWidget: TableWidget<Pointers>(
              label1: 'المؤشر',
              label2: 'التعديل',
              label3: 'الحذف',
              items: state.pointers3,
              itemNameBuilder: (item) => item.text ?? "",
              itemEditWidgetBuilder: (item) =>
              //     IconButton(
              //   icon: Icon(Icons.edit),
              //   onPressed: () {
              //     // handle edit action
              //   },
              // ),
              DialogEditPointer(
                allPointerCubit: allPointerCubit,
                pointerServices:item,
              ),
              itemDeleteWidgetBuilder: (item) =>
                  DialogDeletePointer(
                    allPointerCubit: allPointerCubit,
                    pointerServices:item,
                  )
              //     IconButton(
              //   icon: Icon(Icons.delete),
              //   onPressed: () {
              //     // handle delete action
              //   },
              // ),
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
