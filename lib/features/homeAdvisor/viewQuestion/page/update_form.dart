// import 'package:experts_app/features/homeAdvisor/viewQuestion/widget/drop_down.dart';
//
// import '../widget/date_time.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../core/config/constants.dart';
// import '../../allPatients/widget/manager/cubit.dart';
// import '../../allPatients/widget/manager/states.dart';
// import '../../../../core/widget/Question_text_field.dart';
// import 'package:experts_app/core/extensions/padding_ext.dart';
// import 'package:experts_app/core/widget/border_rounded_button.dart';
//
// class UpdateForm extends StatefulWidget {
//   final dynamic pationt_data;
//
//   UpdateForm({required this.pationt_data});
//
//   @override
//   _UpdateFormState createState() => _UpdateFormState();
// }
//
// class _UpdateFormState extends State<UpdateForm> {
//   late PatientFormViewCubit _patientFormViewCubit;
//   Map<int, TextEditingController> textControllers = {};
//   late Map<dynamic, dynamic> selectedAnswers = {}; // To store the selected answers for radio buttons
//   Map<int, String?> answers = {}; // To store the selected answers for radio buttons
//   Map<int, bool> checkboxValues = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _patientFormViewCubit = PatientFormViewCubit();
//     _patientFormViewCubit.getPatientFormView(widget.pationt_data.id);
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
//           textControllers[int.parse(option["id"].toString())] = TextEditingController(text: option["answer"]);
//         }
//         if (option["type"] == 1) {
//           selectedAnswers[int.parse(option["id"].toString())] = option["answer"];
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PatientFormViewCubit, PatientFormViewStates>(
//       bloc: _patientFormViewCubit,
//       builder: (context, state) {
//         if (state is LoadingPatientFormViewState) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is ErrorPatientFormViewState) {
//           return Center(child: Text(state.errorMessage));
//         } else if (state is SuccessPatientFormViewState) {
//           var formData = state.response.data["form"];
//           var patient = state.response.data["form"]["pationt"];
//           var advicor = state.response.data["form"]["advicor"];
//           var answers = state.response.data["form"]["answers"];
//           var consultation = formData["consultationService"];
//           int selected_consultation_service = consultation["id"];
//           _initializeTextControllers(answers);
//
//           return Directionality(
//             textDirection: TextDirection.rtl,
//             child: Scaffold(
//               body: Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage("assets/images/background.jpg"),
//                     fit: BoxFit.cover,
//                     opacity: 0.9,
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: Constants.mediaQuery.height * 0.2,
//                       width: double.infinity,
//                       decoration: const BoxDecoration(
//                         color: Colors.black87,
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
//                     // Expanded(
//                     //   child: Container(
//                     //     height: Constants.mediaQuery.height * 0.8,
//                     //     width: double.infinity,
//                     //     decoration: const BoxDecoration(
//                     //       color: Colors.black87,
//                     //       borderRadius: BorderRadius.all(Radius.circular(10)),
//                     //     ),
//                     //     child: ListView.builder(
//                     //       itemCount: answers.length,
//                     //       itemBuilder: (context, index) {
//                     //         var answer = answers[index];
//                     //         return Column(
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           children: [
//                     //             if (answers.length != index + 1) ...[
//                     //               Center(
//                     //                 child: Text(
//                     //                   answer["title"],
//                     //                   style: Constants.theme.textTheme.titleLarge?.copyWith(
//                     //                     fontWeight: FontWeight.bold,
//                     //                   ),
//                     //                 ),
//                     //               ),
//                     //               Container(
//                     //                 width: double.infinity,
//                     //                 height: answer["question_options"].length > 1
//                     //                     ? answer["question_options"].length * 50
//                     //                     : 70,
//                     //                 margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                     //                 decoration: const BoxDecoration(
//                     //                   color: Colors.white,
//                     //                   borderRadius: BorderRadius.only(
//                     //                     topLeft: Radius.circular(20),
//                     //                     topRight: Radius.circular(20),
//                     //                   ),
//                     //                 ),
//                     //                 child: Column(
//                     //                   children: answer["question_options"].map<Widget>((option) {
//                     //                     bool isAnswered = option['answer'] == "1";
//                     //                     if (option["type"] == 3) {
//                     //                       return Row(
//                     //                         children: [
//                     //                           Expanded(
//                     //                             child: Text(
//                     //                               option["title"].toString(),
//                     //                               style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                     //                                 color: Colors.black,
//                     //                               ),
//                     //                             ),
//                     //                           ),
//                     //                           Expanded(
//                     //                             child: QuestionTextField(
//                     //                               hint: "ادخل النص",
//                     //                               maxLines: 1,
//                     //                               controller: textControllers[int.parse(option["id"].toString())],
//                     //                               onChanged: (value) {
//                     //                                 setState(() {
//                     //                                   option["answer"] = value;
//                     //                                 });
//                     //                               },
//                     //                             ),
//                     //                           ),
//                     //                         ],
//                     //                       );
//                     //                     } else if (option["type"] == 1) {
//                     //                       return Row(
//                     //                         children: [
//                     //                           Expanded(
//                     //                             child: Text(
//                     //                               option["title"].toString(),
//                     //                               style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                     //                                 color: Colors.black,
//                     //                               ),
//                     //                             ),
//                     //                           ),
//                     //                           // Expanded(
//                     //                           //   child: Radio<String>(
//                     //                           //     value: selectedAnswers[int.parse(option["id"].toString())],
//                     //                           //     groupValue: answers["id"].toString(),
//                     //                           //     onChanged: (value) {
//                     //                           //       setState(() {
//                     //                           //         selectedAnswers[int.parse(answer["id"].toString())] = value;
//                     //                           //         for (var opt in answer["question_options"]) {
//                     //                           //           if (opt["id"].toString() == value) {
//                     //                           //             opt["answer"] = "1";
//                     //                           //           } else {
//                     //                           //             opt["answer"] = "0";
//                     //                           //           }
//                     //                           //         }
//                     //                           //       });
//                     //                           //     },
//                     //                           //   ),
//                     //                           // ),
//                     //                           Expanded(
//                     //                             child: Radio<String>(
//                     //                               value: option["id"].toString(),
//                     //                               groupValue: selectedAnswers[int.parse(answer["id"].toString())],
//                     //                               onChanged: (value) {
//                     //                                 setState(() {
//                     //                                   selectedAnswers[int.parse(answer["id"].toString())] = value!;
//                     //                                   for (var opt in answer["question_options"]) {
//                     //                                     if (opt["id"].toString() == value) {
//                     //                                       opt["answer"] = "1";
//                     //                                     } else {
//                     //                                       opt["answer"] = "0";
//                     //                                     }
//                     //                                   }
//                     //                                 });
//                     //                               },
//                     //                             ),
//                     //                           ),
//                     //                         ],
//                     //                       );
//                     //                     } else {
//                     //                       return Row(
//                     //                         children: [
//                     //                           Expanded(
//                     //                             child: Text(
//                     //                               option["title"].toString(),
//                     //                               style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                     //                                 color: Colors.black,
//                     //                               ),
//                     //                             ),
//                     //                           ),
//                     //                           Expanded(
//                     //                             child: Checkbox(
//                     //                               value: isAnswered,
//                     //                               onChanged: (value) {
//                     //                                 setState(() {
//                     //                                   option["answer"] = value! ? "1" : "0";
//                     //                                 });
//                     //                               },
//                     //                             ),
//                     //                           ),
//                     //                         ],
//                     //                       );
//                     //                     }
//                     //                   }).toList(),
//                     //                 ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                     //               ),
//                     //               Divider(
//                     //                 thickness: 2,
//                     //                 height: 3,
//                     //                 indent: 20,
//                     //                 endIndent: 20,
//                     //                 color: Colors.grey.shade600,
//                     //               ),
//                     //               SizedBox(height: 10),
//                     //             ] else ...[
//                     //               Column(
//                     //                 children: [
//                     //                   // DropDown(
//                     //                   //   onChange: (value) {
//                     //                   //     setState(() {
//                     //                   //       selected_consultation_service = value;
//                     //                   //     });
//                     //                   //   },
//                     //                   // ),
//                     //                    Text(consultation["name"]),
//                     //                   SizedBox(height: 10),
//                     //                   Container(
//                     //                     height: Constants.mediaQuery.height * 0.15,
//                     //                     width: double.infinity,
//                     //                     decoration: const BoxDecoration(
//                     //                       color: Colors.white,
//                     //                       borderRadius: BorderRadius.only(
//                     //                         topLeft: Radius.circular(20),
//                     //                         topRight: Radius.circular(20),
//                     //                       ),
//                     //                     ),
//                     //                     child: Text(
//                     //                       consultation["description"],
//                     //                       style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                     //                         color: Colors.black,
//                     //                       ),
//                     //                     ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                     //                   ),
//                     //                   BorderRoundedButton(
//                     //                     title: "تعديل",
//                     //                     onPressed: () {
//                     //                       textControllers.forEach((key, value) {
//                     //                         // handle text controllers
//                     //                       });
//                     //                       print(answers);
//                     //                       print(selectedAnswers);
//                     //                     },
//                     //                   )
//                     //                 ],
//                     //               ).setVerticalPadding(context, enableMediaQuery: false, 20),
//                     //             ],
//                     //           ],
//                     //         );
//                     //       },
//                     //     ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                     //   ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                     // ),
//                     Expanded(
//                       child: Container(
//                         height: Constants.mediaQuery.height * 0.8,
//                         width: double.infinity,
//                         decoration: BoxDecoration(
//                           color: Constants.theme.primaryColor.withOpacity(0.3),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: ListView.builder(
//                           itemCount: answers.length + 1,
//                           itemBuilder: (context, index) {
//                             if (index < answers.length) {
//                               var answer = answers[index];
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Center(
//                                     child: Text(
//                                       answer["title"],
//                                       style: Constants.theme.textTheme.titleLarge?.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     width: double.infinity,
//                                     height: answer["question_options"].length > 1
//                                         ? answer["question_options"].length * 50
//                                         : 70,
//                                     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                                     decoration: BoxDecoration(
//                                       color: Colors.grey.shade300,
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(20),
//                                         topRight: Radius.circular(20),
//                                       ),
//                                     ),
//                                     child: Column(
//                                       children: answer["question_options"].map<Widget>((option) {
//                                         bool isAnswered = option['answer'] == "1";
//                                         if (option["type"] == 3) {
//                                           return Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   option["title"].toString(),
//                                                   style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: QuestionTextField(
//                                                   hint: "ادخل النص",
//                                                   maxLines: 1,
//                                                   controller: textControllers[int.parse(option["id"].toString())],
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       option["answer"] = value;
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         } else if (option["type"] == 1) {
//                                           return Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   option["title"].toString(),
//                                                   style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Radio<String>(
//                                                   value: option["id"].toString(),
//                                                   groupValue: selectedAnswers[int.parse(answer["id"].toString())],
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       selectedAnswers[int.parse(answer["id"].toString())] = value!;
//                                                       for (var opt in answer["question_options"]) {
//                                                         if (opt["type"] == 1) {
//                                                           opt["answer"] = opt["id"].toString() == value ? "1" : "0";
//                                                         }
//                                                       }
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         } else if (option["type"] == 2) {
//                                           return Row(
//                                             children: [
//                                               Expanded(
//                                                 child: Text(
//                                                   option["title"].toString(),
//                                                   style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Expanded(
//                                                 child: Checkbox(
//                                                   value: checkboxValues[int.parse(option["id"].toString())] ?? false,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       checkboxValues[int.parse(option["id"].toString())] = value!;
//                                                       option["answer"] = value ? "1" : "0";
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                             ],
//                                           );
//                                         }
//                                         return Container();
//                                       }).toList(),
//                                     ).setHorizontalPadding(context, enableMediaQuery: false, 20),
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
//                                 children: [
//                                   Text(consultation["name"]),
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
//                                       consultation["description"],
//                                       style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                         color: Colors.black,
//                                       ),
//                                     ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                                   ),
//                                   SizedBox(height: 15),
//                                   BorderRoundedButton(
//                                     title: "تعديل",
//                                     onPressed: () {
//                                       textControllers.forEach((key, value) {
//                                         // handle text controllers
//                                       });
//                                       print(answers);
//                                       print(selectedAnswers);
//                                     },
//                                   ),
//                                 ],
//                               ).setVerticalPadding(context, enableMediaQuery: false, 20);
//                             }
//                           },
//                         ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                       ).setHorizontalPadding(context, enableMediaQuery: false, 20),
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
import 'package:experts_app/core/widget/drop_down_button.dart';
import 'package:experts_app/core/widget/second_text_field.dart';
import 'package:experts_app/features/homeAdmin/Consulting%20service/All%20Consultation/manager/states.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/widget/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/widget/manager/states.dart';
import '../../../../../core/config/constants.dart';
import '../../../../../core/widget/Question_text_field.dart';
import '../../../../core/Services/snack_bar_service.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../homeAdmin/Consulting service/All Consultation/manager/cubit.dart';
import '../../allPatients/widget/manager/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';

import '../manager/cubit.dart';

class UpdateForm extends StatefulWidget {
  final dynamic pationt_data;

  UpdateForm({required this.pationt_data});

  @override
  _UpdateFormState createState() => _UpdateFormState(this.pationt_data);
}

class _UpdateFormState extends State<UpdateForm> {
  final dynamic pationt_data;
  _UpdateFormState(this.pationt_data);

  late PatientFormViewCubit _patientFormViewCubit;
  Map<int, TextEditingController> textControllers = {};
  Map<int, String> selectedAnswers = {};
  Map<int, bool> checkboxValues = {};
  late Map<dynamic, dynamic> answers = {};
  late Map<dynamic, dynamic> radiosBtn = {};

  int needOtherSession = 0;
  int selected_consultation_service=0;
  @override
  void initState() {
    super.initState();
    _patientFormViewCubit = PatientFormViewCubit();
    _patientFormViewCubit.getPatientFormView(widget.pationt_data.id);
    // selected_consultation_service = consultation["id"];
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
          textControllers[int.parse(option["id"].toString())] = TextEditingController(text: option["answer"]);
        }
        if (option["type"] == 1 && option["answer"] == "1") {
          selectedAnswers[int.parse(answer["id"].toString())] = option["id"].toString();
        }
        if (option["type"] == 2) {
          checkboxValues[int.parse(option["id"].toString())] = option["answer"] == "1";
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientFormViewCubit, PatientFormViewStates>(
      bloc: _patientFormViewCubit,
      builder: (context, state) {
        if (state is LoadingPatientFormViewState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ErrorPatientFormViewState) {
          return Center(child: Text(state.errorMessage));
        } else if (state is SuccessPatientFormViewState) {
          var formData = state.response.data["form"];
          var patient = formData["pationt"];
          var advisor = formData["advicor"];
          var questionAnswer = state.response.data["form"]["answers"];
          var consultation = formData["consultationService"];

          print("*******************>"+(consultation["name"]));
          print("*******************>"+(consultation["description"]));
           print("*******************>"+advisor.toString());
          // int selectedConsultationService = consultation["id"];
          _initializeTextControllers(questionAnswer);
          TextEditingController commentController = TextEditingController(text: formData["comments"]);
          if (answers.isEmpty) {
            for (int index = 0; index < questionAnswer.length; index++) {
              radiosBtn[questionAnswer[index]["id"]] = -1;
              for (int i = 0; i < questionAnswer[index]["question_options"].length; i++) {
                answers[questionAnswer[index]["question_options"][i]["id"]] = 0;
                radiosBtn.addAll({questionAnswer[index]["id"]: -1,
                });
                answers.addAll({
                  questionAnswer[index]["question_options"][i]["id"]: 0,
                });
                if (questionAnswer[index]["question_options"][i]["type"] == 3) {
                  textControllers.addAll({
                    questionAnswer[index]["question_options"][i]["id"]:
                    TextEditingController(text: ""),
                  });
                }
              }
            }
          }
          return Directionality(
            textDirection: TextDirection.rtl,
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
                              icon: Icon(Icons.arrow_back),
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
                          color: Constants.theme.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ListView.builder(
                          itemCount: questionAnswer.length + 1,
                          itemBuilder: (context, index) {
                            if (index < questionAnswer.length) {
                              var answer = questionAnswer[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      answer["title"],
                                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: answer["question_options"].length > 1
                                        ? answer["question_options"].length * 65
                                        : 70,
                                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      children: answer["question_options"].map<Widget>((option) {
                                        bool isAnswered = option['answer'] == "1";
                                        if (option["type"] == 3) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  option["title"].toString(),
                                                  style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: QuestionTextField(
                                                  hint: "ادخل النص",
                                                  maxLines: 1,
                                                  controller: textControllers[int.parse(option["id"].toString())],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      option["answer"] = value;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        } else if (option["type"] == 1) {
                                          return Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  option["title"].toString(),
                                                  style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Radio<String>(
                                                  value: option["id"].toString(),
                                                  groupValue: selectedAnswers[int.parse(answer["id"].toString())],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      selectedAnswers[int.parse(answer["id"].toString())] = value!;
                                                      for (var opt in answer["question_options"]) {
                                                        if (opt["type"] == 1) {
                                                          opt["answer"] = opt["id"].toString() == value ? "1" : "0";
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
                                                  option["title"].toString(),
                                                  style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Checkbox(
                                                  value: checkboxValues[int.parse(option["id"].toString())] ?? false,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      checkboxValues[int.parse(option["id"].toString())] = value!;
                                                      option["answer"] = value ? "1" : "0";
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        }
                                        return Container();
                                      }).toList(),
                                    ).setHorizontalPadding(context, enableMediaQuery: false, 40),
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 3,
                                    indent: 20,
                                    endIndent: 20,
                                    color: Colors.grey.shade600,
                                  ),
                                  SizedBox(height: 10),
                                ],
                              );
                            } else {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,

                                children: [
                                  // DropDown(
                                  //   onChange: (value) {
                                  //     setState(() {
                                  //       selected_consultation_service = value;
                                  //       // consultation["description"] = value;
                                  //     });
                                  //   },
                                  // ),
                                  DropDownButtonWidget(
                                    onChange: (value){
                                      print("vvvvvvvvvvvvv>>"+value);
                                    },
                                  selectedValue: consultation["name"],),
                                  SizedBox(height: 10),
                                  Container(
                                    height: Constants.mediaQuery.height * 0.15,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Text(
                                      consultation["description"],
                                      style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.black,
                                      ),
                                    ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                  ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("ملاحظات الاستشاري",style: Constants.theme.textTheme.bodyLarge,),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  TextField(
                                    controller: commentController,
                                    style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.black, // Change to your desired text color
                                    ),
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
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
                                      contentPadding: EdgeInsets.all(10),
                                      hintText: "ادخل الملا��ظات",
                                      hintStyle: Constants.theme.textTheme.bodyMedium?.copyWith(
                                        color: Colors.black,

                                      ),


                                  ),
                                  ).setHorizontalPadding(context,enableMediaQuery: false,20),
                                  SizedBox(height: 20),
                                  BorderRoundedButton(
                                    title: "تعديل",
                                      onPressed: () {
                                        setState(() {
                                          textControllers.forEach((key1, val) {
                                            answers[key1] = val.text;
                                          });
                                        });

                                        List<dynamic> lastAnswers = [];

                                        answers.forEach((key, value) {
                                          lastAnswers.add({
                                            // "question_id": key,
                                            // "question_text": value,
                                            "question_option_id": key,
                                            "pationt_answer": value
                                          });
                                        });

                                        Map<String, dynamic> updateDate = {
                                          "id":formData["id"],
                                          "advicor_id": CacheHelper.getData(key: 'id'),
                                          "pationt_id": patient["id"],
                                          "need_other_session": needOtherSession,
                                          "consultation_service_id": consultation["name"],
                                          "comments": commentController.text,
                                          "date":formData["date"],
                                          "answers": lastAnswers
                                        };

                                        print("Data to be sent: $updateDate"); // Log the data before sending

                                        QuestionViewCubit().getUpdateForm(updateDate).then((value) {
                                          if(value!=null) {
                                            Navigator.pop(context);
                                            SnackBarService.showSuccessMessage("تم التعديل بنجاح");
                                          }
                                        });
                                      }
                                  ),
                                ],
                              ).setVerticalPadding(context, enableMediaQuery: false, 40);
                            }
                          },
                        ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                      ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                    ),

                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: Text('Unexpected state'));
        }
      },
    );
  }

}



////////////////////////////////////////////////////




class DropDownButtonWidget extends StatefulWidget {
  String selectedValue;
  final Function(dynamic value) onChange;

  DropDownButtonWidget({Key? key, required this.selectedValue, required this.onChange}) : super(key: key);

  @override
  _DropDownButtonWidgetState createState() => _DropDownButtonWidgetState();
}

class _DropDownButtonWidgetState extends State<DropDownButtonWidget> {
  List<String> dropList = [];
  List<String> descriptionList = [];
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
          dropList.clear();
          descriptionList.clear();
          state.consultationServices.forEach((element) {
            dropList.add(element.name.toString());
            descriptionList.add(element.description.toString());
          });

          if (!dropList.contains(widget.selectedValue)) {
            widget.selectedValue = dropList.isNotEmpty ? dropList.first : '';
          }

          return DropdownButton<String>(
            value: widget.selectedValue.isNotEmpty ? widget.selectedValue : null,
            onChanged: (String? newValue) {
              setState(() {
                widget.selectedValue = newValue!;
              });
              int index = dropList.indexOf(newValue!);
              widget.onChange(descriptionList[index]);
            },
            items: dropList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
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







//
// class DropDownButtonWidget extends StatefulWidget {
//   String selectedValue ='';
//   Function(dynamic Value) onChange ;
//
//   DropDownButtonWidget({Key? key,  required this.selectedValue,required this.onChange}) : super(key: key);
//   @override
//   _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState(selectedValue:  this.selectedValue,onChange: this.onChange);
// }
//
// class _DropdownButtonWidgetState extends State<DropDownButtonWidget> {
//   List<String> dropList = [];
//   List<String> descriptionList = [];
//   String selectedValue ='';
//   Function(dynamic Value) onChange ;
//   var allConsultationCubit = AllConsultationCubit();
//
//   _DropdownButtonWidgetState({Key? key, required this.selectedValue,required this.onChange});
//
//   @override
//   void initState() {
//     super.initState();
//     allConsultationCubit.getAllConsultations();
//   }
//   Widget build(BuildContext context) {
//     return BlocBuilder<AllConsultationCubit,AllConsultationStates>(
//       bloc: allConsultationCubit,
//       builder: (context, state) {
//         if(state is SuccessAllConsultations)
//           {
//             var consultation = state.consultationServices.forEach((element) {
//               dropList.add(element.name.toString());
//               descriptionList.add(element.description.toString());
//             });
//
//       return DropdownButton<String>(
//         value: selectedValue,
//         onChanged: (String? newValue) {
//           setState(() {
//             selectedValue = newValue.toString();
//             print("sssssssss"+selectedValue);
//           });
//           int index = dropList.indexOf(newValue!);
//           onChange(descriptionList[index]);
//
//         },
//         items: dropList.map<DropdownMenuItem<String>>((String value) {
//           return DropdownMenuItem<String>(
//             value: value,
//             child: Text(value),
//           );
//         }).toList(),
//       );}
//     else{
//       return Center(child: Text('Unexpected state'));
//         }
//     }
//     );
//   }
// }