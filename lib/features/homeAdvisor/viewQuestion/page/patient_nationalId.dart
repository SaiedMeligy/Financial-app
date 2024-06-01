import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/config/page_route_name.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:experts_app/domain/entities/QuestionView.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/page/store_form.dart';
import 'package:experts_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/cash_helper.dart';

class PatientNationalId extends StatefulWidget {
  const PatientNationalId({super.key});

  @override
  State<PatientNationalId> createState() => _PatientNationalIdState();
}

class _PatientNationalIdState extends State<PatientNationalId> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nationalId = TextEditingController();
  var patientNationalIdCubit = QuestionViewCubit();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionViewCubit,QuestionViewStates>(
      bloc: patientNationalIdCubit,
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Scaffold(
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      'الرقم القومي',
                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                          color: Colors.black
                      )
                  ),
                  SizedBox(height: 10,),
                  CustomTextField(
                    controller: nationalId,
                    hint: 'الرقم القومي',
                    prefixIcon: Icon(Icons.person_outline),
                    onValidate: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return "من فضلك ادخل الرقم القومي ";
                      }
                      return null;
                    },

                  ),
                  SizedBox(height: 20,),
                  BorderRoundedButton(title: "التالي",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        patientNationalIdCubit.getPatientNationalId(nationalId.text).then((value) {
                          if (value.data!= null) {
                            // Navigator.pushNamed(context, PageRouteName.quetionView);
                            Navigator.push(context, MaterialPageRoute(builder:(context) =>  StoreForm(pationt_data: value.data)));
                          } else {
                            SnackBarService.showErrorMessage( "الرقم القومي غير موجود");
                          }
                        });
                        // // getPatient(nationalId.text);
                        // navigatorKey.currentState!.pushNamed(
                        //     PageRouteName.quetionView);
                      }
                    },),
                ]
            ).setHorizontalPadding(context, enableMediaQuery: false, 20),
          ),
        );
      }
    );
  }

  // Future<void> getPatient(String national_id) async {
  //   final dio = Dio();
  //   try {
  //     final response = await dio.get(
  //       '${Constants.baseUrl}/api/advicor/pationt/show',
  //       options: Options(headers: {
  //         "api-password": Constants.apiPassword,
  //         "token": CacheHelper.getData(key: "token")
  //       },
  //       ),
  //       queryParameters: {
  //         "national_id": national_id
  //       }
  //     );
  //     if (response.statusCode == 200) {
  //       print("--------->"+response.toString());
  //
  //       setState(() {
  //       });
  //     } else {
  //       print('Failed to load users. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //   }
  // }

}