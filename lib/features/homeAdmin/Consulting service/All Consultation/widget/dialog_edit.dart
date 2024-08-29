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


class DialogEdit extends StatefulWidget {
  final ConsultationServices? consultationServices;
  final AllConsultationCubit allConsultationCubit;

  const DialogEdit({
    Key? key,
    this.consultationServices,
    required this.allConsultationCubit,
  }) : super(key: key);

  @override
  State<DialogEdit> createState() => _DialogEditState();
}

class _DialogEditState extends State<DialogEdit> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UpdateConsultationCubit updateConsultationCubit;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.consultationServices?.name ?? "");
    descriptionController = TextEditingController(text: widget.consultationServices?.description ?? "");
    updateConsultationCubit = UpdateConsultationCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateConsultationCubit, UpdateConsultationStates>(
      bloc: updateConsultationCubit,
      builder: (context, state) {
        return
          IconButton(
          icon: Icon(Icons.edit,color: Colors.white70,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    backgroundColor: Constants.theme.primaryColor,
                    // backgroundColor: Colors.black87,
                    content: Form(
                      key: formKey,
                      child: SizedBox(
                        height:
                        Constants.mediaQuery.height * 0.6,
                        width:
                        Constants.mediaQuery.width * 0.45,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              controller: titleController,
                              onValidate: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter the service name";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            CustomTextField(
                              controller: descriptionController,
                              maxLines: 4,
                              onValidate: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Please enter the description";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            updateConsultationCubit.updateConsultation(
                              widget.consultationServices!.id!,
                              titleController.text,
                              descriptionController.text,
                            ).
                            then((_) {
                              widget.allConsultationCubit.getAllConsultationsAdmin();
                              Navigator.of(context).pop();
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                              width: 2.5,
                            ),
                          ),
                          child: Text(
                            "موافق",
                            style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.white)
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

