// import 'package:experts_app/features/homeAdmin/allPatientsAdmin/widget/manager/states.dart';
//
// import '../../../../../core/config/constants.dart';
// import '../../../../../core/widget/Question_text_field.dart';
// import '../../widget/manager/cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:experts_app/core/extensions/padding_ext.dart';
// import 'package:experts_app/core/widget/border_rounded_button.dart';
//
// class UpdateFormAdminView extends StatefulWidget {
//   final dynamic pationt_data;
//
//   UpdateFormAdminView({required this.pationt_data});
//
//   @override
//   _UpdateFormAdminViewState createState() => _UpdateFormAdminViewState(this.pationt_data);
// }
// //
// class _UpdateFormAdminViewState extends State<UpdateFormAdminView> {
//   final dynamic pationt_data;
//   _UpdateFormAdminViewState(this.pationt_data);
//
//   late PatientFormViewWithAdminCubit _patientFormViewCubit;
//   Map<int, TextEditingController> textControllers = {};
//   Map<int, String> selectedAnswers = {};
//   Map<int, bool> checkboxValues = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _patientFormViewCubit = PatientFormViewWithAdminCubit();
//     _patientFormViewCubit.getPatientFormViewWithAdmin(widget.pationt_data.id);
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
//         if (option["type"] == 1 && option["answer"] == "1") {
//           selectedAnswers[int.parse(answer["id"].toString())] = option["id"].toString();
//         }
//         if (option["type"] == 2) {
//           checkboxValues[int.parse(option["id"].toString())] = option["answer"] == "1";
//         }
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PatientFormViewWithAdminCubit, PatientFormViewWithAdminStates>(
//       bloc: _patientFormViewCubit,
//       builder: (context, state) {
//         if (state is LoadingPatientFormViewWithAdminState) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is ErrorPatientFormViewWithAdminState) {
//           return Center(child: Text(state.errorMessage));
//         } else if (state is SuccessPatientFormViewWithAdminState) {
//           var formData = state.response.data["form"];
//           var answers = state.response.data["form"]["answers"];
//           var consultation = formData["consultationService"];
//           // Initialize text controllers with the current answers
//           _initializeTextControllers(answers);
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
//                       decoration:  BoxDecoration(
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
//                         decoration:  BoxDecoration(
//                            color: Constants.theme.primaryColor.withOpacity(0.3),
//                           borderRadius: BorderRadius.all(Radius.circular(10)),
//                         ),
//                         child: ListView.builder(
//                           itemCount: answers.length,
//                           itemBuilder: (context, index) {
//                             var answer = answers[index];
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 if (answers.length != index + 1) ...[
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
//                                     decoration:  BoxDecoration(
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
//                                 ] else ...[
//                                   Column(
//                                     children: [
//                                       Text(consultation["name"]),
//                                       SizedBox(height: 10),
//                                       Container(
//                                         height: Constants.mediaQuery.height * 0.15,
//                                         width: double.infinity,
//                                         decoration:  BoxDecoration(
//                                           color:Colors.grey.shade300,
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(20),
//                                             topRight: Radius.circular(20),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           consultation["description"],
//                                           style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                             color: Colors.black,
//                                           ),
//                                         ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                                       ),
//                                       SizedBox(height: 15,),
//                                       BorderRoundedButton(
//                                         title: "تعديل",
//                                         onPressed: () {
//                                           textControllers.forEach((key, value) {
//                                             // handle text controllers
//                                           });
//                                           print(answers);
//                                           print(selectedAnswers);
//                                         },
//                                       )
//                                     ],
//                                   ).setVerticalPadding(context, enableMediaQuery: false, 20),
//                                 ],
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

import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/widget/manager/states.dart';
import '../../../../../core/config/constants.dart';
import '../../../../../core/widget/Question_text_field.dart';
import '../../../../../domain/entities/ConsultationViewModel.dart';
import '../../../Consulting service/All Consultation/manager/cubit.dart';
import '../../../Consulting service/All Consultation/manager/states.dart';
import '../../widget/manager/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';

class UpdateFormAdminView extends StatefulWidget {
  final dynamic pationt_data;

  UpdateFormAdminView({required this.pationt_data});

  @override
  _UpdateFormAdminViewState createState() => _UpdateFormAdminViewState(this.pationt_data);
}

class _UpdateFormAdminViewState extends State<UpdateFormAdminView> {
  final dynamic pationt_data;
  _UpdateFormAdminViewState(this.pationt_data);

  late AddSessionCubit _patientFormViewCubit;
  Map<int, TextEditingController> textControllers = {};
  Map<int, String> selectedAnswers = {};
  Map<int, bool> checkboxValues = {};
  ConsultationServices? selected_consultation;


  @override
  void initState() {
    super.initState();
    _patientFormViewCubit = AddSessionCubit();
    _patientFormViewCubit.getPatientDetails(widget.pationt_data.nationalId);
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
    return BlocBuilder<AddSessionCubit, AddSessionStates>(
      bloc: _patientFormViewCubit,
      builder: (context, state) {
        if (state is LoadingAddSessionState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ErrorAddSessionState) {
          return Center(child: Text(state.errorMessage));
        } else if (state is SuccessPatientNationalIdState) {
          var formData = state.result.data["pationt"]["form"];
          var answers = formData["answers"];
          var consultation = formData["consultationService"];
          ConsultationServices consultations = ConsultationServices.fromJson(formData["consultationService"] );
          if(selected_consultation==null)
          {
            selected_consultation = consultations;
          }
          _initializeTextControllers(answers);
          TextEditingController commentController = TextEditingController(text: formData["comments"]);
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
                    // Expanded(
                    //   child: Container(
                    //     height: Constants.mediaQuery.height * 0.8,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       color: Constants.theme.primaryColor.withOpacity(0.3),
                    //       borderRadius: BorderRadius.all(Radius.circular(10)),
                    //     ),
                    //     child: ListView.builder(
                    //       itemCount: answers.length+1,
                    //       itemBuilder: (context, index) {
                    //
                    //         var answer = answers[index];
                    //         return Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             if (answers.length != index + 1) ...[
                    //               Center(
                    //                 child: Text(
                    //                   answer["title"],
                    //                   style: Constants.theme.textTheme.titleLarge?.copyWith(
                    //                     fontWeight: FontWeight.bold,
                    //                   ),
                    //                 ),
                    //               ),
                    //               Container(
                    //                 width: double.infinity,
                    //                 height: answer["question_options"].length > 1
                    //                     ? answer["question_options"].length * 50
                    //                     : 70,
                    //                 margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    //                 decoration: BoxDecoration(
                    //                   color: Colors.grey.shade300,
                    //                   borderRadius: BorderRadius.only(
                    //                     topLeft: Radius.circular(20),
                    //                     topRight: Radius.circular(20),
                    //                   ),
                    //                 ),
                    //                 child: Column(
                    //                   children: answer["question_options"].map<Widget>((option) {
                    //                     bool isAnswered = option['answer'] == "1";
                    //                     if (option["type"] == 3) {
                    //                       return Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: Text(
                    //                               option["title"].toString(),
                    //                               style: Constants.theme.textTheme.bodyMedium?.copyWith(
                    //                                 color: Colors.black,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           Expanded(
                    //                             child: QuestionTextField(
                    //                               hint: "ادخل النص",
                    //                               maxLines: 1,
                    //                               controller: textControllers[int.parse(option["id"].toString())],
                    //                               onChanged: (value) {
                    //                                 setState(() {
                    //                                   option["answer"] = value;
                    //                                 });
                    //                               },
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       );
                    //                     } else if (option["type"] == 1) {
                    //                       return Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: Text(
                    //                               option["title"].toString(),
                    //                               style: Constants.theme.textTheme.bodyMedium?.copyWith(
                    //                                 color: Colors.black,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           Expanded(
                    //                             child: Radio<String>(
                    //                               value: option["id"].toString(),
                    //                               groupValue: selectedAnswers[int.parse(answer["id"].toString())],
                    //                               onChanged: (value) {
                    //                                 setState(() {
                    //                                   selectedAnswers[int.parse(answer["id"].toString())] = value!;
                    //                                   for (var opt in answer["question_options"]) {
                    //                                     if (opt["type"] == 1) {
                    //                                       opt["answer"] = opt["id"].toString() == value ? "1" : "0";
                    //                                     }
                    //                                   }
                    //                                 });
                    //                               },
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       );
                    //                     } else if (option["type"] == 2) {
                    //                       return Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: Text(
                    //                               option["title"].toString(),
                    //                               style: Constants.theme.textTheme.bodyMedium?.copyWith(
                    //                                 color: Colors.black,
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           Expanded(
                    //                             child: Checkbox(
                    //                               value: checkboxValues[int.parse(option["id"].toString())] ?? false,
                    //                               onChanged: (value) {
                    //                                 setState(() {
                    //                                   checkboxValues[int.parse(option["id"].toString())] = value!;
                    //                                   option["answer"] = value ? "1" : "0";
                    //                                 });
                    //                               },
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       );
                    //                     }
                    //                     return Container();
                    //                   }).toList(),
                    //                 ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                    //               ),
                    //               Divider(
                    //                 thickness: 2,
                    //                 height: 3,
                    //                 indent: 20,
                    //                 endIndent: 20,
                    //                 color: Colors.grey.shade600,
                    //               ),
                    //               SizedBox(height: 10),
                    //             ] else ...[
                    //               Column(
                    //                 children: [
                    //                   Text(consultation["name"]),
                    //                   SizedBox(height: 10),
                    //                   Container(
                    //                     height: Constants.mediaQuery.height * 0.15,
                    //                     width: double.infinity,
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.grey.shade300,
                    //                       borderRadius: BorderRadius.only(
                    //                         topLeft: Radius.circular(20),
                    //                         topRight: Radius.circular(20),
                    //                       ),
                    //                     ),
                    //                     child: Text(
                    //                       consultation["description"],
                    //                       style: Constants.theme.textTheme.bodyMedium?.copyWith(
                    //                         color: Colors.black,
                    //                       ),
                    //                     ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                    //                   ),
                    //                   SizedBox(height: 15,),
                    //                   BorderRoundedButton(
                    //                     title: "تعديل",
                    //                     onPressed: () {
                    //                       textControllers.forEach((key, value) {
                    //                         // handle text controllers
                    //                       });
                    //                       print(answers);
                    //                       print(selectedAnswers);
                    //                     },
                    //                   )
                    //                 ],
                    //               ).setVerticalPadding(context, enableMediaQuery: false, 20),
                    //             ],
                    //           ],
                    //         );
                    //       },
                    //     ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                    //   ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                    // ),
                Expanded(
                  child: Container(
                    height: Constants.mediaQuery.height * 0.8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Constants.theme.primaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: ListView.builder(
                      itemCount: answers.length + 1,
                      itemBuilder: (context, index) {
                        if (index < answers.length) {
                          var answer = answers[index];
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
                                    ? answer["question_options"].length * 60
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
                            ],
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Row(
                              //                               //   mainAxisAlignment: MainAxisAlignment.center,
                              //                               //   children: [
                              //                               //     Text(consultation["name"]),
                              //                               //   ],
                              //                               // ),
                              //                               // SizedBox(height: 10),
                              //                               // Container(
                              //                               //   height: Constants.mediaQuery.height * 0.15,
                              //                               //   width: double.infinity,
                              //                               //   decoration: BoxDecoration(
                              //                               //     color: Colors.grey.shade300,
                              //                               //     borderRadius: BorderRadius.only(
                              //                               //       topLeft: Radius.circular(20),
                              //                               //       topRight: Radius.circular(20),
                              //                               //     ),
                              //                               //   ),
                              //                               //   child: Text(
                              //                               //     consultation["description"],
                              //                               //     style: Constants.theme.textTheme.bodyMedium?.copyWith(
                              //                               //       color: Colors.black,
                              //                               //     ),
                              //                               //   ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                              //                               // ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                              DropDownButtonConsultaionWidget(

                                onChange: (value) {
                                  setState(() {
                                    selected_consultation = value;
                                    print("=============>"+selected_consultation!.description.toString());
                                  });
                                },
                                selectedValue: selected_consultation??consultation,
                              ),
                              SizedBox(height: 15),
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
                                  selected_consultation?.description??'',
                                  style: Constants.theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.black,
                                  ),
                                ).setHorizontalPadding(
                                    context, enableMediaQuery: false, 20),
                              ).setHorizontalPadding(context, enableMediaQuery: false, 20),

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
                              ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                              SizedBox(height: 20),
                              BorderRoundedButton(
                                title: "تعديل",
                                onPressed: () {
                                  textControllers.forEach((key, value) {
                                    // handle text controllers
                                  });
                                  print(answers);
                                  print(selectedAnswers);
                                },
                              ),
                            ],
                          ).setVerticalPadding(context, enableMediaQuery: false, 20);
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
    allConsultationCubit.getAllConsultationsAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllConsultationCubit, AllConsultationStates>(
      bloc: allConsultationCubit,
      builder: (context, state) {
        if (state is SuccessAllConsultations) {
          List<ConsultationServices> consultations = state.consultationServices as List<ConsultationServices> ?? [];

          int index = consultations.indexWhere((element) => element.id==widget.selectedValue.id);
          if (!consultations.contains(widget.selectedValue)&&index!=-1) {

            widget.selectedValue = consultations.first ;

          }
          else {
            widget.selectedValue = consultations[index];
          }

          return DropdownButton<ConsultationServices?>(
            value: widget.selectedValue,
            onChanged: (ConsultationServices? newValue) {
              if (newValue != null) {
                setState(() {
                  widget.selectedValue = newValue;
                  widget.onChange(newValue);
                  print("^^^^^^^^^^^>"+widget.selectedValue.id.toString());

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