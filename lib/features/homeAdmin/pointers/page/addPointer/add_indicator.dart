import 'package:experts_app/features/homeAdmin/pointers/page/addPointer/manager/cubit.dart';
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .start, // Align children to the end (bottom) of the column
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
                          RadioWidget(
                              titleRadio: "اختر السيناريو",
                              items: const [
                                MapEntry("اختر السيناريو  ", 0),
                                MapEntry("السيناريو الاول", 1),
                                MapEntry("السيناريو التاني", 2),
                                MapEntry("السيناريو التالت", 3)
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
                          style: Constants.theme.textTheme.titleLarge
                              ?.copyWith(color: Colors.black),
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
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
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
