
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/config/constants.dart';
import '../../../../../core/widget/custom_text_field.dart';
import 'manager/cubit.dart';
import 'manager/states.dart';

class AddRecommend extends StatefulWidget {
  const AddRecommend({super.key});

  @override
  State<AddRecommend> createState() => _AddRecommendState();
}

class _AddRecommendState extends State<AddRecommend> {
  TextEditingController titleController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  var addAdviceCubit = AddAdviceCubit();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAdviceCubit,AddAdviceState>(
      bloc: addAdviceCubit,
      builder: (context, state) {
        return
          Container(
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back.jpg"),
                fit: BoxFit.cover,
                opacity: 0.2

              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // Align children to the end (bottom) of the column
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("اضافة توصية", style: Constants.theme.textTheme
                              .titleLarge?.copyWith(
                              color: Colors.white
                          ),
                            textAlign: TextAlign.start,
                          ),

                        ],
                      ),
                      const SizedBox(height: 15,),
                      SizedBox(
                        width: Constants.mediaQuery.width * 0.3,
                        child: CustomTextField(
                          controller: titleController,
                          hint: "ادخل عنوان التوصية",
                          onValidate: (value) {
                            if (value == null || value
                                .trim()
                                .isEmpty) {
                              return "من فضلك أدخل التوصية";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Constants.theme.primaryColor
                        ),
                        child: Text("اضافة التوصية", style: Constants.theme.textTheme.bodyLarge),
                        onPressed: () {
                          if (formKey.currentState!.validate())
                          {
                            addAdviceCubit.addAdvice(titleController.text).then((response) {
                             if(response.data["status"]==true){
                               titleController.clear();
                               showDialog(
                                   context: context,
                                   builder: (context) {
                                     return
                                       Directionality(
                                         textDirection: TextDirection.rtl,
                                         child: AlertDialog(
                                           title: Text("تم اضافة التوصية",
                                             style: Constants.theme
                                                 .textTheme.bodyMedium?.copyWith(
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
                                                       enableMediaQuery: false, 20)
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
              )
                  .setVerticalPadding(enableMediaQuery: false, context, 10)
                  .setHorizontalPadding(context, enableMediaQuery: false, 10),

            ).setVerticalPadding(context, enableMediaQuery: false, 30),
          );
      }
    );
      //AddFeature(title: "اضافة توصية", hintText: "ادخل عنوان التوصية", textValidate: "من فضلك أدخل التوصية", alertText: "تم اضافة التوصية");
  }
}
