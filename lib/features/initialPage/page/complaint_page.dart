import 'dart:math';
import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';
import '../Services/page/login_with_patient.dart';
import '../manager/cubit.dart';
import 'initial_page.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  var formKey = GlobalKey<FormState>();
  var complaintCubit = AddComplaintCubit();
  TextEditingController compliantController = TextEditingController();
  late String patientId = CacheHelper.getData(key: 'national_id');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (CacheHelper.getData(key: 'national_id') != null) {
        patientId = CacheHelper.getData(key: 'national_id');
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginWithPatient()));
      }
    });
  }

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InitialPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.arrow_back,
                size: (Constants.mediaQuery.width < 600) ? 10 : 40,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/AEI Logo.png"),
                    fit: (Constants.mediaQuery.width < 600) ? BoxFit.fitWidth : BoxFit.cover,
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
      body: Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/back.jpg"),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: compliantController,
                  hint: 'ادخل الشكوى',
                  maxLength: 50,
                  maxLines: 8,
                ),
                SizedBox(height: 50),
                BorderRoundedButton(
                  title: 'إرسال',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      complaintCubit.addComplaint(compliantController.text, patientId).then((value) {
                        compliantController.clear();
                      });
                    }
                  },
                ),
              ],
            ).setHorizontalPadding(context, enableMediaQuery: false, 20).setVerticalPadding(context, enableMediaQuery: false, 50),
          ),
        ),
      ),
    );
  }
}
