import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../config/constants.dart';
import 'custom_text_field.dart';

class AddFeature extends StatefulWidget {
  final String title;
  final String hintText;
  final String textValidate;
  final String alertText;
  const AddFeature({super.key,required this.title,required this.hintText,required this.textValidate,required this.alertText});

  @override
  State<AddFeature> createState() => _AddFeatureState();
}

class _AddFeatureState extends State<AddFeature> {
  TextEditingController titleController = TextEditingController();
  var formKey = GlobalKey<FormState>();
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
                    Text(widget.title,style:Constants.theme.textTheme.titleLarge?.copyWith(
                        color: Colors.black
                    ),
                      textAlign: TextAlign.start,
                    ),

                  ],
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  width: Constants.mediaQuery.width*0.3,
                  child: CustomTextField(
                    controller: titleController,
                    hint: widget.hintText,
                    onValidate: (value) {
                      if(value==null||value.trim().isEmpty){
                        return widget.textValidate;
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
                  child: Text(widget.title,style:Constants.theme.textTheme.titleLarge?.copyWith(
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
                                  title: Text(widget.alertText, style: Constants.theme
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
