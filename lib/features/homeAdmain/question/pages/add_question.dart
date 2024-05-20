import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/check_box_question.dart';
import 'package:experts_app/core/widget/drop_down_button.dart';
import 'package:experts_app/core/widget/radio_button.dart';
import 'package:experts_app/core/widget/tab_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/widget/custom_text_field.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  TextEditingController titleController = TextEditingController();
  TextEditingController answerController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List<TextEditingController> answerControllers = [];
  bool _showTextField = false;
  List<bool> _checkBoxValues = [];
  //List<TextEditingController> _checkBoxControllers = [];
  //List<String> _selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
        decoration: const BoxDecoration(
          color: Colors.white,
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
                mainAxisAlignment: MainAxisAlignment
                    .start, // Align children to the end (bottom) of the column
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " سؤال جديد",
                        style: Constants.theme.textTheme.titleLarge
                            ?.copyWith(color: Colors.black),
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      RadioWidget(
                        titleRadio: "اختر المحور",
                        item1: "المحور الاول",
                        item2: "المحور التاني",
                        item3: "المحور التالت",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: Constants.mediaQuery.width * 0.3,
                    child: CustomTextField(
                      controller: titleController,
                      hint: "ادخل عنوان سؤالك",
                      onValidate: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "من فضلك أدخل السؤال";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Constants.theme.primaryColor.withOpacity(0.5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "اضافة اجابة",
                              style: Constants.theme.textTheme.titleLarge
                                  ?.copyWith(color: Colors.black),
                            ),
                            const Icon(
                              Icons.add,
                              size: 30,
                              color: Colors.black,
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
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: List.generate(answerControllers.length, (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Constants.mediaQuery.width * 0.2,
                            child:
                            CustomTextField(
                              controller: answerControllers[index],
                              hint: "ادخل الاجابة",
                              onValidate: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "من فضلك أدخل الاجابة";
                                }
                                return null;
                              },
                            ).setOnlyPadding(context,enableMediaQuery: false, 0, 5, 0, 0),
                          ),
                          const SizedBox(width: 10,),
                          DropDownButton(
                            titleRadio: Text("نوع الأجابة",style: Constants.theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.black,
                            ),
                            ),
                            items: [
                              "اختيار واحد",
                              "متعدد الأختيارات",
                              "حقل نص",
                            ],
                          ),
                          DropDownButton(
                            titleRadio: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: SizedBox(
                                          height:
                                              Constants.mediaQuery.height * 0.6,
                                          width:
                                              Constants.mediaQuery.width * 0.45,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Constants
                                                        .theme.primaryColor,
                                                    width: 2.5,
                                                  ),
                                                ),
                                                child: Text(
                                                  "اختر من التوصيات",
                                                  style: Constants.theme
                                                      .textTheme.titleLarge
                                                      ?.copyWith(
                                                          color: Colors.black),
                                                ),
                                              ),
                                              CheckBoxQuestion(),
                                            ],
                                          )),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Constants
                                                      .theme.primaryColor,
                                                  width: 2.5,
                                                ),
                                              ),
                                              child: Text(
                                                "موافق",
                                                style: Constants
                                                    .theme.textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black),
                                              ).setHorizontalPadding(
                                                  context,
                                                  enableMediaQuery: false,
                                                  20)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text("التوصيات",style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,
                            ),
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
                                      title: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Constants
                                                .theme.primaryColor,
                                            width: 2.5,
                                          ),
                                        ),
                                        child: Text(
                                          "اختر من المؤشرات",
                                          style: Constants.theme
                                              .textTheme.titleLarge
                                              ?.copyWith(
                                              color: Colors.black),
                                        ),
                                      ),
                                      content: SizedBox(
                                        height:
                                            Constants.mediaQuery.height * 0.6,
                                        width:
                                            Constants.mediaQuery.width * 0.45,
                                        child: TabItemWidget(
                                          item3: "السيناريو التالت",
                                          item2: "السيناريو التاني",
                                          item1: "السيناريو الاول",
                                          firstWidget: CheckBoxQuestion(),
                                          secondWidget: CheckBoxQuestion(),
                                          thirdWidget: CheckBoxQuestion(),
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: Constants
                                                      .theme.primaryColor,
                                                  width: 2.5,
                                                ),
                                              ),
                                              child: Text(
                                                "موافق",
                                                style: Constants
                                                    .theme.textTheme.bodyMedium
                                                    ?.copyWith(
                                                        color: Colors.black),
                                              ).setHorizontalPadding(
                                                  context,
                                                  enableMediaQuery: false,
                                                  20)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text("المؤاشرات",style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.black,)
                            ),
                          ),
                          ),
                          Row(
                            children: [
                              Text(
                                " سؤال اجباري",
                                style: Constants.theme.textTheme.bodyMedium
                                    ?.copyWith(color: Colors.black),
                              ),
                              Checkbox(
                                value: _checkBoxValues.length > index
                                    ? _checkBoxValues[index]
                                    : false,
                                onChanged: (value) {
                                  setState(() {
                                    if (_checkBoxValues.length > index) {
                                      _checkBoxValues[index] = value!;
                                    }
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Constants.theme.primaryColor.withOpacity(0.5),
                    ),
                    child: Text(
                      "اضافة السؤال",
                      style: Constants.theme.textTheme.titleLarge
                          ?.copyWith(color: Colors.black),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Map<String, dynamic> requestData = {
                          "axis_id": 2,
                          "title": "الحالة الأجتماعية",
                          "question_options": [
                            {
                              "type": 0,
                              "required": 0,
                              "title": "متزوج ؟",
                              "advices": [1, 3],
                              "pointers": [1]
                            },
                            {
                              "type": 0,
                              "required": 0,
                              "title": "لديك أبناء ؟",
                              "advices": [1, 3],
                              "pointers": [1]
                            },
                            {
                              "type": 0,
                              "required": 0,
                              "title": "لديك منزل ؟",
                              "advices": [1, 3],
                              "pointers": [1]
                            }
                          ]
                        };
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: AlertDialog(
                                  title: Text(
                                    "تم اضافة السؤال",
                                    style: Constants.theme.textTheme.bodyMedium
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                              color: Constants.theme.primaryColor,
                                              width: 2.5,
                                            ),
                                          ),
                                          child: Text(
                                            "اغلاق",
                                            style: Constants
                                                .theme.textTheme.bodyMedium
                                                ?.copyWith(color: Colors.black),
                                          ).setHorizontalPadding(
                                              context,
                                              enableMediaQuery: false,
                                              20)),
                                    ),
                                  ],
                                ),
                              );
                            });
                      }
                    },
                  ),
                ]),
          )
              .setVerticalPadding(enableMediaQuery: false, context, 20)
              .setHorizontalPadding(context, enableMediaQuery: false, 10),
        ),
      ),
    ]
    );
  }

  void _toggleTextField() {
    setState(() {
      _showTextField = !_showTextField;
    });
  }

  void _addAnswer() {
    setState(() {
      answerControllers.add(TextEditingController());
      _checkBoxValues.add(false);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    answerController.dispose();
    answerControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }
}
