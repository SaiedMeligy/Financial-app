import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';
import '../widget/dialog_delete_patient_recycle.dart';
import '../widget/dialog_recovery_patient_recycle.dart';
import '../widget/table_cycle.dart';

class AllPatientRecycleView extends StatefulWidget {
  const AllPatientRecycleView({super.key});

  @override
  State<AllPatientRecycleView> createState() => _AllPatientRecycleViewState();
}

class _AllPatientRecycleViewState extends State<AllPatientRecycleView> {
  late AllPatientRecycleCubit allPatientCubit;
  ScrollController _scrollController = ScrollController();


  @override
  void initState() {
    super.initState();
    allPatientCubit = AllPatientRecycleCubit();
    allPatientCubit.getAllPatientRecycle(1);
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent-50){
        if(!allPatientCubit.isLoading)
        allPatientCubit.getAllPatientRecycle( 1,loadMore: true);

      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllPatientRecycleCubit, AllPatientRecycleStates>(
      bloc: allPatientCubit,
      builder: (context, state) {
        if (state is LoadingAllPatientRecycle ) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessAllPatientRecycle) {
          var patients = state.patients;
          return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.2)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: PatientCyclebin<Pationts>(
                        label1: "اسم الحالة",
                        label2: "استرجاع",
                        label3: "حذف",
                        items: patients,
                        itemNameBuilder: (item) => item.name ?? 'No Name',
                        itemRecoveryWidgetBuilder: (item) {
                          return DialogRecoveryPatientCycle(
                            allPatientCubit: allPatientCubit,
                            patient: item,
                          );
                        },
                      itemDeleteWidgetBuilder: (item) {
                          return DialogDeletePatientCycle(
                            allPatientCubit: allPatientCubit,
                            patient: item,
                          );
                      }, scrollController: _scrollController,
                      lastPage: allPatientCubit.isLastPage,
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
