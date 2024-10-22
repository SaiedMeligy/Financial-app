import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/recycle_pin/manager/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/constants.dart';
import '../../allPatients/manager/cubit.dart';
import '../../allPatients/updatePatient/manager/dialog_cubit.dart';
import '../../allPatients/updatePatient/manager/dialog_state.dart';


class DialogDeletePatientCycle extends StatefulWidget {
  final Pationts? patient;
  final AllPatientRecycleCubit allPatientCubit;
  const DialogDeletePatientCycle({
    Key? key,
    this.patient,
    required this.allPatientCubit,
  }) : super(key: key);

  @override
  State<DialogDeletePatientCycle> createState() => _DialogDeletePatientCycleState();
}

class _DialogDeletePatientCycleState extends State<DialogDeletePatientCycle> {
  late UpdatePatientCubit updatePatientCubit;

  @override
  void initState() {
    super.initState();
    updatePatientCubit = UpdatePatientCubit();
  }
  void _deletePatientLocally(Pationts patient) {
    widget.allPatientCubit.patients.removeWhere((p) => p.id == patient.id); // Remove patient from local list
    widget.allPatientCubit.emit(SuccessAllPatientRecycle(widget.allPatientCubit.patients)); // Emit updated list
  }


  @override
  Widget build(BuildContext context) {
    if (widget.patient == null) {
      return const Text("No consultation service provided");
    }

    return BlocBuilder<UpdatePatientCubit, UpdatePatientStates>(
      bloc: updatePatientCubit,
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
                          await updatePatientCubit.deletePatientFromSystem(widget.patient!.id!,);
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


