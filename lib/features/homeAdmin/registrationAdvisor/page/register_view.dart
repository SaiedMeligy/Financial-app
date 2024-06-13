import '../manager/cubit.dart';
import '../manager/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../domain/entities/RegisterModel.dart';
import '../../../../core/widget/border_rounded_button.dart';




class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ruleController = TextEditingController();
  var registerCubit = RegisterCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
        bloc: registerCubit,
        builder: (context, state) {
          return Scaffold(
              body: Container(
                height: double.maxFinite,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("اضافة استشاري",style: Constants.theme.textTheme.titleLarge?.copyWith(
                            color:  Colors.black
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          FadeInRight(
                            delay: const Duration(microseconds: 200),
                            child: Text(
                              "الاسم كامل",
                              style: Constants.theme.textTheme.bodyMedium,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          FadeInRight(
                            delay: const Duration(microseconds: 300),
                            child: CustomTextField(
                              controller: nameController,
                              hint: "ادخل اسم الاستشاري",
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
                            delay: const Duration(microseconds: 400),
                            child: Text(
                              "رقم التلفون",
                              style: Constants.theme.textTheme.bodyMedium
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
                                  var data = RegisterDataRequest(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phoneNumber: phoneController.text, rule:"0");

                                  if (formKey.currentState!.validate()) {registerCubit.registerUser(data).then((value) {
                                      if (value) {
                                        nameController.clear();
                                        phoneController.clear();
                                        emailController.clear();
                                        passwordController.clear();
                                        // ruleController.clear();


                                        if(kDebugMode){
                                          print("Done register");
                                        }

                                      }
                                    });

                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        });
  }
}
