import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/page/store_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PatientNationalId extends StatefulWidget {
  const PatientNationalId({super.key});

  @override
  State<PatientNationalId> createState() => _PatientNationalIdState();
}

class _PatientNationalIdState extends State<PatientNationalId> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nationalId = TextEditingController();
  bool isMobile = false;
   var patientNationalIdCubit = QuestionViewCubit();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
      isMobile = constraints.maxWidth < 600;
      return BlocBuilder<QuestionViewCubit,QuestionViewStates>(
        bloc: patientNationalIdCubit,
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.8,
                  ),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                          'رقم الهوية الأماراتية',
                          style: Constants.theme.textTheme.titleLarge?.copyWith(
                            color: Colors.black
                          )
                      ),
                      SizedBox(height: 10,),
                      CustomTextField(
                        controller: nationalId,
                        hint: 'رقم الهوية الأماراتية',
                        prefixIcon: Icon(Icons.person_outline),
                        onValidate: (value) {
                          if (value == null || value
                              .trim()
                              .isEmpty) {
                            return "من فضلك ادخل رقم الهوية الأماراتية ";
                          }
                          return null;
                        },

                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(child:Text( "التالي",style: Constants.theme.textTheme.bodyLarge,),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            patientNationalIdCubit.getPatientNationalId(nationalId.text).then((value)
                            {
                              if (value.data!= null&&value.data["pationt"]["form"]!=null) {
                                  SnackBarService.showErrorMessage("تم التسجيل لهذه الحالة من قبل");

                              }
                              else {
                                 SnackBarService.showSuccessMessage(value.data["message"]);
                                 Navigator.push(context, MaterialPageRoute(builder:(context) =>  StoreForm(pationt_data: value.data)));


                                // SnackBarService.showErrorMessage( value.data["message"]);
                              }
                            }
                            );
                          }
                        },),
                    ]
                ).setHorizontalPadding(context, enableMediaQuery: false, isMobile?50:200),
              ),
            ),
          );
        }
      );}
    );
  }


}