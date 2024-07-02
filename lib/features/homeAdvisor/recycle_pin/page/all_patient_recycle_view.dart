import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/updatePatient/page/dialog_delete_patient.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/updatePatient/page/dialog_edit_patient.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/widget/patient_widget_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/second_table_widget.dart';
import '../../../../core/widget/table_widget.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';
import '../widget/dialog_delete_patient_recycle.dart';
import '../widget/table_cycle.dart';

class AllPatientRecyclebinView extends StatefulWidget {
  const AllPatientRecyclebinView({super.key});

  @override
  State<AllPatientRecyclebinView> createState() => _AllPatientRecyclebinViewState();
}

class _AllPatientRecyclebinViewState extends State<AllPatientRecyclebinView> {
  late AllPatientRecycleCubit allPatientCubit;

  @override
  void initState() {
    super.initState();
    allPatientCubit = AllPatientRecycleCubit();
    allPatientCubit.getAllPatientRecycle(1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPatientRecycleCubit, AllPatientRecycleStates>(
      bloc: allPatientCubit,
      builder: (context, state) {
        if (state is LoadingAllPatientRecycle)
        {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessAllPatientRecycle) {
          var patients = state.patients;
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back.jpg"),
                fit: BoxFit.cover,
                opacity: 0.8
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                Expanded(
                  child: PatientCyclebin<Pationts>(
                            label1: "اسم الحالة",
                            label2: "الحذف",
                            items: patients,
                            itemNameBuilder: (item) => item.name ?? 'No Name',
                          itemDeleteWidgetBuilder: (item){
                          if (item == null) {
                          return const Text("Invalid Item");
                          }
                           return
                             DialogDeletePatientCycle(allPatientCubit: allPatientCubit,
                          patient: item,);
                            }

                          ),
                ),
                ],
              ),
            ),
          );
        } else if (state is ErrorAllPatientRecycle) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}
