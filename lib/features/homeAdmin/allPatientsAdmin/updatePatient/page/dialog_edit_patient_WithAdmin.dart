import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/config/constants.dart';
import '../../../../../../../core/widget/custom_text_field.dart';
import '../../../../../domain/entities/AllPatientModel.dart';
import '../../manager/cubit.dart';
import '../manager/dialog_cubit.dart';
import '../manager/dialog_state.dart';


class DialogEditPatientWithAdmin extends StatefulWidget {
  final Pationts? patient;
  final AllPatientWithAdminCubit allPatientCubit;

  const DialogEditPatientWithAdmin({
    Key? key,
    this.patient,
    required this.allPatientCubit,
  }) : super(key: key);

  @override
  State<DialogEditPatientWithAdmin> createState() => _DialogEditPatientWithAdminState();
}

class _DialogEditPatientWithAdminState extends State<DialogEditPatientWithAdmin> {
  late TextEditingController titleController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UpdatePatientWithAdminCubit updatePatientCubit;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.patient?.name ?? "");
    emailController = TextEditingController(text: widget.patient?.email??"");
    phoneController = TextEditingController(text: widget.patient?.phoneNumber??"");
    updatePatientCubit = UpdatePatientWithAdminCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePatientWithAdminCubit, UpdatePatientWithAdminStates>(
      bloc: updatePatientCubit,
      builder: (context, state) {
        return IconButton(
          icon: Icon(Icons.edit,color: Colors.white,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    backgroundColor: Constants.theme.primaryColor,
                    content: Form(
                      key: formKey,
                      child: SizedBox(
                        height:
                        Constants.mediaQuery.height * 0.6,
                        width:
                        Constants.mediaQuery.width * 0.45,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
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
                              SizedBox(height: 10,),
                              CustomTextField(
                                controller: emailController,
                                onValidate: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter the service name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10),
                              CustomTextField(
                                controller: phoneController,
                                onValidate: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Please enter the service name";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          var data =
                            Pationts(
                          name: titleController.text,
                          email: emailController.text,
                          phoneNumber: phoneController.text,
                          );
                          if (formKey.currentState!.validate()) {
                            updatePatientCubit.updatePatientWithAdmin(widget.patient!.id!, data)
                                .then((_) {
                              widget.allPatientCubit.getAllPatientWithAdmin();
                              Navigator.of(context).pop();
                            }
                            );
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
                            style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
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

