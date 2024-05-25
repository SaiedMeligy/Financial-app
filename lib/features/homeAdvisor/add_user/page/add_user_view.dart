import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/widget/border_rounded_button.dart';
import '../../../../core/widget/custom_text_field.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({super.key});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ruleController = TextEditingController();
  final idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("اضافة حالة",style: Constants.theme.textTheme.titleLarge?.copyWith(
                        color:  Colors.black
                    ),),
                      SizedBox(
                      height: 10,
                    ),
                    FadeInRight(
                      delay: const Duration(microseconds: 200),
                      child: Text(
                        "الاسم كامل",
                        style: Constants.theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInRight(
                      delay: const Duration(microseconds: 300),
                      child: CustomTextField(
                        controller: nameController,
                        hint: "ادخل اسم الحالة",
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "من فضلك ادخل الاسم ";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInRight(
                      delay: const Duration(microseconds: 200),
                      child: Text(
                        "الرقم القومي",
                        style: Constants.theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInRight(
                      delay: const Duration(microseconds: 300),
                      child: CustomTextField(
                        controller: idController,
                        hint: "ادخل الرقم القومي",
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "من فضلك ادخل الرقم القومي ";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInRight(
                      delay: const Duration(microseconds: 400),
                      child: Text(
                        "رقم التلفون",
                        style: Constants.theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInRight(
                      delay: const Duration(microseconds: 500),
                      child: CustomTextField(
                        controller: phoneController,
                        hint: "ادخل رقم التلفون",
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "من فضلك ادخل رقم التلفون";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FadeInRight(
                      delay: const Duration(microseconds: 700),
                      child: Text(
                        "عنوان البريد الإلكتروني",
                        style: Constants.theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInRight(
                      delay: const Duration(microseconds: 800),
                      child: CustomTextField(
                        controller: emailController,
                        hint: "ادخل البريد الإلكتروني",
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "من فضلك ادخل عنوان البريد الالكتروني";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    FadeInRight(
                      delay: const Duration(microseconds: 900),
                      child: Text(
                        "كلمة السر",
                        style: Constants.theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInRight(
                      delay: const Duration(microseconds: 1000),
                      child: CustomTextField(
                        controller: passwordController,
                        hint: "ادخل كلمة السر",
                        isPassword: true,
                        maxLines: 1,
                        onValidate: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "من فضلك ادخل كلمة السر";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(height: 30),


                    FadeInRight(
                      delay: const Duration(microseconds: 1100),
                      child: BorderRoundedButton(
                          title: "اضافة استشاري",
                          fontSize: 18,
                          color: Constants.theme.primaryColor,
                          onPressed: () {
                            // var data = RegisterDataRequest(
                            //     name: nameController.text,
                            //     email: emailController.text,
                            //     password: passwordController.text,
                            //     phoneNumber: phoneController.text, rule:"0");

                            if (formKey.currentState!.validate()) {
                              // registerCubit
                              //     .registerUser(data)
                              //     .then((value) {
                              //   if (value) {
                              //
                              //     if(kDebugMode){
                              //       print("Done register");
                              //     }
                              //
                              //   }
                              // });

                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
