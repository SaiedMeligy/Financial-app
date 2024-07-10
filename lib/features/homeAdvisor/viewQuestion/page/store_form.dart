import '../widget/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import '../../../../core/widget/Question_text_field.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/domain/entities/QuestionView.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/widget/drop_down.dart';



class StoreForm extends StatefulWidget {
  StoreForm({super.key, required this.pationt_data});
  List<int> axis = [];
  dynamic pationt_data;

  @override
  State<StoreForm> createState() => _StoreFormState();
}

class _StoreFormState extends State<StoreForm> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController _dateTimeController = TextEditingController();
  var questionViewCubit = QuestionViewCubit();
  List<ConsultationServices> menuItem = [];
  List<bool> _checkBoxValues = [];
  late Map<dynamic, dynamic> answers = {};
  late Map<dynamic, dynamic> radiosBtn = {};
  Map<dynamic, TextEditingController> textControllers = {};
  int needOtherSession = 0;
   int selected_consultation_service=0;
  DateTime selectedDate = DateTime.now();
  bool isMobile = false;
  Map<Questions,SizedBox> questionsWidget = {};
Map<int, List<Questions>> relatedQuestionsMap = {};


  TextEditingController advicorComment = TextEditingController();
  void _showDateSelectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('من فضلك اختر التاريخ'),
        duration: Duration(seconds: 2), // Optional: Set the duration for the snack bar
      ),
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
        _updateDateTimeText();
      });
    else{
      _showDateSelectionSnackBar(context);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != _selectedTime)
      setState(() {
        _selectedTime = pickedTime;
        _updateDateTimeText();
      });
  }

  void _updateDateTimeText() {
    if (_selectedDate != null && _selectedTime != null) {
      final date = '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}';
      final time = '${_selectedTime!.hour}:${_selectedTime!.minute}';
      _dateTimeController.text = '$date $time';
    }
  }

  

  void _updateRelatedQuestions(int optionId, List<Questions>? relatedQuestions) {
    if(relatedQuestionsMap[optionId] != null){
if (relatedQuestionsMap[optionId] != null) {
          for (var q in relatedQuestionsMap[optionId]!) {
            questionsWidget.entries.forEach((Q){
              if (Q.key.id == q.id) {
                Q.key.isRelatedQuestion=1;
              }
            });
          }}
        relatedQuestionsMap.remove(optionId);
    }
      if (relatedQuestions != null && relatedQuestions.isNotEmpty) {
        relatedQuestionsMap[optionId] = relatedQuestions;
            if (relatedQuestions != null && relatedQuestions.isNotEmpty) {
          for (var q in relatedQuestions) {
            questionsWidget.entries.forEach((Q){
              if (Q.key.id == q.id) {
                Q.key.isRelatedQuestion=0;
              }
            });
          }}
      }
      setState(() {
    });
  }
  // void _updateRelatedQuestions(int optionId, List<Questions>? relatedQuestions) {
  //   setState(() {
  //     if (relatedQuestions != null && relatedQuestions.isNotEmpty) {
  //       relatedQuestionsMap[optionId] = relatedQuestions;
  //       for (var q in relatedQuestions) {
  //         questionsWidget.forEach((key, value) {
  //           if (key.id == q.id) {
  //             key.isRelatedQuestion = 0;
  //           }
  //         });
  //       }
  //     } else {
  //       relatedQuestionsMap.remove(optionId);
  //     }
  //   });
  // }



  @override
  void initState() {
    super.initState();
    questionViewCubit.getAllQuestion();

    // void _updateRelatedQuestions(int optionId, List<Questions>? relatedQuestions) {
    //   setState(() {
    //     if (relatedQuestions != null && relatedQuestions.isNotEmpty) {
    //       for (var q in relatedQuestions) {
    //         questionsWidget.entries.map((Q){
    //           if (Q.key.id == q.id) {
    //             Q.key.isRelatedQuestion=0;
    //             return MapEntry(Q.key, Q.value);
    //           }
    //         }); 
    //       }
    //       relatedQuestionsMap[optionId] = relatedQuestions;
    //     } else {
    //       relatedQuestionsMap.remove(optionId);
    //     }
    //   });
    // }

  }
  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;

          return BlocBuilder<QuestionViewCubit, QuestionViewStates>(
          bloc: questionViewCubit,
          builder: (context, state) {
            if (state is LoadingQuestionViewState) {
              return const Center(child: CircularProgressIndicator());
            }
            else if (state is SuccessQuestionViewState) {
              var questionsResponse = state.question;

              List<int> axisDisplay = [];
              questionsResponse.forEach((q) {
                
                  _fillQuestionWidgetMap(q);
                
                if (!axisDisplay.contains(q.axisId)) {
                  axisDisplay.add(q.axisId!);
                } else {
                  axisDisplay.add(0);
                }
              });
              if(relatedQuestionsMap.isNotEmpty){
                relatedQuestionsMap.forEach((key, value) {
                  for (var rQuestion in value) {
                    questionsWidget.entries.forEach((e) {
                      if(e.key.id==rQuestion.id){
                        e.key.isRelatedQuestion=0;
                      }
                    },);
                  }
                },);
              }
              _fillAnsewrsMap(questionsResponse);
              List<Questions> questionsList = [];
              questionsWidget.forEach((key, value) {
                  if(key.isRelatedQuestion == 0) {
                    questionsList.add(key);
                  }
              },);
              return Directionality(
                textDirection: TextDirection.rtl,
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: true,
                    backgroundColor: Constants.theme.primaryColor,),
                  body: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/back.jpg'),
                        fit: BoxFit.cover,
                        opacity: .8,
                      ),),
                    child: Row(
                      children: [
                        Container(
                          height: double.maxFinite,
                          width: Constants.mediaQuery.width * 0.2,
                          color: Constants.theme.primaryColor.withOpacity(0.6),
                          child: isMobile?Column(
                            children: [
                              Text(
                                widget.pationt_data['pationt']['name'],
                                style: Constants.theme.textTheme.bodyMedium,
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                              Text(
                                CacheHelper.getData(key: 'name'),
                                style: Constants.theme.textTheme.bodyMedium,
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                              Text(
                                "nationalId: "+widget.pationt_data['pationt']['national_id'],
                                style: Constants.theme.textTheme.bodyMedium,
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                              Text(
                                "${DateTime.now().minute.toString()} : ${DateTime.now().hour.toString()}",
                                style: Constants.theme.textTheme.bodyMedium,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () => _selectDate(context),
                                    icon: Icon(Icons.date_range_outlined, size: 40, color: Colors.white),
                                  ),
                                  // IconButton(
                                  //   onPressed: () => _selectTime(context),
                                  //   icon: Icon(Icons.access_time_filled_rounded, size: 40, color: Colors.white),
                                  // ),
                                ],
                              ),
                            ],
                          ):
                          Column(
                            children: [
                              Text(
                                widget.pationt_data['pationt']['name'],
                                style: Constants.theme.textTheme.titleLarge,
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                              Text(
                                CacheHelper.getData(key: 'name'),
                                style: Constants.theme.textTheme.titleLarge,
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                              Text(
                                "nationalId: "+widget.pationt_data['pationt']['national_id'],
                                style: Constants.theme.textTheme.titleLarge,
                              ),
                              const Divider(
                                color: Colors.white,
                                thickness: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                              Text(
                                "${DateTime.now().minute.toString()} : ${DateTime.now().hour.toString()}",
                                style: Constants.theme.textTheme.titleLarge,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    onPressed: () => _selectDate(context),
                                    icon: Icon(Icons.date_range_outlined, size: 40, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: questionsList.length+1,
                                      itemBuilder: (context, index) {
                                        List<Radio<int>> radiobtnsWidgets= [];
                                      try{
                                        questionsList[index].questionOptions?.
                                        forEach((element) {
                                          if(element.type == 1){
                                            radiobtnsWidgets.add(
                                              Radio<int>(
                                                value: element.id!,
                                                groupValue: radiosBtn[questionsList[index].id],
                                                onChanged: (value) {
                                                  answers[element.id!] = 1; //46 => 0
                                                  questionsList[index].questionOptions?.forEach((o) {
                                                    if(o.type==1){
                                                      if(o.id!= element.id){
                                                        answers[o.id] = 0;
                                                      }
                                                    }
                                                  },);
                                                  setState(() {
                                                    radiosBtn[questionsList[index].id] = value!;
                                                    _updateRelatedQuestions(
                                                        element.id!,
                                                        element.reletedQuestions);
                                                  });
                                                  },
                                              ),
                                            );
                                          }
                                        },);
                                      }
                                      catch(error){
                                        print(error.toString());
                                      }
                                        return
                                          Column(
                                          children: [
                                             if (questionsList.length != index)...[
                                              if (axisDisplay[index] != 0)
                                                Column(
                                                  children: [
                                                    Text(questionsList[index].axis!.name.toString(),
                                                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Container(
                                                      height: 3,
                                                      width: 140,
                                                      color: Colors.black54,
                                                    )
                                                  ],
                                                ),
                                              const SizedBox(height: 10),
                                                
                                                    questionsWidget.entries.firstWhere((q)=>q.key.id==questionsList[index].id).value,
                                                  SizedBox(height: 10,),
                                                
                                        ]
                                            else ...[
                                              Column(
                                                children: [
                                                  Text(
                                                    "ملاحظات الاستشاري",
                                                    style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  CustomTextField(
                                                    maxLines: 4,
                                                    hint: "ملاحظات الاستشاري",
                                                    controller: advicorComment,
                                                  ),
                                                  isMobile?Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            " هل يحتاج الي جلسة اخري", style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                              color: Colors.black),
                                                          ),
                                                          Checkbox(
                                                            value: (needOtherSession == 1),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                needOtherSession =
                                                                (value!) ? 1 : 0;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "الخدمة الاستشارية",
                                                            style: Constants.theme
                                                                .textTheme.bodyMedium
                                                                ?.copyWith(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          DropDown(

                                                            onChange: (value) {
                                                              setState(() {
                                                                selected_consultation_service = value;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ):
                                                      SizedBox(height: 10,),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            " هل يحتاج الي جلسة اخري", style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                                    color: Colors.black),
                                                          ),
                                                          Checkbox(
                                                            value: (needOtherSession == 1),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                needOtherSession =
                                                                    (value!) ? 1 : 0;
                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "الخدمة الاستشارية",
                                                            style: Constants.theme
                                                                .textTheme.titleLarge
                                                                ?.copyWith(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          DropDown(
                                                            onChange: (value) {
                                                              setState(() {
                                                                selected_consultation_service = value;


                                                              });
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Column(
                                                      crossAxisAlignment:  CrossAxisAlignment.stretch,
                                                    children: [
                                                      BorderRoundedButton(
                                                        title: "التالي",
                                                          onPressed: () {
                                                          if (advicorComment.text.isEmpty) {
                                                            SnackBarService.showErrorMessage(
                                                              "من فضلك ادخل ملاحظات الاستشاري",
                                                            );// Exit the onPressed handler early
                                                          }
                                                            if (_selectedDate == null) {
                                                              SnackBarService.showErrorMessage(
                                                                "من فضلك اختر التاريخ ",
                                                              );// Exit the onPressed handler early
                                                            }

                                                            setState(() {
                                                              textControllers.forEach((key1, val) {
                                                                answers[key1] = val.text;
                                                              });
                                                            });

                                                            List<dynamic> lastAnswers = [];

                                                            answers.forEach((key, value) {
                                                              lastAnswers.add({
                                                                "question_option_id": key,
                                                                "pationt_answer": value
                                                              });
                                                            });

                                                            Map<String, dynamic> storeDate = {
                                                              "advicor_id": CacheHelper.getData(key: 'id'),
                                                              "pationt_id": widget.pationt_data['pationt']['id'],
                                                              "need_other_session": needOtherSession,
                                                              "consultation_service_id": selected_consultation_service,
                                                              "comments": advicorComment.text,
                                                              "date":_selectedDate?.toString() ?? '',
                                                              "answers": lastAnswers
                                                            };

                                                            print("Data to be sent: $storeDate"); // Log the data before sending

                                                            questionViewCubit.getStoreForm(storeDate).then((value) {
                                                              if(value!=null) {
                                                                Navigator.pop(context);
                                                                SnackBarService.showSuccessMessage("تم اضافة الفورم");
                                                              }
                                                            });
                                                          }
                                                      ).setVerticalPadding(context,enableMediaQuery: false, 20),
                                                    ],
                                                  ).setHorizontalPadding(
                                                      context,
                                                      enableMediaQuery: false,
                                                      10),
                                                ],
                                              ),
                                            ]
                                          ]
                                        ).setVerticalPadding(
                                                context,
                                                enableMediaQuery: false,
                                                10)
                                            .setHorizontalPadding(
                                                context,
                                                enableMediaQuery: false,
                                                10);
                                      }),
                                ),

                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
        );
            } else if (state is ErrorQuestionViewState) {
              return Center(child: Text(state.errorMessage));
            }
            return const SizedBox.shrink();
          },
        );
      }
    );
  }

  void _fillQuestionWidgetMap(Questions q) {
    questionsWidget.addAll({q:_buildQuestionWidget(q)});
    q.questionOptions?.forEach((qOption) {
      if(qOption.reletedQuestions != null && qOption.reletedQuestions!.isNotEmpty){
        qOption.reletedQuestions?.forEach((relatedQ) {
          _fillQuestionWidgetMap(relatedQ);
        },);
      }
    },);
  }

  void _fillAnsewrsMap(List<Questions> questions) {
    if (answers.isEmpty) {
      for (int index = 0; index < questions.length; index++) {

        radiosBtn[questions[index].id!] = -1;
        for (int i = 0; i < questions[index].questionOptions!.length; i++) {
          answers[questions[index].questionOptions![i].id] = 0;
          radiosBtn.addAll({questions[index].id: -1,
          });
          answers.addAll({
            questions[index].questionOptions![i].id: 0,
          });
          if (questions[index].questionOptions![i].type == 3) {
            textControllers.addAll({
              questions[index].questionOptions![i].id:
                  TextEditingController(text: ""),
            });
          }
          /////
          if (questions[index].questionOptions![i].reletedQuestions != null && questions[index].questionOptions![i].reletedQuestions!.isNotEmpty) {
            _fillAnsewrsMap(questions[index].questionOptions![i].reletedQuestions as List<Questions>);
          }
          ////
        }
      }
    }
  }

  SizedBox _buildQuestion(List<Questions> question, int index, BuildContext context) {
    return SizedBox(
                                              width: double.infinity,
                                              child:
                                              CustomPaint(foregroundPainter: LinePainter(
                                                    text: question[index].title.toString(),
                                                  ),
                                                  child: Container(
                                                    width: Constants.mediaQuery.width * 0.2,
                                                    height: question[index].questionOptions!.length > 2
                                                        ? question[index].questionOptions!.length * 100 : 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(
                                                        color: Colors.black87,
                                                        width: 2.5,),),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        for (int i = 0; i < question[index].questionOptions!.length; i++) ...[
                                                          Expanded(
                                                            child: Container(
                                                              width: Constants.mediaQuery.width * 0.47,
                                                              height: Constants.mediaQuery.height * 0.1,
                                                              margin: const EdgeInsets.all(8),
                                                              decoration: BoxDecoration(
                                                                color: Colors.white54,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: question[index].questionOptions![i].type != 3
                                                                    ? Border.all(
                                                                  color: Colors.black87,
                                                                  width: 2.5,
                                                                )
                                                                    : null,
                                                              ),
                                                              child:
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                                  question[index].questionOptions![i].title.toString(),
                                                                                  style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                  if (question[index].questionOptions![i].type == 1)
                                                                    Radio<int>(
                                                                      value: question[index].questionOptions![i].id ?? 0,
                                                                      groupValue: radiosBtn[question[index].id],
                                                                      onChanged: (value) {
                                                                        answers[question[index].questionOptions![i].id] = 1;
                                                                        question[index].questionOptions!.forEach(
                                                                                (o) {
                                                                              if (o.type == 1) {
                                                                                if (o.id != question[index].questionOptions![i].id) {
                                                                                  answers[o.id] = 0;
                                                                                }
                                                                              }
                                                                            });
                                                                        radiosBtn[question[index].id] = value!;
                                                                        _updateRelatedQuestions(question[index].questionOptions![i].id!,
                                                                            question[index].questionOptions![i].reletedQuestions);
                                                                        setState(() {});
                                                                      },
                                                                    ),
                                                                  if (question[index].questionOptions![i].type == 2)
                                                                    Checkbox(
                                                                      value: (answers[question[index].questionOptions![i].id] == 1)
                                                                          ? true
                                                                          : false,
                                                                      onChanged: (value) {
                                                                        answers[question[index].questionOptions![i].id] =
                                                                        (value!) ? 1 : 0;
                                                                        setState(() {});
                                                                      },
                                                                    ),
                                                                  if (question[index].questionOptions![i].type == 3)
                                                                    Container(
                                                                      width: Constants.mediaQuery.width * 0.2,
                                                                      height: Constants.mediaQuery.height * 0.2,
                                                                      decoration: BoxDecoration(),
                                                                      child: QuestionTextField(
                                                                        hint: "ادخل النص",
                                                                        maxLines: 3,
                                                                        controller: textControllers[
                                                                          question[index].questionOptions![i].id!],
                                                                      ),
                                                                    ).setVerticalPadding(context, enableMediaQuery: false, 5),
                                                                ],
                                                              ),
                                                            ),
                                                          ),


                                                        ],
                                                      ],
                                                    ),
                                                  ),

                                              ),
                                            );
  }
  SizedBox _buildQuestionWidget(Questions question) {
    return SizedBox(
                                              width: double.infinity,
                                              child:
                                              CustomPaint(foregroundPainter: LinePainter(
                                                    text: question.title.toString(),
                                                  ),
                                                  child: Container(
                                                    width: Constants.mediaQuery.width * 0.2,
                                                    height: question.questionOptions!.length > 2
                                                        ? question.questionOptions!.length * 100 : 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(
                                                        color: Colors.black87,
                                                        width: 2.5,),),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        for (int i = 0; i < question.questionOptions!.length; i++) ...[
                                                          Expanded(
                                                            child: Container(
                                                              width: Constants.mediaQuery.width * 0.47,
                                                              height: Constants.mediaQuery.height * 0.1,
                                                              margin: const EdgeInsets.all(8),
                                                              decoration: BoxDecoration(
                                                                color: Colors.white54,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: question.questionOptions![i].type != 3
                                                                    ? Border.all(
                                                                  color: Colors.black87,
                                                                  width: 2.5,
                                                                )
                                                                    : null,
                                                              ),
                                                              child:
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text(
                                                                                  question.questionOptions![i].title.toString(),
                                                                                  style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                  if (question.questionOptions![i].type == 1)
                                                                    Radio<int>(
                                                                      value: question.questionOptions![i].id ?? 0,
                                                                      groupValue: radiosBtn[question.id],
                                                                      onChanged: (value) {
                                                                        answers[question.questionOptions![i].id] = 1;
                                                                        question.questionOptions!.forEach(
                                                                                (o) {
                                                                              if (o.type == 1) {
                                                                                if (o.id != question.questionOptions![i].id) {
                                                                                  answers[o.id] = 0;
                                                                                }
                                                                              }
                                                                            });
                                                                        radiosBtn[question.id] = value!;
                                                                        _updateRelatedQuestions(question.questionOptions![i].id!,
                                                                            question.questionOptions![i].reletedQuestions);
                                                                        setState(() {});
                                                                      },
                                                                    ),
                                                                  if (question.questionOptions![i].type == 2)
                                                                    Checkbox(
                                                                      value: (answers[question.questionOptions![i].id] == 1)
                                                                          ? true
                                                                          : false,
                                                                      onChanged: (value) {
                                                                        answers[question.questionOptions![i].id] =
                                                                        (value!) ? 1 : 0;
                                                                        setState(() {});
                                                                      },
                                                                    ),
                                                                  if (question.questionOptions![i].type == 3)
                                                                    Container(
                                                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                                                      width: Constants.mediaQuery.width * 0.2,
                                                                      height: Constants.mediaQuery.height * 0.2,
                                                                      decoration: BoxDecoration(),
                                                                      child: QuestionTextField(
                                                                        hint: "ادخل النص",
                                                                        maxLines: 3,
                                                                        controller: textControllers[
                                                                          question.questionOptions![i].id!],
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),


                                                        ],
                                                      ],
                                                    ),
                                                  ),

                                              ),
                                            );
  }

}


class LinePainter extends CustomPainter {
  final String text;
  final double padding; // Add padding property

  LinePainter(
      {required this.text, this.padding = 15}); // Default padding is 10.0

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Constants.theme.primaryColor.withOpacity(0.8)
      ..strokeWidth = 15;

    var path = Path();

    double margin = padding; // Use padding for margin

    path.moveTo(margin, margin);
    path.lineTo(size.width * 0.30 - margin, margin);
    path.lineTo(size.width * 0.30 - margin, size.height - margin);
    path.lineTo(margin, size.height - margin);
    path.close();

    canvas.drawPath(path, paint);

    var textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: Constants.theme.textTheme.titleLarge?.copyWith(),
      ),
      textAlign: TextAlign.center,
       textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth:
          size.width * 0.30 - 2 * margin, // Subtract padding from maxWidth
    );

    var offset = Offset(
      margin +
          (size.width * 0.30 - 2 * margin - textPainter.width) /
              2, // Adjust x position based on padding
      (size.height - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}


//         if (question[index].questionOptions!.length > 1)
//           for(int i = 0; i < question[index].questionOptions!.length;i++)
//        if (relatedQuestionsMap.containsKey(question[index].questionOptions![i].id))
//          for(var relatedQuestionOption in relatedQuestionsMap[question[index].questionOptions![i].id]!)
//            // for(var relatedOption in relatedQuestionOption.questionOptions)
//             SizedBox(
//              width: double.infinity,
//              child: CustomPaint(foregroundPainter: LinePainter(
//              text: relatedQuestionOption.title.toString(),),
//                  child: Container(
//                    width: Constants.mediaQuery.width * 0.2,
//                    height: question[index].questionOptions!.length > 2
//                        ? question[index].questionOptions!.length * 500 :400 ,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10),
//                      border: Border.all(
//                        color: Colors.black87,
//                        width: 2.5,),),
//
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                         // for (int i = 0; i < relatedQuestionOption.questionOptions!.length; i++) ...[
//                           for(var relatedOption in relatedQuestionOption.questionOptions)
//                            Expanded(
//                              child: Container(
//                              width: Constants.mediaQuery.width * 0.47,
//                              height: Constants.mediaQuery.height * 0.15,
//                              margin: const EdgeInsets.all(8),
//                              decoration: BoxDecoration(
//                                color: Colors.white54,
//                                borderRadius: BorderRadius.circular(10),
//                                border: question[index].questionOptions![i].type != 3 ? Border.all(
//                                  color: Colors.black87,
//                                  width: 2.5,
//                                ) : null,
//                                                                                 ),
//                              child: Row(
//                                crossAxisAlignment: CrossAxisAlignment.center,
//                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                children: [
//                                  Text(
//                                    relatedOption.title.toString(),
//                                    style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                      color: Colors.black,
//                                    ),
//                                  ),
//
//                                  if (relatedOption.type == 1)
//                                    Radio<int>(
//                                      value: relatedOption.id ?? 0,
//                                      groupValue: radiosBtn[relatedQuestionOption.id],
//                                      onChanged: (value) {
//                                        setState(() {
//                                          radiosBtn[relatedQuestionOption.id] = value!;
//                                          answers[relatedOption.id] = 1;
//                                          question[index].questionOptions!.forEach((o) {
//                                            if (o.type == 1) {
//                                              if (o.id != question[index].questionOptions![i].id) {
//                                                answers[o.id] = 0;
//                                              }
//                                            }
//                                          });
//
//                                        });
//
//                                        _updateRelatedQuestions(question[index].questionOptions![i].id!,
//                                            question[index].questionOptions![i].reletedQuestions);
//
//                                      },
//                                    ),
//                                  if (relatedOption.type == 2)
//                                    Checkbox(
//                                      value: (answers[relatedOption.id] == 1) ? true : false,
//                                      onChanged: (value) {
//                                        answers[relatedOption.id] =
//                                        (value!) ? 1 : 0;
//                                        setState(() {});
//                                        },
//                                    ),
//                                  if (relatedOption.type == 3)
//                                    Container(
//                                      width: Constants.mediaQuery.width * 0.2,
//                                      height: Constants.mediaQuery.height * 0.2,
//                                      decoration: BoxDecoration(),
//                                      child: QuestionTextField(
//                                        hint: "ادخل النص",
//                                        maxLines: 3,
//                                        controller: textControllers[relatedOption.id!],
//                                      ),
//                                    ).setVerticalPadding(context, enableMediaQuery: false, 5),
//                                ],
//                              ),
//                                                                                             ),
//                            ),
// ]
// ),
// ),
//                            ),
// ),