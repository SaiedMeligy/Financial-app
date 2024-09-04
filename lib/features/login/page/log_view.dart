import 'package:animate_do/animate_do.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/initialPage/page/initial_page.dart';
import 'package:experts_app/features/login/manager/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/Services/snack_bar_service.dart';
import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';
import '../../../core/widget/second_text_field.dart';
import '../manager/states.dart';

class LogView extends StatefulWidget {
  const LogView({super.key});

  @override
  State<LogView> createState() => _LogViewState();
}

class _LogViewState extends State<LogView> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var loginCubit =LoginHomeCubit();
  bool isMobile = false;
  @override
  void initState() {
    super.initState();
    CacheHelper.isLoggedInAndNavigate();
  }
  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(
      builder: (context, constraints) {

        isMobile = constraints.maxWidth < 600;

        return BlocBuilder<LoginHomeCubit,HomeStates>(
        bloc: loginCubit,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              leading:  IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return InitialPage();

                },));
              }, icon: Icon(Icons.arrow_back,size: 40,color: Colors.black,)),
            ),
            body: Container(
              width: double.infinity,
              color: Colors.white30,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage("assets/images/back.jpg"),
              //         fit: BoxFit.cover,
              //       opacity: 0.4
              //     )
              // ),
              child:
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: Constants.mediaQuery.height * 0.7,
                                width: isMobile?Constants.mediaQuery.width * 0.8:Constants.mediaQuery.width * 0.3,
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    //color: Constants.theme.primaryColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.black

                                    )
                                ),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: formKey,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Center(
                                          child: FadeInUp(
                                            delay: Duration(microseconds: 100),
                                            child: Text(
                                              "تسجيل الدخول", textAlign: TextAlign.center,
                                              style: Constants.theme.textTheme.titleLarge
                                                  ?.copyWith(
                                                  color: Colors.black
                                              ),),
                                          ),
                                        ),
                                        FadeInRight(
                                          delay: Duration(microseconds: 300),

                                          child: const Divider(
                                            endIndent: 20,
                                            indent: 20,
                                            color: Colors.black38,
                                          ),
                                        ),
                                        SizedBox(height: 25),
                                        FadeInRight(
                                          delay: Duration(microseconds: 500),
                                          child: Text(
                                            "أدخل عنوان البريد الإلكتروني الخاص بك",
                                            style: Constants.theme.textTheme.bodyLarge
                                                ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 20

                                            ),),
                                        ),
                                        SizedBox(height: 10,),
                                        FadeInRight(
                                          delay: Duration(microseconds: 700),
                                          child: SecondTextField(
                                            controller: _emailController,
                                            hint: "ادخل البريد الالكتروني",
                                            keyboardType: TextInputType.emailAddress,
                                            onValidate: (value) {
                                              if (value == null || value
                                                  .trim()
                                                  .isEmpty) {
                                                return "من فضلك ادخل  البريد الالكتروني";
                                              }
                                              return null;
                                            },

                                          ),
                                        ),
                                        SizedBox(height: 15),
                                        FadeInRight(
                                          delay: Duration(microseconds: 900),
                                          child: Text("أدخل كلمة السر",
                                            style: Constants.theme.textTheme.bodyLarge
                                                ?.copyWith(
                                              color: Colors.black,
                                              fontSize: 20

                                            ),),
                                        ),
                                        SizedBox(height: 10,),
                                        FadeInRight(
                                          delay: Duration(microseconds: 1100),
                                          child: SecondTextField(
                                            controller: _passwordController,
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
                                        isMobile?SizedBox(height: 15):SizedBox(height: 60),
                                        Center(
                                          child: FadeInRight(
                                            delay: Duration(microseconds: 1200),
                                            child: ElevatedButton(onPressed: () {
                                              if (formKey.currentState!.validate()) {

                                                loginCubit.login(_emailController.text, _passwordController.text).then((value) {
                                                  if(value){
                                                    print("Done");
                                                    EasyLoading.dismiss();
                                                    SnackBarService.showSuccessMessage("تم تسجيل الدخول بنجاح");

                                                    //  Navigator.of(context).pushNamedAndRemoveUntil(PageRouteName.homeAdmin,
                                                    //    (route) => false
                                                    // );

                                                  }

                                                });

                                              }
                                            },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                ),
                                                child: Text("تسجيل الدخول",
                                                  style: Constants.theme.textTheme
                                                      .bodyLarge,)),
                                          ),
                                        ).setVerticalPadding(context,enableMediaQuery: false,25)
                                      ],
                                    ).setHorizontalPadding(
                                        context, enableMediaQuery: false, 10),
                                  ),
                                ),
                              ).setOnlyPadding(context,enableMediaQuery: false, 0, 0, isMobile?5:50, 0),
                              Image.asset("assets/images/الهوية.png",fit: BoxFit.cover,)

                            ],
                          ).setHorizontalPadding(
                              context, enableMediaQuery: false, 20),
                        ),
                      ),
                    )
                  ]
              ),
            ),
          );
        }
      );}
    );

  }
}
