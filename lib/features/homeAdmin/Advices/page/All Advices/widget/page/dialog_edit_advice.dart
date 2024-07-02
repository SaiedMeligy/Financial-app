import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../core/config/constants.dart';
import '../../../../../../../core/widget/custom_text_field.dart';
import '../../manager/cubit.dart';
import '../manager/dialog_cubit.dart';
import '../manager/dialog_state.dart';


class DialogEditAdvice extends StatefulWidget {
  final Advices? advicesServices;
  final AllAdvicesCubit allAdviceCubit;

  const DialogEditAdvice({
    Key? key,
    this.advicesServices,
    required this.allAdviceCubit,
  }) : super(key: key);

  @override
  State<DialogEditAdvice> createState() => _DialogEditAdviceState();
}

class _DialogEditAdviceState extends State<DialogEditAdvice> {
  late TextEditingController titleController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late UpdateAdviceCubit updateAdviceCubit;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.advicesServices?.text ?? "");
    updateAdviceCubit = UpdateAdviceCubit();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateAdviceCubit, UpdateAdviceStates>(
      bloc: updateAdviceCubit,
      builder: (context, state) {
        return IconButton(
          icon: Icon(Icons.edit,color: Colors.white70,),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Directionality(
                  textDirection: TextDirection.ltr,
                  child: AlertDialog(
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
                            updateAdviceCubit.updateAdvice(
                              widget.advicesServices!.id!,
                              titleController.text,
                            ).then((_) {
                              widget.allAdviceCubit.getAllAdvices();
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

