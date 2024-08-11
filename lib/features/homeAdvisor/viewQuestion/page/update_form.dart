// import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
//
// import '../../../homeAdmin/addSession/manager/cubit.dart';
// import '../manager/cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/config/cash_helper.dart';
// import '../../../../../core/config/constants.dart';
// import '../../../../core/Services/snack_bar_service.dart';
// import 'package:experts_app/core/extensions/padding_ext.dart';
// import '../../../../domain/entities/ConsultationViewModel.dart';
// import 'package:experts_app/core/widget/border_rounded_button.dart';
// import '../../../homeAdmin/Consulting service/All Consultation/manager/cubit.dart';
// import 'package:experts_app/features/homeAdmin/Consulting%20service/All%20Consultation/manager/states.dart';
// class UpdateForm extends StatefulWidget {
//   final dynamic pationt_data;
//
//   UpdateForm({required this.pationt_data});
//
//   @override
//   _UpdateFormState createState() => _UpdateFormState(this.pationt_data);
// }
//
// class _UpdateFormState extends State<UpdateForm> {
//   final dynamic pationt_data;
//   _UpdateFormState(this.pationt_data);
//
//   late AddSessionCubit _patientFormViewCubit;
//   Map<int, TextEditingController> textControllers = {};
//   Map<int, String> selectedAnswers = {};
//   Map<int, bool> checkboxValues = {};
//   late Map<dynamic, dynamic> answers = {};
//   late Map<dynamic, dynamic> radiosBtn = {};
//
//   int needOtherSession = 0;
//    ConsultationServices? selected_consultation;
//   @override
//   void initState() {
//     super.initState();
//     _patientFormViewCubit = AddSessionCubit();
//     _patientFormViewCubit.getSessionDetails(widget.pationt_data.nationalId); //**
//     // selected_consultation_service = consultation["id"];
//   }
//
//   @override
//   void dispose() {
//     _patientFormViewCubit.close();
//     textControllers.forEach((key, controller) {
//       controller.dispose();
//     });
//     super.dispose();
//   }
//
//   void _initializeTextControllers(List<dynamic> answers) {
//     for (var answer in answers) {
//       for (var option in answer["question_options"]) {
//         if (option["type"] == 3 && option["answer"] != null) {
//           textControllers[int.parse(option["id"].toString())] =
//               TextEditingController(text: option["answer"]);
//         }
//         if (option["type"] == 1 && option["answer"] == "1") {
//           selectedAnswers[int.parse(answer["id"].toString())] =
//               option["id"].toString();
//         }
//         if (option["type"] == 2) {
//           checkboxValues[int.parse(option["id"].toString())] =
//               option["answer"] == "1";
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddSessionCubit, AddSessionStates>(
//       bloc: _patientFormViewCubit,
//       builder: (context, state) {
//         if (state is LoadingAddSessionState) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is ErrorAddSessionState) {
//           return Center(child: Text(state.errorMessage));
//         } else if (state is SuccessAddSessionState) {
//
//           var formData = state.result.data["pationt"]["form"];
//           var patient = formData["pationt"];
//           var advisor = formData["advicor"];
//           var questionAnswer = formData["answers"];
//           ConsultationServices consultation = ConsultationServices.fromJson(formData["consultationService"] );
//           if(selected_consultation==null)
//           {
//             selected_consultation = consultation;
//           }
//
//           // print("*******************>" + (consultation["name"]));
//           // print("*******************>" + (consultation["description"]));
//           print("*******************>" + advisor.toString());
//           // int selectedConsultationService = consultation["id"];
//           _initializeTextControllers(questionAnswer);
//           TextEditingController commentController = TextEditingController(text: formData["comments"]);
//           if (answers.isEmpty) {
//             for (int index = 0; index < questionAnswer.length; index++) {
//               radiosBtn[questionAnswer[index]["id"]] = -1;
//               for (int i = 0;
//                   i < questionAnswer[index]["question_options"].length;
//                   i++) {
//                 answers[questionAnswer[index]["question_options"][i]["id"]] = 0;
//                 radiosBtn.addAll({
//                   questionAnswer[index]["id"]: -1,
//                 });
//                 answers.addAll({
//                   questionAnswer[index]["question_options"][i]["id"]: 0,
//                 });
//                 if (questionAnswer[index]["question_options"][i]["type"] == 3) {
//                   textControllers.addAll({
//                     questionAnswer[index]["question_options"][i]["id"]:
//                         TextEditingController(text: ""),
//                   });
//                 }
//               }
//             }
//           }
//           return Directionality(
//             textDirection: TextDirection.rtl,
//             child: Scaffold(
//               body: Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/back.jpg"),
//                     fit: BoxFit.cover,
//                     opacity: 0.8,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: Constants.mediaQuery.height * 0.2,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         color: Constants.theme.primaryColor,
//                       ),
//                       child: Stack(
//                         alignment: Alignment.center,
//                         children: [
//                           Positioned(
//                             top: 0,
//                             left: 0,
//                             child: IconButton(
//                               icon: Icon(Icons.arrow_back),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     Expanded(
//                       child: Container(
//                         height: Constants.mediaQuery.height * 0.8,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Constants.theme.primaryColor.withOpacity(0.3),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: ListView.builder(
//                           itemCount: questionAnswer.length + 1,
//                           itemBuilder: (context, index) {
//                             if (index < questionAnswer.length) {
//                               var answer = questionAnswer[index];
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Center(
//                                     child: Text(
//                                       answer["title"],
//                                       style: Constants
//                                           .theme.textTheme.titleLarge
//                                           ?.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     width: double.infinity,
//                                     height: answer["question_options"].length >
//                                             1
//                                         ? answer["question_options"].length * 65
//                                         : 70,
//                                     margin: const EdgeInsets.symmetric(
//                                         horizontal: 20, vertical: 20),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         topRight: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Column(
//                                       children: answer["question_options"].map<Widget>((option) {
//                                         TextEditingController optionController = TextEditingController(text: option["answer"]);
//                                         return Row(
//                                           children: [
//
//                                             Expanded(
//                                               child: Text(
//                                                 option["title"].toString(),
//                                                 style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                             if (option["type"] == 1 )
//                                               Expanded(
//                                                 child: Radio<bool>(
//                                                   value: option["answer"]=="1"?true:false,
//                                                   groupValue: true,
//                                                   onChanged: (value) {},
//                                                 ),
//                                               ),
//                                             if (option["type"] == 2 )
//                                               Expanded(
//                                                 child: Checkbox(
//                                                   value: option["answer"]=="1"?true:false,
//                                                   onChanged: (value) {},
//                                                 ),
//                                               ),
//                                             if (option["type"] == 3 && option["answer"] != null)
//                                               Expanded(
//                                                 child: Text(
//                                                   option["answer"].toString(),
//                                                   style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                         // TextField(
//                                         // controller: optionController,
//                                         // style: Constants.theme.textTheme.bodyMedium
//                                         //     ?.copyWith(
//                                         // color: Colors
//                                         //     .black, // Change to your desired text color
//                                         // ),
//                                         // ),
//                                           ],
//                                         );
//                                       }).toList(),
//                                     ).setHorizontalPadding(
//                                         context, enableMediaQuery: false, 40),
//                                   ),
//                                   Divider(
//                                     thickness: 2,
//                                     height: 3,
//                                     indent: 20,
//                                     endIndent: 20,
//                                     color: Colors.grey.shade600,
//                                   ),
//                                   SizedBox(height: 10),
//                                 ],
//                               );
//                             } else {
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   DropDownButtonConsultaionWidget(
//
//                                     onChange: (value) {
//                                       setState(() {
//                                         selected_consultation = value;
//                                         print("=============>"+selected_consultation!.description.toString());
//                                       });
//                                     },
//                                     selectedValue: selected_consultation??consultation,
//                                   ),
//                                   SizedBox(height: 10),
//                                   Container(
//                                     height: Constants.mediaQuery.height * 0.15,
//                                     width: double.infinity,
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         topRight: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Text(
//                                       selected_consultation?.description??'',
//                                       style: Constants.theme.textTheme.bodyMedium
//                                           ?.copyWith(color: Colors.black,
//                                       ),
//                                     ).setHorizontalPadding(
//                                         context, enableMediaQuery: false, 20),
//                                   ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                                   SizedBox(height: 20),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "ملاحظات الاستشاري",
//                                         style:
//                                             Constants.theme.textTheme.bodyLarge,
//                                       ),
//                                     ],
//                                   ),
//                                   SizedBox(height: 10),
//                                   TextField(
//                                     controller: commentController,
//                                     style: Constants.theme.textTheme.bodyMedium
//                                         ?.copyWith(
//                                       color: Colors
//                                           .black, // Change to your desired text color
//                                     ),
//                                     decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(20),
//                                           topRight: Radius.circular(20),
//                                         ),
//                                         borderSide: BorderSide(
//                                           color: Colors.white,
//                                           width: 2,
//                                         ),
//                                       ),
//                                       fillColor: Colors.grey.shade300,
//                                       filled: true,
//                                       contentPadding: EdgeInsets.all(10),
//                                       hintText: "ادخل الملا��ظات",
//                                       hintStyle: Constants
//                                           .theme.textTheme.bodyMedium
//                                           ?.copyWith(
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                   ).setHorizontalPadding(
//                                       context, enableMediaQuery: false, 20),
//                                   SizedBox(height: 20),
//                                   BorderRoundedButton(
//                                       title: "تعديل",
//                                     onPressed: () {
//                                       // textControllers.forEach((key1, val) {
//                                       //   answers[key1] = val.text;
//                                       // });
//                                       List<dynamic> lastAnswers = [];
//                                       for(int i = 0 ; i<answers.length ; i++) {
//                                         for(int j = 0 ; j<answers[i]["question_options"].length;j++){
//                                           lastAnswers.add({
//                                             // "question_id": key,
//                                             // "question_text": value,
//                                             "question_option_id": answers[i]["question_options"][j]["id"],
//                                             "pationt_answer": answers[i]["question_options"][j]["answer"]
//                                           });
//                                         }
//                                       }
//                                       // answers.forEach((key, value) {
//
//                                       // });
//
//                                       Map<String, dynamic> updateDate = {
//                                         "id": formData["id"],
//                                         "advicor_id":
//                                         CacheHelper.getData(key: 'id'),
//                                         "pationt_id": formData["pationt_id"],
//                                         "need_other_session":
//                                         formData["need_other_session"],
//                                         "consultation_service_id":
//                                         selected_consultation?.id ??
//                                             consultation.id,
//                                         "comments": commentController.text,
//                                         "date": formData["date"],
//                                         "answers": lastAnswers
//                                       };
//                                       setState(() {});
//
//                                       QuestionViewCubit()
//                                           .getUpdateForm(updateDate)
//                                           .then((value) {
//                                         if (value != null) {
//                                           Navigator.pop(context);
//                                           SnackBarService.showSuccessMessage(
//                                               "تم التعديل بنجاح");
//                                         }
//                                       });
//                                     },
//                                       ),
//                                 ],
//                               ).setVerticalPadding(
//                                   context, enableMediaQuery: false, 40);
//                             }
//                           },
//                         ).setHorizontalPadding(
//                             context, enableMediaQuery: false, 20),
//                       ).setHorizontalPadding(
//                           context, enableMediaQuery: false, 20),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         } else {
//           return Center(child: Text('Unexpected state'));
//         }
//       },
//     );
//   }
// }
//
//
//
//
// ////////////////////////////////////////////////////
//
//
// class DropDownButtonConsultaionWidget extends StatefulWidget {
//   ConsultationServices selectedValue;
//   final Function(ConsultationServices value) onChange;
//
//   DropDownButtonConsultaionWidget(
//       {Key? key, required this.selectedValue, required this.onChange})
//       : super(key: key);
//
//   @override
//   _DropDownButtonConsultaionWidgetState createState() =>
//       _DropDownButtonConsultaionWidgetState();
// }
//
// class _DropDownButtonConsultaionWidgetState
//     extends State<DropDownButtonConsultaionWidget> {
//   var allConsultationCubit = AllConsultationCubit();
//
//   @override
//   void initState() {
//     super.initState();
//     allConsultationCubit.getAllConsultations();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AllConsultationCubit, AllConsultationStates>(
//       bloc: allConsultationCubit,
//       builder: (context, state) {
//         if (state is SuccessAllConsultations) {
//           List<ConsultationServices> consultations = state.consultationServices as List<ConsultationServices> ?? [];
//
//           int index = consultations.indexWhere((element) => element.id==widget.selectedValue.id);
//           if (!consultations.contains(widget.selectedValue)&&index!=-1) {
//
//             widget.selectedValue = consultations.first ;
//
//           }
//           else {
//             widget.selectedValue = consultations[index];
//           }
//
//           return DropdownButton<ConsultationServices?>(
//             value: widget.selectedValue,
//             onChanged: (ConsultationServices? newValue) {
//               if (newValue != null) {
//                 setState(() {
//                   widget.selectedValue = newValue;
//                   widget.onChange(newValue);
//                   print("^^^^^^^^^^^>"+widget.selectedValue.id.toString());
//
//                 });
//               }
//             },
//             items: consultations.map<DropdownMenuItem<ConsultationServices?>>(
//                     (ConsultationServices value) {
//                   return DropdownMenuItem<ConsultationServices?>(
//                     value: value,
//                     child: Text(value.name ?? ''),
//                   );
//                 }).toList(),
//           );
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }

import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/config/constants.dart';
import '../../../../../core/widget/Question_text_field.dart';
import '../../../../../domain/entities/ConsultationViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';

import '../../../homeAdmin/Consulting service/All Consultation/manager/cubit.dart';
import '../../../homeAdmin/Consulting service/All Consultation/manager/states.dart';

class UpdateForm extends StatefulWidget {
  final dynamic pationt_data;

  UpdateForm({required this.pationt_data});

  @override
  _UpdateFormState createState() => _UpdateFormState(this.pationt_data);
}

class _UpdateFormState extends State<UpdateForm> {
  final dynamic pationt_data;
  _UpdateFormState(this.pationt_data);

  late AddSessionCubit _patientFormViewCubit;
  Map<dynamic, TextEditingController> textControllers = {};
  Map<dynamic, String> selectedAnswers = {};
  Map<dynamic, bool> checkboxValues = {};
  ConsultationServices? selected_consultation;
  late List<dynamic> answers = [];
  bool isMobile = false;


  @override
  void initState() {
    super.initState();
    _patientFormViewCubit = AddSessionCubit();
    _patientFormViewCubit.getSessionDetails(widget.pationt_data.nationalId);//**getSession
  }

  @override
  void dispose() {
    _patientFormViewCubit.close();
    textControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  void _initializeTextControllers(List<dynamic> answers) {
    for (var answer in answers) {
      for (var option in answer["question_options"]) {
        if (option["type"] == 3 && option["answer"] != null) {
          textControllers[int.parse(option["id"].toString())] =
              TextEditingController(text: option["answer"]);
        }
        if (option["type"] == 1 && option["answer"] == "1") {
          selectedAnswers[int.parse(answer["id"].toString())] =
              option["id"].toString();
        }
        if (option["type"] == 2) {
          checkboxValues[int.parse(option["id"].toString())] =
              option["answer"] == "1";
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddSessionCubit, AddSessionStates>(
      bloc: _patientFormViewCubit,
      builder: (context, state) {
        if (state is LoadingAddSessionState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ErrorAddSessionState) {
          return Center(child: Text(state.errorMessage));
        } else if (state is SuccessAddSessionState) {//**successAddSessionState
          var formData = state.result.data["pationt"]["form"];
          var answers = formData["answers"].toList();
          var consultation = formData["consultationService"];
          ConsultationServices consultations =
          ConsultationServices.fromJson(formData["consultationService"]);
          if (selected_consultation == null) {
            selected_consultation = consultations;
          }
          _initializeTextControllers(answers);
          TextEditingController commentController =
          TextEditingController(text: formData["comments"]);
          return LayoutBuilder(
            builder: (context, constraints) {
              isMobile = constraints.maxWidth < 600;
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  body: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/back.jpg"),
                        fit: BoxFit.cover,
                        opacity: 0.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: Constants.mediaQuery.height * 0.2,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Constants.theme.primaryColor,
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward, color: Colors.white,),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            height: Constants.mediaQuery.height * 0.8,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Constants.theme.primaryColor.withOpacity(
                                  0.6),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)),
                            ),
                            child: ListView.builder(
                              itemCount: answers.length + 1,
                              itemBuilder: (context, index) {
                                if (index < answers.length) {
                                  var answer = answers[index];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Center(
                                        child: Text(
                                          answer["title"],
                                          style: Constants
                                              .theme.textTheme.titleLarge
                                              ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: isMobile
                                            ? answer["question_options"]
                                            .length > 1
                                            ? answer["question_options"]
                                            .length * 70
                                            : 80
                                            : answer["question_options"]
                                            .length > 1
                                            ? answer["question_options"]
                                            .length * 60
                                            : 70,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 20),
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Column(
                                          children: answer["question_options"]
                                              .map<Widget>((option) {
                                            bool isAnswered =
                                                option['answer'] == "1";
                                            if (option["type"] == 3) {
                                              return Expanded(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        option["title"]
                                                            .toString(),
                                                        style: Constants.theme
                                                            .textTheme
                                                            .bodyMedium
                                                            ?.copyWith(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: QuestionTextField(
                                                        hint: "ادخل النص",
                                                        maxLines: 1,
                                                        controller: textControllers[
                                                        int.parse(option["id"]
                                                            .toString())],
                                                        onChanged: (value) {
                                                          // setState(() {
                                                          option["answer"] =
                                                              value;
                                                          // });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ).setVerticalPadding(context,
                                                    enableMediaQuery: false, 2),
                                              );
                                            } else if (option["type"] == 1) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      option["title"]
                                                          .toString(),
                                                      style: Constants.theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Radio<String>(
                                                      value:
                                                      option["id"].toString(),
                                                      groupValue: selectedAnswers[
                                                      int.parse(answer["id"]
                                                          .toString())],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedAnswers[int
                                                              .parse(
                                                              answer["id"]
                                                                  .toString())] =
                                                          value!;
                                                          for (var opt in answer[
                                                          "question_options"]) {
                                                            if (opt["type"] ==
                                                                1) {
                                                              opt["answer"] =
                                                              opt[
                                                              "id"]
                                                                  .toString() ==
                                                                  value
                                                                  ? "1"
                                                                  : "0";
                                                            }
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else if (option["type"] == 2) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      option["title"]
                                                          .toString(),
                                                      style: Constants.theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Checkbox(
                                                      value: checkboxValues[
                                                      int.parse(option["id"]
                                                          .toString())] ??
                                                          false,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          checkboxValues[int
                                                              .parse(
                                                              option["id"]
                                                                  .toString())] =
                                                          value!;
                                                          option["answer"] =
                                                          value ? "1" : "0";
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }
                                            return Container();
                                          }).toList(),
                                        ).setHorizontalPadding(
                                            context, enableMediaQuery: false,
                                            20),
                                      ),
                                      Divider(
                                        thickness: 2,
                                        height: 3,
                                        indent: 20,
                                        endIndent: 20,
                                        color: Colors.black54,
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  );
                                } else {
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .stretch,
                                    children: [
                                      DropDownButtonConsultaionWidget(
                                        onChange: (value) {
                                          setState(() {
                                            selected_consultation = value;
                                            print("=============>" +
                                                selected_consultation!
                                                    .description
                                                    .toString());
                                          });
                                        },
                                        selectedValue:
                                        selected_consultation ?? consultation,
                                      ),
                                      SizedBox(height: 15),
                                      Container(
                                        height: Constants.mediaQuery.height *
                                            0.15,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          selected_consultation?.description ??
                                              '',
                                          style: Constants
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: Colors.black,
                                          ),
                                        ).setHorizontalPadding(
                                            context, enableMediaQuery: false,
                                            20),
                                      ).setHorizontalPadding(
                                          context, enableMediaQuery: false, 20),

                                      SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            "ملاحظات الاستشاري",
                                            style:
                                            Constants.theme.textTheme.bodyLarge,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      SizedBox(
                                        height: Constants.mediaQuery.height *
                                            0.2,
                                        child: TextField(
                                          controller: commentController,
                                          style: Constants
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: Colors.black,
                                          ),
                                          decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                              borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2,
                                              ),
                                            ),
                                            fillColor: Colors.grey.shade300,

                                            filled: true,
                                            contentPadding: EdgeInsets
                                                .symmetric(
                                                vertical: 10, horizontal: 10),
                                            hintText: "ادخل الملاحظات",
                                            hintStyle: Constants
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          maxLines: 5,
                                          minLines: 1,
                                        ).setHorizontalPadding(
                                            context, enableMediaQuery: false,
                                            20),
                                      ),
                                      SizedBox(height: 20),
                                      BorderRoundedButton(
                                        title: "تعديل",
                                        onPressed: () {
                                          // textControllers.forEach((key1, val) {
                                          //   answers[key1] = val.text;
                                          // });
                                          List<dynamic> lastAnswers = [];
                                          for (int i = 0; i <
                                              answers.length; i++) {
                                            for (int j = 0; j <
                                                answers[i]["question_options"]
                                                    .length; j++) {
                                              lastAnswers.add({
                                                // "question_id": key,
                                                // "question_text": value,
                                                "question_option_id": answers[i]["question_options"][j]["id"],
                                                "pationt_answer": answers[i]["question_options"][j]["answer"]
                                              });
                                            }
                                          }
                                          // answers.forEach((key, value) {

                                          // });

                                          Map<String, dynamic> updateDate = {
                                            "id": formData["id"],
                                            "advicor_id":
                                            CacheHelper.getData(key: 'id'),
                                            "pationt_id": formData["pationt_id"],
                                            "need_other_session":
                                            formData["need_other_session"],
                                            "consultation_service_id":
                                            selected_consultation?.id ??
                                                consultation.id,
                                            "comments": commentController.text,
                                            "date": formData["date"],
                                            "answers": lastAnswers
                                          };
                                          setState(() {});

                                          QuestionViewCubit().getUpdateForm(
                                              updateDate).then((value) {
                                            if (value != null) {
                                              Navigator.pop(context);
                                              SnackBarService
                                                  .showSuccessMessage(
                                                  "تم التعديل بنجاح");
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ).setVerticalPadding(
                                      context, enableMediaQuery: false, 20);
                                }
                              },
                            ).setHorizontalPadding(
                                context, enableMediaQuery: false, 20),
                          ).setHorizontalPadding(
                              context, enableMediaQuery: false, 20),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
        } else {
          return Center(child: Text('Unexpected state'));
        }
      },
    );
  }
}

class DropDownButtonConsultaionWidget extends StatefulWidget {
  ConsultationServices selectedValue;
  final Function(ConsultationServices value) onChange;

  DropDownButtonConsultaionWidget(
      {Key? key, required this.selectedValue, required this.onChange})
      : super(key: key);

  @override
  _DropDownButtonConsultaionWidgetState createState() =>
      _DropDownButtonConsultaionWidgetState();
}

class _DropDownButtonConsultaionWidgetState
    extends State<DropDownButtonConsultaionWidget> {
  var allConsultationCubit = AllConsultationCubit();

  @override
  void initState() {
    super.initState();
    allConsultationCubit.getAllConsultations();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllConsultationCubit, AllConsultationStates>(
      bloc: allConsultationCubit,
      builder: (context, state) {
        if (state is SuccessAllConsultations) {
          List<ConsultationServices> consultations = state.consultationServices as List<ConsultationServices> ?? [];

          int index = consultations.indexWhere((element) => element.id == widget.selectedValue.id);
          if (!consultations.contains(widget.selectedValue) && index != -1) {
            widget.selectedValue = consultations.first;
          } else {
            widget.selectedValue = consultations[index];
          }

          return DropdownButton<ConsultationServices?>(
            value: widget.selectedValue,
            onChanged: (ConsultationServices? newValue) {
              if (newValue != null) {
                setState(() {
                  widget.selectedValue = newValue;
                  widget.onChange(newValue);
                  print("^^^^^^^^^^^>" + widget.selectedValue.id.toString());
                });
              }
            },
            items: consultations.map<DropdownMenuItem<ConsultationServices?>>(
                    (ConsultationServices value) {
                  return DropdownMenuItem<ConsultationServices?>(
                    value: value,
                    child: Text(value.name ?? ''),
                  );
                }).toList(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}