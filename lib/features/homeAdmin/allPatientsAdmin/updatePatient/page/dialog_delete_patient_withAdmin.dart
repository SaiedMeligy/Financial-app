import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../core/config/constants.dart';
import '../../../../../domain/entities/AllPatientModel.dart';
import '../../manager/cubit.dart';
import '../manager/dialog_cubit.dart';
import '../manager/dialog_state.dart';


class DialogDeletePatientWithAdmin extends StatefulWidget {
  final Pationts? patient;
  final AllPatientWithAdminCubit allPatientCubit;
  const DialogDeletePatientWithAdmin({
    Key? key,
    this.patient,
    required this.allPatientCubit,
  }) : super(key: key);

  @override
  State<DialogDeletePatientWithAdmin> createState() => _DialogDeletePatientWithAdminState();
}

class _DialogDeletePatientWithAdminState extends State<DialogDeletePatientWithAdmin> {
  late UpdatePatientWithAdminCubit updatePatientCubit;

  @override
  void initState() {
    super.initState();
    updatePatientCubit = UpdatePatientWithAdminCubit();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.patient == null) {
      return const Text("No consultation service provided");
    }

    return BlocBuilder<UpdatePatientWithAdminCubit, UpdatePatientWithAdminStates>(
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
                        onPressed: () {
                          updatePatientCubit.
                          deletePatient(
                            widget.patient!.id!,
                          ).then((_) {
                            widget.allPatientCubit.getAllPatientWithAdmin();
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
                            "لسلة المهملات",
                            style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                          ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          updatePatientCubit.
                          deletePatientFromSystem(
                            widget.patient!.id!,
                          ).then((_) {
                            widget.allPatientCubit.getAllPatientWithAdmin();
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


