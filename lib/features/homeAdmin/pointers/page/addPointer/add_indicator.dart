import 'package:experts_app/features/homeAdmin/pointers/page/addPointer/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/question/widget/radio_answer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/Services/snack_bar_service.dart';
import '../../../../../core/config/constants.dart';
import '../../../../../core/widget/radio_button.dart';
import '../../../../../core/widget/custom_text_field.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';

import 'manager/states.dart';

class AddIndicator extends StatefulWidget {
  const AddIndicator({super.key});

  @override
  State<AddIndicator> createState() => _AddIndicatorState();
}

class _AddIndicatorState extends State<AddIndicator> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  int? selectedScenarioId=0;
  var addPointerCubit = AddPointerCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddPointerCubit, AddPointerStates>(
        bloc: addPointerCubit,
        builder: (context, state) {
          return Container(

            decoration: const BoxDecoration(
              color: Colors.white,
                image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.8
                )

            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "اضافة مؤشر",
                            style: Constants.theme.textTheme.titleLarge
                                ?.copyWith(color: Colors.black),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          RadioAnswerWidget(
                              titleRadio: "اختر السيناريو",
                              items: const [
                                MapEntry("اختر السيناريو  ", 0),
                                MapEntry("السيناريوالأول(الحالات المتوازنة نسبيا)", 1),
                                MapEntry("السيناريوالثاني(للحالات الغير متوازنة في الصرف)", 2),
                                MapEntry("السيناريوالثالث(للحالات المتعثرة ماليا)", 3)
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedScenarioId = value;
                                });
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: Constants.mediaQuery.width * 0.3,
                        child: CustomTextField(
                          controller: titleController,
                          hint: "ادخل عنوان المؤشر",
                          onValidate: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "من فضلك أدخل المؤشر";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Constants.theme.primaryColor.withOpacity(0.5)),
                        child: Text(
                          "اضافة المؤشر",
                          style: Constants.theme.textTheme.bodyLarge

                        ),
                        onPressed: () async {
                          if (selectedScenarioId == 0) {
                            SnackBarService.showErrorMessage(
                                "من فضلك اختر السيناريو");
                          }
                          else if (formKey.currentState!.validate() &&
                              selectedScenarioId != null) {
                            formKey.currentState!.save();
                            try {
                              final response = await addPointerCubit.addPointer(
                                  selectedScenarioId!, titleController.text);
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: AlertDialog(
                                        title: Text(
                                          "تم اضافة المؤشر",
                                          style: Constants
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                        ////////need to be clear
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              titleController.clear();
                                              selectedScenarioId = 0;
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Constants
                                                        .theme.primaryColor,
                                                    width: 2.5,
                                                  ),
                                                ),
                                                child: Text(
                                                  "اغلاق",
                                                  style: Constants.theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ).setHorizontalPadding(
                                                    context,
                                                    enableMediaQuery: false,
                                                    20)),
                                          ),
                                        ],
                                      ),
                                    );
                                  });

                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                      ),
                    ]),
              )
                  .setVerticalPadding(enableMediaQuery: false, context, 20)
                  .setHorizontalPadding(context, enableMediaQuery: false, 10),
            ),
          );
        });
  }
}
