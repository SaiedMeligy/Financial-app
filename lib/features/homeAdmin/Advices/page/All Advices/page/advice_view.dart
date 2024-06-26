import 'package:experts_app/core/widget/table_widget.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';
import 'package:experts_app/features/homeAdmin/Advices/page/All%20Advices/widget/page/dialog_delete_pointer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Consulting service/All Consultation/widget/dialog_edit.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';
import '../widget/page/dialog_edit_advice.dart';

class EditAdviceView extends StatefulWidget {
  const EditAdviceView({super.key});

  @override
  State<EditAdviceView> createState() => _EditAdviceViewState();
}


class _EditAdviceViewState extends State<EditAdviceView> {
  var allAdviceCubit = AllAdvicesCubit();
  @override
  void initState() {
    super.initState();
    allAdviceCubit.getAllAdvices();
  }
  @override
  Widget build(BuildContext context) {
    return
      BlocBuilder<AllAdvicesCubit, AllAdvicesStates>(
        bloc: allAdviceCubit,
        builder: (context, state) {
          if (state is LoadingAllAdvices) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessAllAdvices) {
            return TableWidget<Advices>(
                label1: "التوصية",
                label2: "التعديل",
                label3: "الحذف",
                items: state.adviceServices,
                itemNameBuilder: (item) => item.text ?? 'No Name',
                itemEditWidgetBuilder: (item) =>
                    DialogEditAdvice(
                      allAdviceCubit: allAdviceCubit,
                        advicesServices:item,

                ),
                itemDeleteWidgetBuilder: (item){
                  if (item == null) {
                    return const Text("Invalid Item");
                  }
                  return
                    DialogDeleteAdvice(
                      allAdviceCubit: allAdviceCubit,
                      advicesServices:item,
                    );
                }
            );
          } else if (state is ErrorAllAdvices) {
            return Center(child: Text(state.errorMessage));
          }
          return const SizedBox.shrink();
        },
      );
    // TableWidget(label1: "التوصية", label2: "التعديل", label3: "الحذف", items: items, itemNameBuilder: (item) => item, itemEditWidgetBuilder: (item) => IconButton(
    //   icon: Icon(Icons.edit),
    //   onPressed: () {
    //     // handle edit action
    //   },
    // ),
    //   itemDeleteWidgetBuilder: (item) => IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
    // );
  }
}
