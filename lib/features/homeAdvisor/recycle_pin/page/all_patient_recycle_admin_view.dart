import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/widget/dialog_delete_patient_recycle_with_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';
import '../widget/table_cycle.dart';

class AllPatientRecycleAdminView extends StatefulWidget {
  const AllPatientRecycleAdminView({super.key});

  @override
  State<AllPatientRecycleAdminView> createState() => _AllPatientRecycleAdminViewState();
}

class _AllPatientRecycleAdminViewState extends State<AllPatientRecycleAdminView> {
  late AllPatientRecycleCubit allPatientCubit;

  @override
  void initState() {
    super.initState();
    allPatientCubit = AllPatientRecycleCubit();
    allPatientCubit.getAllPatientRecycleWithAdmin(1);
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
                opacity: 0.2
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                Expanded(
                  child: PatientCyclebin<Pationts>(
                            label1: "اسم الحالة",
                            label2: "استرجاع",
                            items: patients,
                            itemNameBuilder: (item) => item.name ?? 'No Name',
                          itemDeleteWidgetBuilder: (item){
                           return
                             DialogDeletePatientCycleWithAdmin(allPatientCubit: allPatientCubit,
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
