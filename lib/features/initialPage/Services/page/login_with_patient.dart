import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';



class LoginWithPatient extends StatelessWidget {
  const LoginWithPatient({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.theme.primaryColor,
          toolbarHeight: Constants.mediaQuery.height * 0.24,
          leadingWidth: Constants.mediaQuery.width * 0.3,
          leading:
          Row(
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
              Expanded(
                child: Container(
                  height: Constants.mediaQuery.height*0.65,
                  width: Constants.mediaQuery.width*0.4,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/logo2.png"),
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
              width: Constants.mediaQuery.width*0.27,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white70,
                image: DecorationImage(
                  image: AssetImage("assets/images/لوجو الهيئة.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),

          ],
        ),

        body: Directionality(
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
                  style: Constants.theme.textTheme.titleLarge?.copyWith(
                    color: Colors.black,
                    fontSize: 28,
                  ),
                ).setVerticalPadding(context, enableMediaQuery: false, 20),

                OtpTextField(
                  numberOfFields: 15, // Number of fields for the ID
                  borderColor: Constants.theme.primaryColor,
                  showFieldAsBox: true, // Shows the fields as boxes
                  fieldWidth: 40, // Width of each field box
                  onCodeChanged: (String code) {
                    // Handle validation or further logic here
                  },
                  onSubmit: (String verificationCode) {
                    // Handle submission logic here
                  },
                ),

                SizedBox(height: 50,),

                BorderRoundedButton(title: "تسجيل الدخول"),
              ],
            ).setHorizontalPadding(context, enableMediaQuery: false, 20),
          ),

          Image.asset("assets/images/الهوية.png",fit: BoxFit.cover,)
                ],
              )
            
            ],
                ),
          ),
        ),
      );
  }
}
