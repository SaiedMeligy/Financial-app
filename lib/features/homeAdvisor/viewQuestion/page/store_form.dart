import 'package:flutter/widgets.dart';
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

// ignore: must_be_immutable
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
  final TextEditingController _dateTimeController = TextEditingController();
  var questionViewCubit = QuestionViewCubit();
  List<ConsultationServices> menuItem = [];
  late Map<dynamic, dynamic> answers = {};
  late Map<dynamic, dynamic> radiosBtn = {};
  Map<int, TextEditingController> textControllers = {};
  Map<Questions, SizedBox> questionsWidget = {};
  Map<int, List<Questions>> relatedQuestionsMap = {};
  bool readyState = false;
  int needOtherSession = 0;
  int selectedConsultationService = 0;
  DateTime selectedDate = DateTime.now();
  bool isMobile = false;

  TextEditingController adviserCommentController = TextEditingController();
  void _showDateSelectionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('من فضلك اختر التاريخ'),
        duration: Duration(
            seconds: 2), // Optional: Set the duration for the snack bar
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
    else {
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
      final date =
          '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}';
      final time = '${_selectedTime!.hour}:${_selectedTime!.minute}';
      _dateTimeController.text = '$date $time';
    }
  }

  void _updateRelatedQuestions(
      Questions mainQuestion, int optionId, List<Questions>? relatedQuestions) {
    relatedQuestionsMap[optionId] = relatedQuestions ?? [];
    if (relatedQuestions != null && relatedQuestions.isNotEmpty) {
      for (var q in relatedQuestions) {
        for (var Q in questionsWidget.entries) {
          if (Q.key.id == q.id) {
            Q.key.isRelatedQuestion = 0;
          }
        }
      }
    }
    mainQuestion.questionOptions?.forEach(
      (option) {
        if (option.id != optionId) {
          if (relatedQuestionsMap[option.id] != null) {
            for (var q in relatedQuestionsMap[option.id]!) {
              questionsWidget.entries.forEach((Q) {
                if (Q.key.id == q.id) {
                  Q.key.isRelatedQuestion = 1;
                  if (Q.key.questionOptions!.isNotEmpty) {
                    Q.key.questionOptions?.forEach(
                      (option) {
                        if(option.id == 207||option.id ==206){
                            print("hi");
                        }
                        if (option.type! < 3) {
                          answers[option.id] = 0;
                          radiosBtn[Q.key.id!] = -1;
                        } else {
                          answers[option.id] = null;
                          textControllers[option.id!] =
                              TextEditingController(text: "");
                        }
                        
                        _updateRelatedQuestions(
                              Q.key, option.id!, option.reletedQuestions);
                      },
                    );
                  }
                }
              });
            }
            relatedQuestionsMap.remove(option.id);
          }
        }
      },
    );
    print(relatedQuestionsMap);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    questionViewCubit.getAllQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      isMobile = constraints.maxWidth < 600;
      return BlocBuilder<QuestionViewCubit, QuestionViewStates>(
        bloc: questionViewCubit,
        builder: (context, state) {
          if (state is LoadingQuestionViewState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessQuestionViewState) {
            var questionsResponse = state.question;

            for (var q in questionsResponse) {
              _fillQuestionWidgetMap(q);
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

            _fillAnswersMap(questionsResponse);

            List<Questions> questionsList = [];
            questionsWidget.forEach(
              (key, value) {
                if (key.isRelatedQuestion == 0) {
                  questionsList.add(key);
                }
              },
            );

            List<int> axisDisplay = [];
            for (var q in questionsList) {
              if (!axisDisplay.contains(q.axisId)) {
                axisDisplay.add(q.axisId!);
              } else {
                axisDisplay.add(0);
              }
            }

            List<Radio<int>> radiobtnsWidgets = [];
            for (int index = 0; index < questionsList.length; index++) {
              try {
                questionsList[index].questionOptions?.forEach(
                  (element) {
                    if (element.type == 1) {
                      radiobtnsWidgets.add(
                        Radio<int>(
                          value: element.id!,
                          groupValue: radiosBtn[questionsList[index].id],
                          onChanged: (value) {
                            answers[element.id!] = 1;
                            questionsList[index].questionOptions?.forEach(
                              (o) {
                                if (o.type == 1) {
                                  if (o.id != element.id) {
                                    answers[o.id] = 0;
                                  }
                                }
                              },
                            );
                            setState(() {
                              radiosBtn[questionsList[index].id] = value!;
                              _updateRelatedQuestions(questionsList[index],
                                  element.id!, element.reletedQuestions);
                            });
                          },
                        ),
                      );
                    }
                  },
                );
              } catch (error) {
                print(error.toString());
              }
            }

            print(relatedQuestionsMap);
            print(questionsWidget);

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: true,
                  backgroundColor: Constants.theme.primaryColor,
                ),
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/back.jpg'),
                      fit: BoxFit.cover,
                      opacity: .2,
                    ),
                  ),
                  child: Row(
                    children: [
                      // PatientInfoWidget(
                      //   isMobile: isMobile,
                      //   pationtData: widget.pationt_data,
                      // ),
                      Container(
                        height: double.maxFinite,
                        width: Constants.mediaQuery.width * 0.2,
                        color: Constants.theme.primaryColor.withOpacity(0.6),
                        child: isMobile
                            ? Column(
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
                                    "رقم الهوية الأماراتية: " +
                                        widget.pationt_data['pationt']
                                            ['national_id'],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                        icon: Icon(Icons.date_range_outlined,
                                            size: 40, color: Colors.white),
                                      ),
                                      // IconButton(
                                      //   onPressed: () => _selectTime(context),
                                      //   icon: Icon(Icons.access_time_filled_rounded, size: 40, color: Colors.white),
                                      // ),
                                    ],
                                  ),
                                ],
                              )
                            : Column(
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
                                    "رقم الهوية الأماراتية: " +
                                        widget.pationt_data['pationt']
                                            ['national_id'],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          _selectDate(context);
                                        },
                                        icon: Icon(Icons.date_range_outlined,
                                            size: 40, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: questionsList.length + 1, // Ensure that the index doesn't go out of bounds.
                          itemBuilder: (context, index) {
                            if (index < questionsList.length) {
                              final displayedQuestion = questionsWidget.entries
                                  .firstWhere((q) => q.key.id == questionsList[index].id);

                              if (displayedQuestion.key.isRelatedQuestion == 0) {
                                return Column(
                                  children: [
                                    if (index < axisDisplay.length && axisDisplay[index] != 0)
                                      AxisWidget(
                                        axisName: questionsList[index].axis!.name.toString(),
                                        isMobile: isMobile,
                                      ),
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: isMobile ? 2 : 20),
                                      child: displayedQuestion.value,
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ).setHorizontalPadding(
                                  context,
                                  enableMediaQuery: false,
                                  (Constants.mediaQuery.width > 600) ? 2 : 10,
                                );
                              }
                            } else {
                              // The "adviser comment" section
                              return Column(
                                children: [
                                  Text(
                                    "ملاحظات الاستشارى",
                                    style: Constants.theme.textTheme.titleLarge?.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  CustomTextField(
                                    maxLines: 4,
                                    hint: "ملاحظات الاستشارى",
                                    controller: adviserCommentController,
                                  ),
                                  NeedOtherSessionAndConsultationServiceWidget(
                                    isMobile: isMobile,
                                    needOtherSessionValue: needOtherSession,
                                    onConsultationServiceChange: (value) {
                                      setState(() {
                                        selectedConsultationService = value;
                                      });
                                    },
                                    onNeedOtherSessionChange: (value) {
                                      setState(() {
                                        needOtherSession = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      BorderRoundedButton(
                                        title: "التالي",
                                        onPressed: () {
                                          submitForm(context);
                                        },
                                      ).setVerticalPadding(context, enableMediaQuery: false, 20),
                                    ],
                                  ).setHorizontalPadding(context, enableMediaQuery: false, 10),
                                ],
                              ).setHorizontalPadding(context, enableMediaQuery: false, 20);
                            }
                          },
                        ),
                      )

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
    });
  }

  void submitForm(BuildContext context) {
    if (adviserCommentController.text.isEmpty) {
      SnackBarService.showErrorMessage("من فضلك ادخل ملاحظات الاستشارى");
    } else if (_selectedDate == null) {
      SnackBarService.showErrorMessage("من فضلك اختر التاريخ ");
    } else {
      setState(() {
        textControllers.forEach((key1, val) {
          answers[key1] = val.text;
        });
      });

      List<dynamic> lastAnswers = [];
      answers.forEach((key, value) {
        lastAnswers.add({
          "question_option_id": key,
          "pationt_answer": value,
        });
      });

      Map<String, dynamic> storeDate = {
        "advicor_id": CacheHelper.getData(key: 'id'),
        "pationt_id": widget.pationt_data['pationt']['id'],
        "need_other_session": needOtherSession,
        "consultation_service_id": selectedConsultationService,
        "comments": adviserCommentController.text,
        "date": _selectedDate?.toString() ?? '',
        "answers": lastAnswers,
      };

      print("Data to be sent: $storeDate");

      questionViewCubit.getStoreForm(storeDate).then((value) {
        if (value != null) {
          Navigator.pop(context);
          SnackBarService.showSuccessMessage("تم اضافة الفورم");
        }
      });
    }
  }

  void _fillQuestionWidgetMap(Questions q) {
    questionsWidget.addAll({q: _buildQuestionWidget(q)});
    q.questionOptions?.forEach(
      (qOption) {
        if (qOption.reletedQuestions != null &&
            qOption.reletedQuestions!.isNotEmpty) {
          qOption.reletedQuestions?.forEach(
            (relatedQ) {
              _fillQuestionWidgetMap(relatedQ);
            },
          );
        }
      },
    );
  }

  void _fillAnswersMap(List<Questions> questions) {
    if (answers.isEmpty) {
      for (int index = 0; index < questions.length; index++) {
        radiosBtn[questions[index].id!] = -1;
        for (int i = 0; i < questions[index].questionOptions!.length; i++) {
          answers[questions[index].questionOptions![i].id] = 0;
          radiosBtn.addAll({
            questions[index].id: -1,
          });
          answers.addAll({
            questions[index].questionOptions![i].id: 0,
          });
          if (questions[index].questionOptions![i].type == 3) {
            textControllers.addAll({
              questions[index].questionOptions![i].id!:
                  TextEditingController(text: ""),
            });
          }
          /////
          if (questions[index].questionOptions![i].reletedQuestions != null &&
              questions[index]
                  .questionOptions![i]
                  .reletedQuestions!
                  .isNotEmpty) {
            _fillAnswersMap(questions[index]
                .questionOptions![i]
                .reletedQuestions as List<Questions>);
          }
          ////
        }
      }
    }
  }

  SizedBox _buildQuestionWidget(Questions question) {
    return SizedBox(
      width: double.infinity,
      child: CustomPaint(
        foregroundPainter: LinePainter(
          text: question.title.toString(),
        ),
        child: Container(
          width: Constants.mediaQuery.width * 0.3,
          height: question.questionOptions!.length > 2
              ? question.questionOptions!.length * 100
              : 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black87,
              width: 2.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (int i = 0; i < question.questionOptions!.length; i++) ...[
                Expanded(
                  child: Container(
                    width: Constants.mediaQuery.width * 0.48,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            question.questionOptions![i].title.toString(),
                            style: isMobile
                                ? Constants.theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.black,
                                  )
                                : Constants.theme.textTheme.bodyMedium
                                    ?.copyWith(
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                        if (question.questionOptions![i].type == 1)
                          Radio<int>(
                            value: question.questionOptions![i].id ?? 0,
                            groupValue: radiosBtn[question.id],
                            onChanged: (value) {
                              answers[question.questionOptions![i].id] = 1;
                              for (var o in question.questionOptions!) {
                                if (o.type == 1) {
                                  if (o.id != question.questionOptions![i].id) {
                                    answers[o.id] = 0;
                                  }
                                }
                              }
                              radiosBtn[question.id] = value!;
                              _updateRelatedQuestions(
                                  question,
                                  question.questionOptions![i].id!,
                                  question
                                      .questionOptions![i].reletedQuestions);
                              setState(() {});
                            },
                          ),
                        if (question.questionOptions![i].type == 2)
                          Checkbox(
                            value:
                                (answers[question.questionOptions![i].id] == 1)
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
                              onChanged: (value) {
                                answers[question.questionOptions![i].id] =
                                    value;
                                setState(() {});
                              },
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
  final double padding;

  LinePainter({required this.text, this.padding = 15});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Constants.theme.primaryColor.withOpacity(0.8)
      ..strokeWidth = (Constants.mediaQuery.width > 600) ? 25 : 15;

    var path = Path();

    double margin = padding;

    path.moveTo(margin, margin);
    path.lineTo(size.width * 0.30 - margin, margin);
    path.lineTo(size.width * 0.30 - margin, size.height - margin);
    path.lineTo(margin, size.height - margin);
    path.close();

    canvas.drawPath(path, paint);

    // Determine the font size based on screen width
    double fontSize = 9;
    double fontSize2 = 20;

    var textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: (Constants.mediaQuery.width < 600)
            ? Constants.theme.textTheme.bodyMedium?.copyWith(fontSize: fontSize)
            : Constants.theme.textTheme.titleLarge
                ?.copyWith(fontSize: fontSize2),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width * 0.30 - 2 * margin,
    );

    var offset = Offset(
      margin + (size.width * 0.30 - 2 * margin - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class PatientInfoWidget extends StatelessWidget {
  const PatientInfoWidget(
      {super.key, required this.isMobile, required this.pationtData});
  final bool isMobile;
  final dynamic pationtData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: Constants.mediaQuery.width * 0.2,
      color: Constants.theme.primaryColor.withOpacity(0.6),
      child: isMobile
          ? Column(
              children: [
                Text(
                  pationtData['pationt']['name'],
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
                  "رقم الهوية الأماراتية: " +
                      pationtData['pationt']['national_id'],
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
                      onPressed: () {
// _selectDate(context)
                      },
                      icon: Icon(Icons.date_range_outlined,
                          size: 40, color: Colors.white),
                    ),
                    // IconButton(
                    //   onPressed: () => _selectTime(context),
                    //   icon: Icon(Icons.access_time_filled_rounded, size: 40, color: Colors.white),
                    // ),
                  ],
                ),
              ],
            )
          : Column(
              children: [
                Text(
                  pationtData['pationt']['name'],
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
                  "رقم الهوية الأماراتية: " +
                      pationtData['pationt']['national_id'],
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
                      onPressed: () {
                        // _selectDate(context);
                      },
                      icon: Icon(Icons.date_range_outlined,
                          size: 40, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}

class NeedOtherSessionAndConsultationServiceWidget extends StatelessWidget {
  const NeedOtherSessionAndConsultationServiceWidget(
      {super.key,
      required this.isMobile,
      required this.onNeedOtherSessionChange,
      required this.onConsultationServiceChange,
      required this.needOtherSessionValue});
  final bool isMobile;
  final ValueChanged onNeedOtherSessionChange;
  final ValueChanged onConsultationServiceChange;
  final int needOtherSessionValue;
  @override
  Widget build(BuildContext context) {
    return isMobile
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    " هل يحتاج إلى جلسة أخرى",
                    style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  Checkbox(
                    value: (needOtherSessionValue == 1),
                    onChanged: (value) {
                      onNeedOtherSessionChange((value!) ? 1 : 0);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "الخدمة الاستشارية",
                    style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  DropDown(
                    onChange: (value) {
                      onConsultationServiceChange(value);
                    },
                  ),
                ],
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    " هل يحتاج إلى جلسة أخرى",
                    style: isMobile
                        ? Constants.theme.textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                          )
                        : Constants.theme.textTheme.titleLarge?.copyWith(
                            color: Colors.black,
                          ),
                  ),
                  Checkbox(
                    value: (needOtherSessionValue == 1),
                    onChanged: (value) {
                      onNeedOtherSessionChange((value!) ? 1 : 0);
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "الخدمة الاستشارية",
                    style: isMobile
                        ? Constants.theme.textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                          )
                        : Constants.theme.textTheme.titleLarge?.copyWith(
                            color: Colors.black,
                          ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DropDown(
                    onChange: (value) {
                      onConsultationServiceChange(value);
                    },
                  ),
                ],
              ),
            ],
          ).setOnlyPadding(context, enableMediaQuery: false, 10, 0, 0, 0);
  }
}

class AxisWidget extends StatelessWidget {
  const AxisWidget({super.key, required this.isMobile, required this.axisName});
  final bool isMobile;
  final String axisName;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          axisName,
          style: isMobile
              ? Constants.theme.textTheme.titleLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                )
              : Constants.theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
        ).setHorizontalPadding(context, enableMediaQuery: false, 10),
        const SizedBox(height: 5),
        Container(
          height: 3,
          width: 140,
          color: Colors.black54,
        )
      ],
    );
  }
}





//isMobile
//                                       ? Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment
//                                         .spaceAround,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.stretch,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             " هل يحتاج إلى جلسة أخرى",
//                                             style: Constants
//                                                 .theme
//                                                 .textTheme
//                                                 .bodyMedium
//                                                 ?.copyWith(
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           Checkbox(
//                                             value:
//                                             (needOtherSession ==
//                                                 1),
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 needOtherSession =
//                                                 (value!)
//                                                     ? 1
//                                                     : 0;
//                                               });
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                       Column(
//                                         children: [
//                                           Text(
//                                             "الخدمة الاستشارية",
//                                             style: Constants
//                                                 .theme
//                                                 .textTheme
//                                                 .bodyMedium
//                                                 ?.copyWith(
//                                               color: Colors.black,
//                                             ),
//                                           ),
//                                           DropDown(
//                                             onChange: (value) {
//                                               setState(() {
//                                                 selected_consultation_service =
//                                                     value;
//                                               });
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   )
//                                       : Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text(
//                                             " هل يحتاج إلى جلسة أخرى",
//                                             style: isMobile?Constants.theme.textTheme.bodySmall?.copyWith(color: Colors.black,):Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.black,),
//                                           ),
//                                           Checkbox(
//                                             value:
//                                             (needOtherSession == 1),
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 needOtherSession =
//                                                 (value!) ? 1 : 0;
//                                               });
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             "الخدمة الاستشارية",
//                                             style: isMobile?Constants.theme.textTheme.bodySmall?.copyWith(color: Colors.black,):Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.black,),
//                                           ),
//                                           const SizedBox(
//                                             width: 10,
//                                           ),
//                                           DropDown(
//                                             onChange: (value) {
//                                               setState(() {
//                                                 selected_consultation_service =
//                                                     value;
//                                               });
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ).setOnlyPadding(context,enableMediaQuery: false, 10, 0, 0, 0),