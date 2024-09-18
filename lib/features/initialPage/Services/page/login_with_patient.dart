import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:experts_app/features/initialPage/Services/manager/cubit.dart';
import 'package:experts_app/features/initialPage/Services/manager/states.dart';
import 'package:experts_app/features/initialPage/Services/page/services_view.dart';
import 'package:flutter/cupertino.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.theme.primaryColor,
        toolbarHeight: (Constants.mediaQuery.width < 600)
            ? Constants.mediaQuery.height * 0.17
            : Constants.mediaQuery.height * 0.24,
        leadingWidth: (Constants.mediaQuery.width < 600)
            ? Constants.mediaQuery.height * 0.21
            : Constants.mediaQuery.width * 0.35,
        leading: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServicesView(),
                    ),
                        (Route<dynamic> route) => false,
                  );
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: (Constants.mediaQuery.width < 600) ? 10 : 40,
                )),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/AEI Logo.png"),
                    fit: (Constants.mediaQuery.width < 600)
                        ? BoxFit.fitWidth
                        : BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
        title: Column(
          children: [
            Text(
              (Constants.mediaQuery.width < 600) ? "العيادة \nالمالية" : "العيادة المالية",
              style: (Constants.mediaQuery.width < 600)
                  ? Constants.theme.textTheme.bodyMedium
                  : Constants.theme.textTheme.titleLarge,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Container(
            height: (Constants.mediaQuery.width < 600)
                ? Constants.mediaQuery.height * 0.10
                : Constants.mediaQuery.height * 0.6,
            width: (Constants.mediaQuery.width < 600)
                ? Constants.mediaQuery.height * 0.12
                : Constants.mediaQuery.width * 0.29,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              image: DecorationImage(
                image: AssetImage("assets/images/لوجو الهيئة.png"),
                fit: (Constants.mediaQuery.width < 600) ? BoxFit.fitWidth : BoxFit.cover,
              ),
            ),
          ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 10),
        ],
      ),
      body: BlocBuilder<AddServiceCubit, AddServiceStates>(
        bloc: loginCubit,
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: (Constants.mediaQuery.width < 600)
                                ? Constants.mediaQuery.width * 0.8
                                : Constants.mediaQuery.width * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  'تسجيل الدخول باستخدام الهوية الرقمية',
                                  style: (Constants.mediaQuery.width < 600)
                                      ? Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black)
                                      : Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.black, fontSize: 28),
                                ).setVerticalPadding(context, enableMediaQuery: false, 20),
                                CustomTextField(
                                  hint: "ادخل رقم الهوية الأماراتية الذي يتكون من 15 رقم",
                                  controller: nationalId,
                                  onValidate: (value) {
                                    if (value == null || value.trim().isEmpty) {
                                      return "من فضلك ادخل رقم الهوية الأماراتية";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 50),
                                BorderRoundedButton(
                                  title: "تسجيل الدخول",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      loginCubit.loginPatient(nationalId.text).then((value) {
                                        if (value) {
                                          SnackBarService.showSuccessMessage("تم تسجيل الدخول بنجاح");
                                          Navigator.pop(context);
                                        }
                                      });
                                    }
                                  },
                                )
                              ],
                            ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                          ),
                          Image.asset(
                            "assets/images/الهوية.png",
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
