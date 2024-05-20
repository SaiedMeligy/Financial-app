import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/material.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/radio_button.dart';
class AddIndicator extends StatefulWidget {
  const AddIndicator({super.key});

  @override
  State<AddIndicator> createState() => _AddIndicatorState();
}

class _AddIndicatorState extends State<AddIndicator> {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  TextEditingController titleController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  const BoxDecoration(
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
              mainAxisAlignment: MainAxisAlignment.start, // Align children to the end (bottom) of the column
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("اضافة مؤشر",style:Constants.theme.textTheme.titleLarge?.copyWith(
                        color: Colors.black
                    ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(width: 10,),
                    RadioWidget(titleRadio: "اختر السيناريو",item1: "السيناريو الاول",item2: "السيناريو التاني",item3: "السيناريو التالت",),
                  ],
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  width: Constants.mediaQuery.width*0.3,
                  child: CustomTextField(
                    controller: titleController,
                    hint: "ادخل عنوان المؤشر",
                    onValidate: (value) {
                      if(value==null||value.trim().isEmpty){
                        return "من فضلك أدخل المؤشر";
                      }
                      return null;

                    },
                  ),
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Constants.theme.primaryColor.withOpacity(0.5)
                  ),
                  child: Text("اضافة المؤشر",style:Constants.theme.textTheme.titleLarge?.copyWith(
                      color: Colors.black
                  ),),
                  onPressed: (){
                    if(formKey.currentState!.validate()){

                      showDialog(
                          context: context,
                          builder: (context)
                      {
                        return
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: AlertDialog(
                              title: Text("تم اضافة المؤشر", style: Constants.theme
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
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Constants.theme.primaryColor,
                                          width: 2.5,
                                        ),
                                      ),
                                      child: Text("اغلاق",
                                        style: Constants.theme.textTheme.bodyMedium
                                            ?.copyWith(
                                            color: Colors.black
                                        ),).setHorizontalPadding(
                                          context, enableMediaQuery: false, 20)
                                  ),
                                ),
                              ],
                            ),
                          );
                      }
                      );
                    }
                  },
                ),

              ]
          ),
        ).setVerticalPadding(enableMediaQuery: false,context,20).setHorizontalPadding(context,enableMediaQuery: false, 10),

      ),
    );
  }
}
