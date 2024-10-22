import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/updatePatient/manager/dialog_cubit.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/manager/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/constants.dart';
import '../../../homeAdmin/allPatientsAdmin/updatePatient/manager/dialog_state.dart';
import '../../allPatients/manager/cubit.dart';
import '../../allPatients/updatePatient/manager/dialog_cubit.dart';
import '../../allPatients/updatePatient/manager/dialog_state.dart';


class DialogDeletePatientCycleWithAdmin extends StatefulWidget {
  final Pationts? patient;
  final AllPatientRecycleCubit allPatientCubit;
  const DialogDeletePatientCycleWithAdmin({
    Key? key,
    this.patient,
    required this.allPatientCubit,
  }) : super(key: key);

  @override
  State<DialogDeletePatientCycleWithAdmin> createState() => _DialogDeletePatientCycleWithAdminState();
}

class _DialogDeletePatientCycleWithAdminState extends State<DialogDeletePatientCycleWithAdmin> {
  late UpdatePatientWithAdminCubit updatePatientWithAdminCubit;

  @override
  void initState() {
    super.initState();
    updatePatientWithAdminCubit = UpdatePatientWithAdminCubit();
  }
  void _deletePatientLocally(Pationts patient) {
    widget.allPatientCubit.patients.removeWhere((p) => p.id == patient.id);
    widget.allPatientCubit.recyclePatients.removeWhere((p) => p.id == patient.id); // Update recyclePatients too
    widget.allPatientCubit.emit(SuccessAllPatientRecycleWithAdmin(widget.allPatientCubit.recyclePatients));
  }


  @override
  Widget build(BuildContext context) {
    if (widget.patient == null) {
      return const Text("No consultation service provided");
    }

    return BlocBuilder<UpdatePatientWithAdminCubit, UpdatePatientWithAdminStates>(
      bloc: updatePatientWithAdminCubit,
      builder: (context, state) {
        return IconButton(
          icon: Icon(Icons.delete,color: Colors.white,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: Text("حذف الحالة",style:Constants.theme.textTheme.titleLarge?.copyWith(
                        color: Colors.black
                    ),),
                    content: Text("هل أنت متأكد أنك تريد حذف هذه الحالة ",style:Constants.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black
                    ),),
                    actions: [
                      TextButton(
                        onPressed: () async{
                          await updatePatientWithAdminCubit.deletePatientFromSystem(widget.patient!.id!,);
                          _deletePatientLocally(widget.patient!);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Constants.theme.primaryColor,
                              width: 2.5,
                            ),
                          ),
                          child: Text(
                            "حذف نهائي",
                            style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                          ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}


