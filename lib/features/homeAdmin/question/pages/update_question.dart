

import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/question/widget/radio_answer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Services/snack_bar_service.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/widget/check_box_question.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/drop_down_button.dart';
import '../../../../core/widget/radio_button.dart';
import '../../../../core/widget/tab_item_widget.dart';
import '../../../../domain/entities/AdviceMode.dart';
import '../../../../domain/entities/QuestionModel.dart';

import '../manager/cubit.dart';
import '../manager/states.dart';

// ignore: must_be_immutable
class UpdateQuestion extends StatefulWidget {
  List<Questions> allQuestions ;
  Questions question ;
  UpdateQuestion({required this.question , required this.allQuestions});

  @override
  State<UpdateQuestion> createState() => _UpdateQuestionState( question :question , allQuestions: allQuestions);
}

class _UpdateQuestionState extends State<UpdateQuestion> {
  List<Questions> allQuestions ;
  Questions question ;
  _UpdateQuestionState({required this.question ,required this.allQuestions});

  TextEditingController titleController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<TextEditingController> answerControllers = [];
  bool _showTextField = false;

  List<Pointers> pointers1 = [];
  List<Pointers> pointers2 = [];
  List<Pointers> pointers3 = [];
  List<Advices> advices = [];
  dynamic questions ;

  List<bool> _checkBoxValues = [];
  List<int> _answerTypes = [];

  List<List<int>> selectedPointers1 = [];
  List<List<int>> selectedPointers2 = [];
  List<List<int>> selectedPointers3 = [];
  List<List<int>> selectedAdvices = [];
  List<List<int>> selectedQuestions = [];
  List<QuestionOptions> questionOptions = [];

