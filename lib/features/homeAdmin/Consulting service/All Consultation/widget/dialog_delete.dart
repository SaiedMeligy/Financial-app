import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/constants.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../domain/entities/ConsultationViewModel.dart';
import '../manager/cubit.dart';
import 'manager/dialog_cubit.dart';
import 'manager/dialog_state.dart';


class DialogDelete extends StatefulWidget {
  final ConsultationServices? consultationServices;
  final AllConsultationCubit allConsultationCubit;

  const DialogDelete({
    Key? key,
    this.consultationServices,
    required this.allConsultationCubit,
  }) : super(key: key);

  @override
  State<DialogDelete> createState() => _DialogDeleteState();
}

class _DialogDeleteState extends State<DialogDelete> {
  late UpdateConsultationCubit updateConsultationCubit;

  @override
  void initState() {
    super.initState();
    updateConsultationCubit = UpdateConsultationCubit();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.consultationServices == null) {
      return const Text("No consultation service provided");
    }

    return BlocBuilder<UpdateConsultationCubit, UpdateConsultationStates>(
      bloc: updateConsultationCubit,
      builder: (context, state) {
        return IconButton(
          icon: Icon(Icons.delete,color: Colors.white70,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    backgroundColor: Constants.theme.primaryColor.withOpacity(0.8),
                    // backgroundColor: Colors.white87,
                    title: Text("حذف الخدمة الاستشارية",style:Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.white)),
                    content: Text("هل أنت متأكد أنك تريد حذف هذه الخدمة ",style:Constants.theme.textTheme.bodyMedium?.copyWith(
                         color: Colors.white
                    ),),
                    actions: [
                      TextButton(
                        onPressed: () {
                          updateConsultationCubit.deleteConsultation(
                            widget.consultationServices!.id!,
                          ).then((_) {
                            widget.allConsultationCubit.getAllConsultations();
                            Navigator.of(context).pop();
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2.5,
                            ),
                          ),
                          child: Text(
                            "موافق",
                            style: Constants.theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white
                            ),
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


