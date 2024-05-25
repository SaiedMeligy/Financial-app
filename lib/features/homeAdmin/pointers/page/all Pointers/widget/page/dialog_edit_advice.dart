import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/config/constants.dart';
import '../../../../../../../core/widget/custom_text_field.dart';
import '../../../../../../../domain/entities/pointerModel.dart';
import '../../manager/cubit.dart';
import '../manager/dialog_cubit.dart';
import '../manager/dialog_state.dart';

class DialogEditPointer extends StatefulWidget {
  final Pointers? pointerServices;
  final AllPointersCubit allPointerCubit;

  const DialogEditPointer({
    Key? key,
    this.pointerServices,
    required this.allPointerCubit,
  }) : super(key: key);

  @override
  State<DialogEditPointer> createState() => _DialogEditPointerState();
}

class _DialogEditPointerState extends State<DialogEditPointer> {
  late TextEditingController titleController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UpdatePointerCubit updatePointerCubit;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.pointerServices?.text ?? "");
    updatePointerCubit = UpdatePointerCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdatePointerCubit, UpdatePointerStates>(
      bloc: updatePointerCubit,
      builder: (context, state) {
        return IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
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
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          updatePointerCubit.updatePointer(
                            widget.pointerServices!.id!,
                            titleController.text,
                          ).then((_) {
                            widget.allPointerCubit.getAllPointers();
                            Navigator.of(context).pop();
                          });
                        }
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