  late int _selecetdAixs = 0;
  var addQuestionCubit = AddQuestionCubit();
  bool loaded = false ;
  bool isMobile = false;
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: question.title) ;
    fetchPointers();
    fetchAdvices();
    question.questionOptions?.forEach((option) {
      List<int> relatedList=[];
      option.reletedQuestions?.forEach((related) {
        relatedList.add(related.id!);
      });
      selectedQuestions.add(relatedList);
    });
    questionOptions = question.questionOptions ?? [];

    _addSpecificAnswers(question);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddQuestionCubit, AddQuestionStates>(
      bloc: addQuestionCubit,
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            isMobile = constraints.maxWidth < 600;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: double.maxFinite,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/back.jpg"),
                        fit: BoxFit.cover,
                        opacity: 0.4
                    )
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    automaticallyImplyLeading: true,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white,),

                    ),
                    title: Text("تعديل السؤال",
                      style: Constants.theme.textTheme.titleLarge,),
                    centerTitle: true,
                    backgroundColor: Constants.theme.primaryColor,

                  ),

                  body: ListView(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Form(
                              key: formKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: [
                                    isMobile?RadioWidget(
                              titleRadio: "اختر المحور",
                                items: const [
                                  MapEntry("اختر المحور", 0),
                                  MapEntry(
                                      "المحور الاول", 1),
                                  MapEntry(
                                      "المحور التاني", 2),
                                  MapEntry(
                                      "المحور الثالث",
                                      3)
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selecetdAixs = value!;
                                  });
                                },
                              ).setVerticalPadding(context, enableMediaQuery: false, 10):RadioWidget(
                                      titleRadio: "اختر المحور",
                                      items: const [
                                        MapEntry("اختر المحور", 0),
                                        MapEntry(
                                            "المحور الاول:بيانات الحالة", 1),
                                        MapEntry(
                                            "المحور التاني:التقييم المالي", 2),
                                        MapEntry(
                                            "المحور الثالث:السلوك الاستهلاكي",
                                            3)
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          _selecetdAixs = value!;
                                        });
                                      },
                                    ).setVerticalPadding(context, enableMediaQuery: false, 10),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    FadeInRight(
                                      delay: Duration(microseconds: 500),
                                      child: SizedBox(
                                        width: Constants.mediaQuery.width * 0.3,
                                        child: CustomTextField(
                                          fillColor: Colors.grey,
                                          controller: titleController,
                                          hint: "ادخل عنوان سؤالك",
                                          onValidate: (value) {
                                            if (value == null || value
                                                .trim()
                                                .isEmpty) {
                                              return "من فضلك أدخل السؤال";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10,),
                                    FadeInRight(
                                      delay: const Duration(microseconds: 900),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Constants.theme
                                                    .primaryColor.withOpacity(
                                                    0.8)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceEvenly,
                                              children: [
                                                Text(
                                                    "اضافة اجابة",
                                                    style: Constants.theme
                                                        .textTheme.bodyLarge
                                                ),
                                                const Icon(Icons.add, size: 30,
                                                  color: Colors.white,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _addAnswer();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25,),
                                    Column(
                                      children: List.generate(answerControllers.length, (index) {
                                        return FadeInRight(delay: const Duration(microseconds: 1300),
                                          child: isMobile?
                                          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Constants.mediaQuery.width * 4,
                                                child: CustomTextField(
                                                  fillColor: Colors.grey,
                                                  controller: answerControllers[index],
                                                  hint: "ادخل الاجابة",
                                                  onValidate: (value) {
                                                    if (value == null || value
                                                        .trim()
                                                        .isEmpty) {
                                                      return "من فضلك أدخل الاجابة";
                                                    }
                                                    return null;
                                                  },
                                                ).setOnlyPadding(context,
                                                    enableMediaQuery: false, 0,
                                                    5, 0, 0),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: RadioAnswerWidget (
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _answerTypes[index] =
                                                          value!;
                                                        });
                                                      },
                                                      titleRadio: "نوع الأجابة",
                                                      items: const [
                                                        MapEntry("اختيار واحد", 1),
                                                        MapEntry(
                                                            "متعدد الأختيارات", 2),
                                                        MapEntry("حقل نص", 3)
                                                      ],
                                                    ),
                                                  ),
                                                  DropDownButton(
                                                    titleRadio: GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              backgroundColor: Colors
                                                                  .black,
                                                              content: SizedBox(
                                                                  height: Constants
                                                                      .mediaQuery
                                                                      .height * 0.6,
                                                                  width: Constants
                                                                      .mediaQuery
                                                                      .width * 0.45,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment
                                                                        .stretch,
                                                                    children: [
                                                                      Container(
                                                                        alignment: Alignment
                                                                            .center,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius
                                                                              .circular(
                                                                              10),
                                                                          border: Border
                                                                              .all(
                                                                            color: Constants
                                                                                .theme
                                                                                .primaryColor,
                                                                            width: 2.5,
                                                                          ),
                                                                        ),
                                                                        child: Text(
                                                                            "اختر من التوصيات",
                                                                            style: Constants
                                                                                .theme
                                                                                .textTheme
                                                                                .titleLarge
                                                                        ),
                                                                      ),
                                                                      CheckBoxQuestion(
                                                                        previous: selectedAdvices[index],
                                                                        items: advices,
                                                                        onChanged: (
                                                                            value) {
                                                                          setState(() {
                                                                            selectedAdvices[index] =
                                                                            value!;
                                                                          });
                                                                        },
                                                                      ),
                                                                    ],
                                                                  )),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius
                                                                            .circular(
                                                                            10),
                                                                        border: Border
                                                                            .all(
                                                                          color: Constants
                                                                              .theme
                                                                              .primaryColor,
                                                                          width: 2.5,),
                                                                      ),
                                                                      child: Text(
                                                                          "موافق",
                                                                          style: Constants
                                                                              .theme
                                                                              .textTheme
                                                                              .bodyMedium
                                                                      )
                                                                          .setHorizontalPadding(
                                                                          context,
                                                                          enableMediaQuery: false,
                                                                          20)),
                                                                ),
                                                              ],);
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        "التوصيات", style: isMobile?Constants.theme.textTheme.bodySmall:Constants.theme.textTheme.bodyMedium,
                                                      ),
                                                    ),
                                                  ),
                                                  DropDownButton(
                                                    titleRadio: GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                              backgroundColor: Colors
                                                                  .black,
                                                              title: Container(
                                                                alignment: Alignment
                                                                    .center,
                                                                decoration: BoxDecoration(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(10),
                                                                  border: Border
                                                                      .all(
                                                                    color: Constants
                                                                        .theme
                                                                        .primaryColor,
                                                                    width: 2.5,
                                                                  ),
                                                                ),
                                                                child: Text(
                                                                    "اختر من المؤشرات",
                                                                    style: Constants
                                                                        .theme
                                                                        .textTheme
                                                                        .titleLarge
                                                                ),
                                                              ),
                                                              content: SizedBox(
                                                                height: Constants.mediaQuery.height * 0.5,
                                                                width: Constants
                                                                    .mediaQuery
                                                                    .width * 0.45,
                                                                child: TabItemWidget(
                                                                  item1: "السيناريو الاول",
                                                                  item2: "السيناريو التاني",
                                                                  item3: "السيناريو التالت",
                                                                  firstWidget: CheckBoxQuestion(
                                                                    items: pointers1,
                                                                    previous: selectedPointers1[index],
                                                                    onChanged: (
                                                                        value) {
                                                                      setState(() {
                                                                        selectedPointers1[index] =
                                                                        value!;
                                                                      });
                                                                    },
                                                                  ),
                                                                  secondWidget: CheckBoxQuestion(
                                                                    previous: selectedPointers2[index],
                                                                    items: pointers2,
                                                                    onChanged: (
                                                                        value) {
                                                                      selectedPointers2[index] =
                                                                      value!;
                                                                    },
                                                                  ),
                                                                  thirdWidget: CheckBoxQuestion(
                                                                    previous: selectedPointers3[index],
                                                                    items: pointers3,
                                                                    onChanged: (
                                                                        value) {
                                                                      selectedPointers3[index] =
                                                                      value!;
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed: () {
                                                                    Navigator.of(
                                                                        context)
                                                                        .pop();
                                                                  },
                                                                  child: Container(
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                            10),
                                                                        border: Border
                                                                            .all(
                                                                          color: Constants
                                                                              .theme
                                                                              .primaryColor,
                                                                          width: 2.5,
                                                                        ),
                                                                      ),
                                                                      child: Text(
                                                                          "موافق",
                                                                          style: Constants
                                                                              .theme
                                                                              .textTheme
                                                                              .bodyMedium
                                                                      )
                                                                          .setHorizontalPadding(
                                                                          context,
                                                                          enableMediaQuery: false,
                                                                          20)),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Text("المؤاشرات",
                                                          style: isMobile?Constants.theme.textTheme.bodySmall:Constants.theme.textTheme.bodyMedium),
                                                    ),
                                                  ),
                                                  // question.isRelatedQuestion==1?Container():
                                                  // DropDownButton(
                                                  //   titleRadio: GestureDetector(
                                                  //     onTap: () {
                                                  //       showDialog(
                                                  //         context: context,
                                                  //         builder: (context) {
                                                  //           return AlertDialog(
                                                  //             backgroundColor: Colors
                                                  //                 .black,
                                                  //             content: SizedBox(
                                                  //                 height: Constants
                                                  //                     .mediaQuery
                                                  //                     .height * 0.6,
                                                  //                 width: Constants
                                                  //                     .mediaQuery
                                                  //                     .width * 0.45,
                                                  //                 child: Column(
                                                  //                   crossAxisAlignment: CrossAxisAlignment
                                                  //                       .stretch,
                                                  //                   children: [
                                                  //                     Container(
                                                  //                       alignment: Alignment
                                                  //                           .center,
                                                  //                       decoration: BoxDecoration(
                                                  //                         borderRadius: BorderRadius
                                                  //                             .circular(
                                                  //                             10),
                                                  //                         border: Border
                                                  //                             .all(
                                                  //                           color: Constants
                                                  //                               .theme
                                                  //                               .primaryColor,
                                                  //                           width: 2.5,
                                                  //                         ),
                                                  //                       ),
                                                  //                       child: Text(
                                                  //                           "اختر من الاسئلة",
                                                  //                           style: isMobile?Constants.theme.textTheme.bodySmall:Constants.theme.textTheme.bodyMedium
                                                  //                       ),
                                                  //                     ),
                                                  //                     CheckBoxQuestion(
                                                  //                       previous: selectedQuestions[index],
                                                  //                       items: allQuestions,
                                                  //                       onChanged: (
                                                  //                           value) {
                                                  //                         setState(() {
                                                  //                           selectedQuestions[index] =
                                                  //                           value!;
                                                  //                         });
                                                  //                       },
                                                  //                     ),
                                                  //                   ],
                                                  //                 )),
                                                  //             actions: [
                                                  //               TextButton(
                                                  //                 onPressed: () {
                                                  //                   Navigator.of(
                                                  //                       context)
                                                  //                       .pop();
                                                  //                 },
                                                  //                 child: Container(
                                                  //                     decoration: BoxDecoration(
                                                  //                       borderRadius: BorderRadius
                                                  //                           .circular(
                                                  //                           10),
                                                  //                       border: Border
                                                  //                           .all(
                                                  //                         color: Constants
                                                  //                             .theme
                                                  //                             .primaryColor,
                                                  //                         width: 2.5,),
                                                  //                     ),
                                                  //                     child: Text(
                                                  //                         "موافق",
                                                  //                         style: Constants
                                                  //                             .theme
                                                  //                             .textTheme
                                                  //                             .bodyMedium
                                                  //                     )
                                                  //                         .setHorizontalPadding(
                                                  //                         context,
                                                  //                         enableMediaQuery: false,
                                                  //                         20)),
                                                  //               ),
                                                  //             ],);
                                                  //         },
                                                  //       );
                                                  //     },
                                                  //     child: Text("الاسئلة",
                                                  //       style: isMobile?Constants.theme.textTheme.bodySmall:Constants.theme.textTheme.bodyMedium
                                                  //           ,),
                                                  //   ),
                                                  // ),

                                                  IconButton(
                                                    icon: Icon(Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      setState(() {
                                                        _deleteAnswer(index);
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ):
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Constants.mediaQuery
                                                    .width * 0.2,
                                                child: CustomTextField(
                                                  fillColor: Colors.grey,
                                                  controller: answerControllers[index],
                                                  hint: "ادخل الاجابة",
                                                  onValidate: (value) {
                                                    if (value == null || value
                                                        .trim()
                                                        .isEmpty) {
                                                      return "من فضلك أدخل الاجابة";
                                                    }
                                                    return null;
                                                  },
                                                ).setOnlyPadding(context,
                                                    enableMediaQuery: false, 0,
                                                    5, 0, 0),
                                              ),
                                              RadioAnswerWidget(
                                                onChanged: (value) {
                                                  setState(() {
                                                    _answerTypes[index] =
                                                    value!;
                                                  });
                                                },
                                                titleRadio: "نوع الأجابة",
                                                items: const [
                                                  MapEntry("اختيار واحد", 1),
                                                  MapEntry(
                                                      "متعدد الأختيارات", 2),
                                                  MapEntry("حقل نص", 3)
                                                ],
                                              ),
                                              DropDownButton(
                                                titleRadio: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor: Colors
                                                              .black,
                                                          content: SizedBox(
                                                              height: Constants
                                                                  .mediaQuery
                                                                  .height * 0.6,
                                                              width: Constants
                                                                  .mediaQuery
                                                                  .width * 0.45,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .stretch,
                                                                children: [
                                                                  Container(
                                                                    alignment: Alignment
                                                                        .center,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          10),
                                                                      border: Border
                                                                          .all(
                                                                        color: Constants
                                                                            .theme
                                                                            .primaryColor,
                                                                        width: 2.5,
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                        "اختر من التوصيات",
                                                                        style: Constants
                                                                            .theme
                                                                            .textTheme
                                                                            .titleLarge
                                                                    ),
                                                                  ),
                                                                  CheckBoxQuestion(
                                                                    previous: selectedAdvices[index],
                                                                    items: advices,
                                                                    onChanged: (
                                                                        value) {
                                                                      setState(() {
                                                                        selectedAdvices[index] =
                                                                        value!;
                                                                      });
                                                                    },
                                                                  ),
                                                                ],
                                                              )),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        10),
                                                                    border: Border
                                                                        .all(
                                                                      color: Constants
                                                                          .theme
                                                                          .primaryColor,
                                                                      width: 2.5,),
                                                                  ),
                                                                  child: Text(
                                                                      "موافق",
                                                                      style: Constants
                                                                          .theme
                                                                          .textTheme
                                                                          .bodyMedium
                                                                  )
                                                                      .setHorizontalPadding(
                                                                      context,
                                                                      enableMediaQuery: false,
                                                                      20)),
                                                            ),
                                                          ],);
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    "التوصيات", style: isMobile?Constants.theme.textTheme.bodySmall:Constants.theme.textTheme.bodyMedium,
                                                  ),
                                                ),
                                              ),
                                              DropDownButton(
                                                titleRadio: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor: Colors
                                                              .black,
                                                          title: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                              border: Border
                                                                  .all(
                                                                color: Constants
                                                                    .theme
                                                                    .primaryColor,
                                                                width: 2.5,
                                                              ),
                                                            ),
                                                            child: Text(
                                                                "اختر من المؤشرات",
                                                                style: Constants
                                                                    .theme
                                                                    .textTheme
                                                                    .titleLarge
                                                            ),
                                                          ),
                                                          content: SizedBox(
                                                            height: Constants
                                                                .mediaQuery
                                                                .height * 0.6,
                                                            width: Constants
                                                                .mediaQuery
                                                                .width * 0.45,
                                                            child: TabItemWidget(
                                                              item1: "السيناريو الاول",
                                                              item2: "السيناريو التاني",
                                                              item3: "السيناريو التالت",
                                                              firstWidget: CheckBoxQuestion(
                                                                items: pointers1,
                                                                previous: selectedPointers1[index],
                                                                onChanged: (
                                                                    value) {
                                                                  setState(() {
                                                                    selectedPointers1[index] =
                                                                    value!;
                                                                  });
                                                                },
                                                              ),
                                                              secondWidget: CheckBoxQuestion(
                                                                previous: selectedPointers2[index],
                                                                items: pointers2,
                                                                onChanged: (
                                                                    value) {
                                                                  selectedPointers2[index] =
                                                                  value!;
                                                                },
                                                              ),
                                                              thirdWidget: CheckBoxQuestion(
                                                                previous: selectedPointers3[index],
                                                                items: pointers3,
                                                                onChanged: (
                                                                    value) {
                                                                  selectedPointers3[index] =
                                                                  value!;
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        10),
                                                                    border: Border
                                                                        .all(
                                                                      color: Constants
                                                                          .theme
                                                                          .primaryColor,
                                                                      width: 2.5,
                                                                    ),
                                                                  ),
                                                                  child: Text(
                                                                      "موافق",
                                                                      style: Constants
                                                                          .theme
                                                                          .textTheme
                                                                          .bodyMedium
                                                                  )
                                                                      .setHorizontalPadding(
                                                                      context,
                                                                      enableMediaQuery: false,
                                                                      20)),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text("المؤاشرات",
                                                      style: isMobile?Constants.theme.textTheme.bodySmall:Constants.theme.textTheme.bodyMedium),
                                                ),
                                              ),
                                              // question.isRelatedQuestion==1?Container():
                                              DropDownButton(
                                                titleRadio: GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          backgroundColor: Colors
                                                              .black,
                                                          content: SizedBox(
                                                              height: Constants
                                                                  .mediaQuery
                                                                  .height * 0.6,
                                                              width: Constants
                                                                  .mediaQuery
                                                                  .width * 0.45,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment
                                                                    .stretch,
                                                                children: [
                                                                  Container(
                                                                    alignment: Alignment
                                                                        .center,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius
                                                                          .circular(
                                                                          10),
                                                                      border: Border
                                                                          .all(
                                                                        color: Constants
                                                                            .theme
                                                                            .primaryColor,
                                                                        width: 2.5,
                                                                      ),
                                                                    ),
                                                                    child: Text(
                                                                        "اختر من الاسئلة",
                                                                        style: isMobile?Constants.theme.textTheme.bodySmall:Constants.theme.textTheme.bodyMedium
                                                                    ),
                                                                  ),
                                                                  CheckBoxQuestion(
                                                                    previous: selectedQuestions[index],
                                                                    items: allQuestions,
                                                                    onChanged: (
                                                                        value) {
                                                                      setState(() {
                                                                        selectedQuestions[index] =
                                                                        value!;
                                                                      });
                                                                    },
                                                                  ),
                                                                ],
                                                              )),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                    context)
                                                                    .pop();
                                                              },
                                                              child: Container(
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .circular(
                                                                        10),
                                                                    border: Border
                                                                        .all(
                                                                      color: Constants
                                                                          .theme
                                                                          .primaryColor,
                                                                      width: 2.5,),
                                                                  ),
                                                                  child: Text(
                                                                      "موافق",
                                                                      style: Constants
                                                                          .theme
                                                                          .textTheme
                                                                          .bodyMedium
                                                                  )
                                                                      .setHorizontalPadding(
                                                                      context,
                                                                      enableMediaQuery: false,
                                                                      20)),
                                                            ),
                                                          ],);
                                                      },
                                                    );
                                                  },
                                                  child: Text("الاسئلة",
                                                    style: Constants.theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color: Colors.white,),),
                                                ),
                                              ),

                                              IconButton(
                                                icon: Icon(Icons.delete,
                                                    color: Colors.red),
                                                onPressed: () {
                                                  setState(() {
                                                    _deleteAnswer(index);
                                                  });
                                                },
                                              ),
                                            ],
                                          ).setVerticalPadding(context,enableMediaQuery: false ,10),
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 25,),
                                    FadeInRight(
                                      delay: Duration(microseconds: 1700),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Constants.theme
                                                .primaryColor.withOpacity(0.8)),
                                        onPressed: () {
                                          if (_selecetdAixs == 0) {
                                            SnackBarService.showErrorMessage(
                                                "من فضلك اختر المحور");
                                          } else if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            if (_isFormValid()) {
                                              updateQuestion(context);
                                            } else {
                                              _showValidationError();
                                            }
                                            setState(() {});
                                          }
                                        },
                                        child: Text(
                                          "حفظ التعديل",
                                          style: Constants.theme.textTheme
                                              .bodyLarge
                                              ?.copyWith(color: Colors.white,),
                                        ),

                                      ),
                                    ),
                                  ]
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            );
          });
      },
    );
  }

  void _deleteAnswer(int index) {
    // question.questionOptions?.removeAt(index);
    answerControllers.removeAt(index);
    _answerTypes.removeAt(index);
    selectedAdvices.removeAt(index);
    selectedPointers1.removeAt(index);
    selectedPointers2.removeAt(index);
    selectedPointers3.removeAt(index);
    selectedQuestions.removeAt(index);
    _checkBoxValues.removeAt(index);
  }
  // void _addAnswer() {
  //   setState(() {
  //     questionOptions.add(QuestionOptions(
  //       title: "جيد",
  //       type: 1,
  //       advices: [],
  //       pointers: [],
  //       questionId: widget.question.id,
  //     ));
  //     answerControllers.add(TextEditingController());
  //     _answerTypes.add(1);
  //     selectedAdvices.add([]);
  //     selectedPointers1.add([]);
  //     selectedPointers2.add([]);
  //     selectedPointers3.add([]);
  //     selectedQuestions.add([]);
  //     _checkBoxValues.add(false);
  //
  //   });
  //
  // }
  // void _addSpecificAnswers(Questions question) {
  //   question.questionOptions?.forEach((element) {
  //     _answerTypes.add(element.type!);
  //     List<int> selectedAdvices1IDs = [];
  //     element.advices?.forEach((advice) {
  //       selectedAdvices1IDs.add(advice.id);
  //     });
  //     selectedAdvices.add(selectedAdvices1IDs);
  //     List<int> selectedPointers1IDs = [];
  //     List<int> selectedPointers2IDs = [];
  //     List<int> selectedPointers3IDs = [];
  //     element.pointers?.forEach((pointer) {
  //       if (pointer.senarioId == 1)
  //         selectedPointers1IDs.add(pointer.id!);
  //       if (pointer.senarioId == 2)
  //         selectedPointers2IDs.add(pointer.id!);
  //       if (pointer.senarioId == 3)
  //         selectedPointers3IDs.add(pointer.id!);
  //     });
  //     selectedPointers1.add(selectedPointers1IDs);
  //     selectedPointers2.add(selectedPointers2IDs);
  //     selectedPointers3.add(selectedPointers3IDs);
  //     answerControllers.add(TextEditingController(text: element.title));
  //     _checkBoxValues.add(false);
  //   });
  // }
  void _addAnswer() {
    setState(() {
      questionOptions.add(QuestionOptions());
      answerControllers.add(TextEditingController());
      _answerTypes.add(1);
      selectedAdvices.add([]);
      selectedPointers1.add([]);
      selectedPointers2.add([]);
      selectedPointers3.add([]);
      selectedQuestions.add([]);
      _checkBoxValues.add(false);
    });
  }
  void _addSpecificAnswers(Questions question) {
    question.questionOptions?.forEach((element) {
      _answerTypes.add(element.type!);
      List<int> selectedAdvices1IDs = [];
      element.advices?.forEach((advice) {
        selectedAdvices1IDs.add(advice.id);
      });
      selectedAdvices.add(selectedAdvices1IDs);

      List<int> selectedPointers1IDs = [];
      List<int> selectedPointers2IDs = [];
      List<int> selectedPointers3IDs = [];
      element.pointers?.forEach((pointer) {
        if (pointer.senarioId == 1)
          selectedPointers1IDs.add(pointer.id!);
        if (pointer.senarioId == 2)
          selectedPointers2IDs.add(pointer.id!);
        if (pointer.senarioId == 3)
          selectedPointers3IDs.add(pointer.id!);
      });
      selectedPointers1.add(selectedPointers1IDs);
      selectedPointers2.add(selectedPointers2IDs);
      selectedPointers3.add(selectedPointers3IDs);

      answerControllers.add(TextEditingController(text: element.title));
      _checkBoxValues.add(false);
    });

    for (int i = questionOptions.length; i < answerControllers.length; i++) {
      _answerTypes.add(1); // Default type
      selectedAdvices.add([]);
      selectedPointers1.add([]);
      selectedPointers2.add([]);
      selectedPointers3.add([]);
      selectedQuestions.add([]);
      _checkBoxValues.add(false);
    }
  }

  void _clearAnswer() {
    titleController.clear();
    answerControllers.clear();
    _answerTypes.clear();
    selectedAdvices.clear();
    selectedPointers1.clear();
    selectedPointers2.clear();
    selectedPointers3.clear();
    selectedQuestions.clear();
    _checkBoxValues.clear();

  }

  bool _isFormValid() {
    bool isValid = formKey.currentState!.validate();
    bool hasAnswer =
    answerControllers.any((controller) => controller.text.isNotEmpty);
    return isValid && hasAnswer;
  }

  void _showValidationError() {
    SnackBarService.showErrorMessage("يرجي اضافة اجابة واحدة علي الأقل");
  }

  void updateQuestion(BuildContext context) {
    print("++++++++++++++++++++"+answerControllers.length.toString());
    for (int i = 0; i < answerControllers.length; i++) {
      print("Option : "+question.questionOptions![i].id.toString());
    }
    print("-----------------"+question.questionOptions!.length.toString());
    // ++++++++++++++++++++4
    // Option : 198
    // Option : 199
    // Option : 200
    // Option : null
    // -----------------4
    if (_isFormValid()) {
      Map<String, dynamic> requestData = {
        "id": question.id ,
        "axis_id": _selecetdAixs,
        "title": titleController.text,
        "question_options":   [
          for (int i = 0; i < answerControllers.length ; i++)
            {
              "id":  question.questionOptions![i].id,
              //"id": questionOptions[i].id,  ////
              "type": _answerTypes[i],
              "required": _checkBoxValues[i],
              "title": answerControllers[i].text,
              "advices": selectedAdvices[i],
              "pointers": selectedPointers1[i] + selectedPointers2[i] + selectedPointers3[i],
              "releted_questions_id": selectedQuestions[i]
            }
        ]
      };
      addQuestionCubit.updateQuestion(requestData).then((value) {
        if(value!=null) {
          Navigator.pop(context);
          SnackBarService.showSuccessMessage("تم تعديل السؤال");
        }
      });

    }
  }
  // void updateQuestion(BuildContext context) {
  //   if (_isFormValid()) {
  //     Map<String, dynamic> requestData = {
  //       "id": question.id,
  //       "axis_id": _selecetdAixs,
  //       "title": titleController.text,
  //       "question_options": [
  //         for (int i = 0; i < answerControllers.length; i++)
  //           {
  //             "id": questionOptions[i].id ?? "", // Include the ID if it exists
  //             "type": _answerTypes[i],
  //             "required": _checkBoxValues[i],
  //             "title": answerControllers[i].text,
  //             "advices": selectedAdvices[i],
  //             "pointers": selectedPointers1[i] + selectedPointers2[i] + selectedPointers3[i],
  //             "releted_questions_id": selectedQuestions[i],
  //           }
  //       ]
  //     };
  //     addQuestionCubit.updateQuestion(requestData).then((value) {
  //       if (value != null) {
  //         Navigator.pop(context);
  //         SnackBarService.showSuccessMessage("تم تعديل السؤال");
  //       }
  //     });
  //   }
  // }




  void _toggleTextField() {
    setState(() {
      _showTextField = !_showTextField;
    });
  }


  @override
  void dispose() {
    titleController.dispose();
    answerControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  Future<void> fetchPointers() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/api/pointer',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["pointers"];
        List<Pointers> pointers = [];
        List<Pointers> pointers1Temp = [];
        List<Pointers> pointers2Temp = [];
        List<Pointers> pointers3Temp = [];

        pointers = data.map((json) => Pointers.fromJson(json)).toList();
        pointers.forEach(
              (pointer) {
            if (pointer.senarioId == 1) {
              pointers1Temp.add(pointer);
            } else if (pointer.senarioId == 2) {
              pointers2Temp.add(pointer);
            } else if (pointer.senarioId == 3) {
              pointers3Temp.add(pointer);
            }
          },
        );
        setState(() {
          pointers1 = pointers1Temp;
          pointers2 = pointers2Temp;
          pointers3 = pointers3Temp;
        });
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> fetchAdvices() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/api/advice',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["advices"];
        print(data);
        List<Advices> advicesdata = [];
        advicesdata = data.map((json) => Advices.fromJson(json)).toList();
        setState(() {
          advices = advicesdata;
        });
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

}




