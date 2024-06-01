import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/constants.dart';
import '../../manager/cubit.dart';
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

  @override
  void initState() {
    super.initState();
    updatePatientCubit = UpdatePatientCubit();
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
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("حذف الحالة",style:Constants.theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black
                  ),),
                  content: Text("هل أنت متأكد أنك تريد حذف هذه الحالة ",style:Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black
                  ),),
                  actions: [
                    TextButton(
                      onPressed: () {
                        updatePatientCubit.
                        deletePatient(
                          widget.patient!.id!,
                        ).then((_) {
                          widget.allPatientCubit.getAllPatient();
                          Navigator.of(context).pop();
                        });
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
                          "موافق",
                          style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                        ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}


