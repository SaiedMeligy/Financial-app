import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import '../../../../core/widget/Question_text_field.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/widget/drop_down.dart';

import '../../allPatients/widget/manager/cubit.dart';
import '../../allPatients/widget/manager/states.dart';
import '../widget/date_time.dart';

class UpdateForm extends StatefulWidget {
  final dynamic pationt_data;

  UpdateForm({required this.pationt_data});

  @override
  _UpdateFormState createState() => _UpdateFormState();
}
// class _UpdateFormState extends State<UpdateForm> {
//   late PatientFormViewCubit _patientFormViewCubit;
//   Map<int, TextEditingController> textControllers = {};
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
//           textControllers[option["id"]] = TextEditingController(text: option["answer"]);
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
//
//           // Initialize text controllers with the current answers
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
//                             right: 0,
//                             child: IconButton(
//                               icon: Icon(Icons.edit, color: Colors.white),
//                               onPressed: () {
//                                 // Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                 //   return UpdateForm(pationt_data: widget.pationt_data);
//                                 // }));
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
//                         decoration: const BoxDecoration(
//                           color: Colors.black87,
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: ListView.builder(
//                           itemCount: answers.length,
//                           itemBuilder: (context, index) {
//                             var answer = answers[index];
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Center(
//                                   child: Text(
//                                     answer["title"],
//                                     style: Constants.theme.textTheme.titleLarge?.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   width: double.infinity,
//                                   height: answers[index]["question_options"].length > 1
//                                       ? answers[index]["question_options"].length * 50
//                                       : 70,
//                                   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                                   decoration: const BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       topRight: Radius.circular(20),
//                                     ),
//                                   ),
//                                   child: Column(
//                                     children: answer["question_options"].map<Widget>((option) {
//                                       bool isAnswered = option['answer'] == "1";
//                                       if (option["type"] == 3) {
//                                         return Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 option["title"].toString(),
//                                                 style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                             Expanded(
//                                               child: QuestionTextField(
//                                                 hint: "ادخل النص",
//                                                 maxLines: 1,
//
//                                                 controller: textControllers[option["id"]],
//                                                 onChanged: (value) {
//                                                   setState(() {
//                                                     option["answer"] = value;
//                                                   });
//                                                 },
//                                               ),
//                                             ),
//                                           ],
//                                         );
//                                       } else {
//                                         return Row(
//                                           children: [
//                                             Expanded(
//                                               child: Text(
//                                                 option["title"].toString(),
//                                                 style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                   color: Colors.black,
//                                                 ),
//                                               ),
//                                             ),
//                                             if (option["type"] == 1)
//                                               Expanded(
//                                                 child: Radio<bool>(
//                                                   value: isAnswered,
//                                                   groupValue: isAnswered,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       option["answer"] = value! ? "1" : "0";
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                             if (option["type"] == 2)
//                                               Expanded(
//                                                 child: Checkbox(
//                                                   value: isAnswered,
//                                                   onChanged: (value) {
//                                                     setState(() {
//                                                       option["answer"] = value! ? "1" : "0";
//                                                     });
//                                                   },
//                                                 ),
//                                               ),
//                                           ],
//                                         );
//                                       }
//                                     }).toList(),
//                                   ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                                 ),
//                                 Divider(
//                                   thickness: 2,
//                                   height: 3,
//                                   indent: 20,
//                                   endIndent: 20,
//                                   color: Colors.grey.shade600,
//                                 ),
//                                 SizedBox(height: 10),
//                                 Column(
//                                   children: [
//                                     Text(consultation["name"]),
//                                     SizedBox(height: 10),
//                                     Container(
//                                       height: Constants.mediaQuery.height * 0.15,
//                                       width: double.infinity,
//                                       decoration: const BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.only(
//                                           topLeft: Radius.circular(20),
//                                           topRight: Radius.circular(20),
//                                         ),
//                                       ),
//                                       child: Text(
//                                         consultation["description"],
//                                         style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                           color: Colors.black,
//                                         ),
//                                       ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                                     ),
//                                   ],
//                                 ).setVerticalPadding(context, enableMediaQuery: false, 20),
//                               ],
//                             );
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
class _UpdateFormState extends State<UpdateForm> {
  late PatientFormViewCubit _patientFormViewCubit;
  Map<int, TextEditingController> textControllers = {};
  Map<int, String?> selectedAnswers = {}; // To store the selected answers for radio buttons

  @override
  void initState() {
    super.initState();
    _patientFormViewCubit = PatientFormViewCubit();
    _patientFormViewCubit.getPatientFormView(widget.pationt_data.id);
  }

  @override
  void dispose() {
    _patientFormViewCubit.close();
    textControllers.forEach((key, controller) {
      controller.dispose();
    });
    super.dispose();
  }

  // void _initializeTextControllers(List<dynamic> answers) {
  //   for (var answer in answers) {
  //     for (var option in answer["question_options"]) {
  //       if (option["type"] == 3 && option["answer"] != null) {
  //         textControllers[option["id"]] = TextEditingController(text: option["answer"]);
  //       }
  //       if (option["type"] == 1) {
  //         selectedAnswers[answer["id"]] = option["answer"]; // Initialize selected answers for radio buttons
  //       }
  //     }
  //   }
  // }
  void _initializeTextControllers(List<dynamic> answers) {
    for (var answer in answers) {
      for (var option in answer["question_options"]) {
        if (option["type"] == 3 && option["answer"] != null) {
          textControllers[option["id"]] = TextEditingController(text: option["answer"]);
        }
        if (option["type"] == 1 && option["answer"] == "1") {
          selectedAnswers[answer["id"]] = option["id"].toString(); // Initialize selected answers for radio buttons
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
          var patient = state.response.data["form"]["pationt"];
          var advicor = state.response.data["form"]["advicor"];
          var answers = state.response.data["form"]["answers"];
          var consultation = formData["consultationService"];

          // Initialize text controllers with the current answers
          _initializeTextControllers(answers);

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.9,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: Constants.mediaQuery.height * 0.2,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.black87,
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
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child:
                        ListView.builder(
                          itemCount: answers.length,
                          itemBuilder: (context, index) {
                            var answer = answers[index];
                            return Column(

                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            if (answers.length != index + 1) ...[
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
                                      ? answer["question_options"].length * 50
                                      : 70,
                                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
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
                                                controller: textControllers[option["id"]],
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
                                                groupValue: selectedAnswers[answer["id"]],
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedAnswers[answer["id"]] = value;
                                                    for (var opt in answer["question_options"]) {
                                                      if (opt["id"].toString() == value) {
                                                        opt["answer"] = "1";
                                                      } else {
                                                        opt["answer"] = "0";
                                                      }
                                                    }
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      } else {
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
                                                value: isAnswered,
                                                onChanged: (value) {
                                                  setState(() {
                                                    option["answer"] = value! ? "1" : "0";
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    }).toList(),
                                  ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                ),
                                Divider(
                                  thickness: 2,
                                  height: 3,
                                  indent: 20,
                                  endIndent: 20,
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(height: 10),
                            ] else ...[
                                Column(
                                  children: [

                                    Text(consultation["name"]),
                                    SizedBox(height: 10),

                                    Container(
                                      height: Constants.mediaQuery.height * 0.15,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
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
                                    ),
                                    BorderRoundedButton(
                                      title: "تعديل",
                                      onPressed: () {

                                        // _patientFormViewCubit.getUpdateForm(updateData);


                                      },
                                    )
                                  ],
                                ).setVerticalPadding(context, enableMediaQuery: false, 20),
                              ],
                            ]
                            );

                          },
                        ).setHorizontalPadding(context, enableMediaQuery: false, 20)
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

