import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:experts_app/features/initialPage/Services/manager/cubit.dart';
import 'package:experts_app/features/initialPage/Services/manager/states.dart';
import 'package:experts_app/features/initialPage/Services/page/services_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'details_service_view.dart';



class LoginWithPatient extends StatefulWidget {
  const LoginWithPatient({super.key});

  @override
  State<LoginWithPatient> createState() => _LoginWithPatientState();
}

class _LoginWithPatientState extends State<LoginWithPatient> {
  var loginCubit = AddServiceCubit();
  TextEditingController nationalId = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.theme.primaryColor,
          toolbarHeight: Constants.mediaQuery.height * 0.26,
          leadingWidth: Constants.mediaQuery.width * 0.35,
          leading:
          Row(
            children: [
              IconButton(onPressed: (){
               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => ServicesView(),),   (Route<dynamic> route) => false,);
              }, icon: Icon(Icons.arrow_back)),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(10)
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/AEI Logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
          title: Column(
            children: [
              Text(
                "العيادة المالية",
                style: Constants.theme.textTheme.titleLarge,
              ),
              SizedBox(height: 15,),
            ],
          ),
          centerTitle: true,
          actions: [
            Container(
              height: Constants.mediaQuery.height*0.6,
              width: Constants.mediaQuery.width*0.29,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage("assets/images/لوجو الهيئة.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),

          ],
        ),
        body: BlocBuilder<AddServiceCubit,AddServiceStates>(
          bloc: loginCubit,
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text('تسجيل الدخول باستخدام الهوية الرقمية',
                                  style: Constants.theme.textTheme.titleLarge
                                      ?.copyWith(
                                    color: Colors.black,
                                    fontSize: 28,
                                  ),
                                ).setVerticalPadding(
                                    context, enableMediaQuery: false, 20),

                                // OtpTextField(
                                //   cursorColor: Colors.black,
                                //   numberOfFields: 15,
                                //   // Number of fields for the ID
                                //   borderColor: Constants.theme.primaryColor,
                                //   showFieldAsBox: true,
                                //   // Shows the fields as boxes
                                //   fieldWidth: 40,
                                //   // Width of each field box
                                //   textStyle: Constants.theme.textTheme.bodyLarge
                                //       ?.copyWith(
                                //     color: Colors.black,
                                //   ),
                                //   // onCodeChanged: (String code) {
                                //   //   // Handle validation or further logic here
                                //   // },
                                //   onSubmit: (String verificationCode) {
                                //     // Handle submission logic here
                                //     loginCubit.loginPatient(verificationCode).then((value) {
                                //       if (value){
                                //         SnackBarService.showSuccessMessage("تم تسجيل الدخول بنجاح");
                                //         Navigator.pop(context);
                                //
                                //       }
                                //
                                //     });
                                //   },
                                // ),
                                CustomTextField(
                                  hint: "ادخل رقم الهوية الأماراتية الذي يتكون من 15 رقم",
                                  controller: nationalId,
                                    onValidate: (value) {
                                      if (value == null || value.trim().isEmpty) {
                                        return "من فضلك ادخل  رقم الهوية الأماراتية";
                                      }
                                      return null;
                                    }
                                ),

                                SizedBox(height: 50,),

                                BorderRoundedButton(title: "تسجيل الدخول",onPressed: (){
                                  if(formKey.currentState!.validate())
                                      loginCubit.loginPatient(nationalId.text).then((value) {
                                        if (value){
                                          SnackBarService.showSuccessMessage("تم تسجيل الدخول بنجاح");
                                          Navigator.pop(context);

                                        }

                                      });
                                },)
                              ],
                            ).setHorizontalPadding(
                                context, enableMediaQuery: false, 20),
                          ),

                          Image.asset(
                            "assets/images/الهوية.png", fit: BoxFit.cover,)
                        ],
                      )

                    ],
                  ),
                ),
              ),
            );
          }
        ),
      );
  }
}
