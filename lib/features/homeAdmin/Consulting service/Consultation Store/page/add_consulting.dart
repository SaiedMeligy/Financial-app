import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/constants.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';

class AddConsulting extends StatefulWidget {
  const AddConsulting({super.key});

  @override
  State<AddConsulting> createState() => _AddConsultingState();
}

class _AddConsultingState extends State<AddConsulting> {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  var consultationCubit = ConsultationStoreCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsultationStoreCubit,ConsultationStoreStates>(
      bloc: consultationCubit,
      builder: (context, state) {
        return Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
              opacity: 0.8
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: ListView(
                  children: [
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        // Align children to the end (bottom) of the column
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("اضافة خدمة استشارية",
                                style: Constants.theme.textTheme.titleLarge
                                    ?.copyWith(
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(width: 10,),
                            ],
                          ),
                          const SizedBox(height: 15,),
                          SizedBox(
                            width: Constants.mediaQuery.width * 0.3,
                            child: CustomTextField(
                              controller: titleController,
                              hint: "ادخل الخدمة الاستشارية",
                              onValidate: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return "من فضلك أدخل الخدمة";
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            width: Constants.mediaQuery.width * 0.3,
                            child: CustomTextField(
                              controller: descriptionController,
                              maxLines: 4,
                              hint: "الوصف",
                              onValidate: (value) {
                                if (value == null || value
                                    .trim()
                                    .isEmpty) {
                                  return "من فضلك أدخل الوصف";
                                }
                                return null;
                              },
                            ),
                          ).setVerticalPadding(
                              context, enableMediaQuery: false, 15),
                          const SizedBox(height: 10,),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.theme.primaryColor
                                    .withOpacity(0.5)
                            ),
                            child: Text("اضافة خدمة استشارية",
                              style: Constants.theme.textTheme.titleLarge
                                  ?.copyWith(
                                  color: Colors.black
                              ),),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                var consultationStore = ConsultationStore(name: titleController.text, description: descriptionController.text);
                                consultationCubit.addConsultationStore(consultationStore).then((response) {
                                  if (response.data["status"]==true){
                                    print("تم اضافة الخدمة");
                                    titleController.clear();
                                    descriptionController.clear();
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return
                                            Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: AlertDialog(
                                                title: Text(
                                                  "تم اضافة الخدمة الاستشارية",
                                                  style: Constants.theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                      color: Colors.black
                                                  ),),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius
                                                              .circular(10),
                                                          border: Border.all(
                                                            color: Constants.theme
                                                                .primaryColor,
                                                            width: 2.5,
                                                          ),
                                                        ),
                                                        child: Text("اغلاق",
                                                          style: Constants.theme
                                                              .textTheme.bodyMedium
                                                              ?.copyWith(
                                                              color: Colors.black
                                                          ),).setHorizontalPadding(
                                                            context,
                                                            enableMediaQuery: false,
                                                            20)
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                        }
                                    );

                                  }
                                });

                              }
                            },
                          ),

                        ]
                    ),
                  ]
              ),
            )
                .setVerticalPadding(enableMediaQuery: false, context, 20)
                .setHorizontalPadding(context, enableMediaQuery: false, 10),

          ),
        );
      }
    );
  }
}
