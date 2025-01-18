
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

import '../../../../domain/entities/QuestionModel.dart';
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
  late Map<dynamic, dynamic> radiosBtn = {};
  Map<Questions, SizedBox> questionsWidget = {};
  Map<int, List<Questions>> relatedQuestionsMap = {};
  ConsultationServices? selected_consultation;
  late List<dynamic> answers = [];
  bool isMobile = false;

  void _updateRelatedQuestions(
      Questions mainQuestion,
      int selectedOptionId,
      List<Questions>? relatedQuestions,
      ) {
    // Step 1: Reset all previous related questions for this main question
    mainQuestion.questionOptions?.forEach((option) {
      if (relatedQuestionsMap[option.id] != null) {
        for (var q in relatedQuestionsMap[option.id]!) {
          for (var entry in questionsWidget.entries) {
            if (entry.key.id == q.id) {
              entry.key.isRelatedQuestion = 0; // Reset the flag
            }
          }
        }
      }
    }
    );
    // Step 2: Update the map for the selected option
    relatedQuestionsMap[selectedOptionId] = relatedQuestions ?? [];
    // Step 3: Mark the related questions for the selected option as active
    if (relatedQuestions != null && relatedQuestions.isNotEmpty) {
      for (var q in relatedQuestions) {
        for (var entry in questionsWidget.entries) {
          if (entry.key.id == q.id) {
            entry.key.isRelatedQuestion = 1; // Mark as related
          }
        }
      }
    }

    // Step 4: Update the state to rebuild the UI
    setState(() {});
  }



  @override
  void initState() {
    super.initState();
    _patientFormViewCubit = AddSessionCubit();
    _patientFormViewCubit.getSessionDetails(widget.pationt_data.nationalId,1);//**getSession
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
          var needOtherSession = formData["need_other_session"]==1;
          int needSession = needOtherSession ? 1 : 0;
          ConsultationServices consultations =
          ConsultationServices.fromJson(formData["consultationService"]);
          if (selected_consultation == null) {
            selected_consultation = consultations;
          }
          if (relatedQuestionsMap.isNotEmpty) {
            relatedQuestionsMap.forEach(
                  (key, value) {
                for (var rQuestion in value) {
                  questionsWidget.entries.forEach(
                        (e) {
                      if (e.key.id == rQuestion.id) {
                        e.key.isRelatedQuestion = 0;
                      }
                    },
                  );
                }
              },
            );
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
                                            ? answer["question_options"].length > 1
                                            ? answer["question_options"]
                                            .length * 90
                                            : 80
                                            : answer["question_options"]
                                            .length > 1
                                            ? answer["question_options"]
                                            .length * 80
                                            : 70,
                                        margin:  EdgeInsets.symmetric(
                                            horizontal: isMobile?2:20, vertical: 20),
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
                                            if (option["type"] == 3) {
                                              return Expanded(
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        option["title"]
                                                            .toString(),
                                                        style: isMobile?Constants.theme.textTheme.bodySmall?.copyWith(fontSize: 20).copyWith(color: Colors.black,):Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,),
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
                                                      style: isMobile?Constants.theme.textTheme.bodySmall?.copyWith(fontSize: 20).copyWith(color: Colors.black,):Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,),
                                                    ),
                                                  ),
                                                  // todo change
                                                  // Expanded(
                                                  //   child: Radio<String>(
                                                  //     value:
                                                  //     option["id"].toString(),
                                                  //     groupValue:
                                                  //     selectedAnswers[int.parse(answer["id"].toString())],
                                                  //     onChanged: (value) {
                                                  //       setState(() {
                                                  //         selectedAnswers[
                                                  //           int.parse(answer["id"].toString())] =
                                                  //         value!;
                                                  //         for (var opt in answer["question_options"]) {
                                                  //           if (opt["type"] == 1) {
                                                  //             opt["answer"] = opt["id"]
                                                  //                 .toString() == value ? "1" : "0";
                                                  //           }
                                                  //         }
                                                  //       });
                                                  //     },
                                                  //   ),
                                                  // ),

                                                  Expanded(
                                                    child: Radio<String>(
                                                      value: option["id"].toString(),
                                                      groupValue: selectedAnswers[int.parse(answer["id"].toString())],
                                                      onChanged: (value) {
                                                        setState(() {
                                                          // Update the selected answer
                                                          selectedAnswers[int.parse(answer["id"].toString())] = value!;

                                                          // Update the "answer" property for all options
                                                          for (var opt in answer["question_options"]) {
                                                            if (opt["type"] == 1) {
                                                              opt["answer"] = opt["id"].toString() == value ? "1" : "0";
                                                            }
                                                          }

                                                          // Call the _updateRelatedQuestions function
                                                          final selectedOption = answer["question_options"].firstWhere(
                                                                (opt) => opt["id"].toString() == value,
                                                            orElse: () => null,
                                                          );

                                                          if (selectedOption != null) {
                                                            _updateRelatedQuestions(
                                                              Questions.fromJson(answer), // Convert the current question to the `Questions` model
                                                              int.parse(selectedOption["id"].toString()), // Selected option ID
                                                              (selectedOption["related_questions"] as List?)
                                                                  ?.map((q) => Questions.fromJson(q)) // Map related questions to `Questions`
                                                                  .toList(),
                                                            );
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  )


                                                ],
                                              );
                                            } else if (option["type"] == 2) {
                                              return Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      option["title"]
                                                          .toString(),
                                                      style: isMobile?Constants.theme.textTheme.bodySmall?.copyWith(fontSize: 18).copyWith(color: Colors.black,):Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,),
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
                                      StatefulBuilder(
                                        builder: (context, setState) =>  Column(
                                          children: [
                                            Row(
                                              children: [
                                                Radio<int>(
                                                  value: 1, // Needing another session
                                                  groupValue: needSession,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      needSession = value!;
                                                      needOtherSession = needSession == 1;
                                                    });
                                                  },
                                                ),
                                                Text("الحالة بحاجه إلى جلسة اخرى",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Radio<int>(
                                                  value: 0, // Not needing another session
                                                  groupValue: needSession,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      needSession = value!;
                                                      needOtherSession = needSession == 1;
                                                    });
                                                  },
                                                ),
                                                Text("الحالة ليست بحاجه إلى جلسة اخرى",style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Divider(color: Colors.black54,indent: 10,endIndent:25 ,thickness: 2,),


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
                                            isMobile?5:20),
                                      ).setHorizontalPadding(
                                          context, enableMediaQuery: false, isMobile?5:20),

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
                                            "need_other_session":needSession,
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
                              context, enableMediaQuery: false,isMobile?5: 20),
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
                    child: Text(value.name ?? '',style: Constants.theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black,
                    ),),
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