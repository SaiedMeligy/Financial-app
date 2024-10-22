import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/constants.dart';
import '../../manager/cubit.dart';
import '../../manager/states.dart';
import '../manager/dialog_cubit.dart';
import '../manager/dialog_state.dart';


class DialogDeletePatient extends StatefulWidget {
  final Pationts? patient;
  final AllPatientCubit allPatientCubit;
  const DialogDeletePatient({
    Key? key,
    this.patient,
    required this.allPatientCubit,
  }) : super(key: key);

  @override
  State<DialogDeletePatient> createState() => _DialogDeletePatientState();
}

class _DialogDeletePatientState extends State<DialogDeletePatient> {
  late UpdatePatientCubit updatePatientCubit;
  late AllPatientCubit allPatientCubit;

  @override
  void initState() {
    super.initState();
    updatePatientCubit = UpdatePatientCubit();
    allPatientCubit = AllPatientCubit();
  }

  void _deletePatientLocally(Pationts patient) {
    widget.allPatientCubit.patients.removeWhere((p) => p.id == patient.id); // Remove patient from local list
    widget.allPatientCubit.emit(SuccessAllPatient(widget.allPatientCubit.patients)); // Emit updated list
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
          icon: Icon(Icons.delete, color: Colors.white),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: Text("حذف الحالة", style: Constants.theme.textTheme.titleLarge?.copyWith(
                        color: Colors.black
                    )),
                    content: Text("هل أنت متأكد أنك تريد حذف هذه الحالة", style: Constants.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.black
                    )),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Delete patient to trash
                          updatePatientCubit.deletePatient(widget.patient!.id!).then((_) {
                            _deletePatientLocally(widget.patient!); // Remove patient from local list
                            Navigator.of(context).pop();
                          });
                        },
                        child: _buildActionButton("إلى سلة المهملات", context),
                      ),
                      TextButton(
                        onPressed: () {
                          // Permanently delete patient
                          updatePatientCubit.deletePatientFromSystem(widget.patient!.id!).then((_) {
                            _deletePatientLocally(widget.patient!); // Remove patient from local list
                            Navigator.of(context).pop();
                          });
                        },
                        child: _buildActionButton("حذف نهائي", context),
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

  Widget _buildActionButton(String label, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Constants.theme.primaryColor,
          width: 2.5,
        ),
      ),
      child: Text(
        label,
        style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
      ).setHorizontalPadding(context, enableMediaQuery: false, 20),
    );
  }
}



