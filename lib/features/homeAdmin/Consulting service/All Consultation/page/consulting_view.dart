import 'package:experts_app/core/widget/table_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../domain/entities/ConsultationViewModel.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';
import '../widget/dialog_delete.dart';
import '../widget/dialog_edit.dart';

class ConsultingView extends StatefulWidget {
  const ConsultingView({super.key});

  @override
  State<ConsultingView> createState() => _ConsultingViewState();
}

class _ConsultingViewState extends State<ConsultingView> {
  var allConsultationCubit = AllConsultationCubit();

  @override
  void initState() {
    super.initState();
    allConsultationCubit.getAllConsultations();
  }

  @override
  Widget build(BuildContext context) {
    return
     BlocBuilder<AllConsultationCubit, AllConsultationStates>(
      bloc: allConsultationCubit,
      builder: (context, state) {
        if (state is LoadingAllConsultations) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessAllConsultations) {
          return TableWidget<ConsultationServices>(
            label1: "الخدمة الاستشارية",
            label2: "التعديل",
            label3: "الحذف",
            items: state.consultationServices,
            itemNameBuilder: (item) => item.name ?? 'No Name',
            itemEditWidgetBuilder: (item) => DialogEdit(
              consultationServices: item,
              allConsultationCubit: allConsultationCubit,
            ),
            itemDeleteWidgetBuilder: (item){
              if (item == null) {
            return const Text("Invalid Item");
          }
                return DialogDelete(allConsultationCubit: allConsultationCubit,
                consultationServices: item,);}
          );
        } else if (state is ErrorAllConsultations) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

