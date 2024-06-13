import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/features/homeAdmin/question/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/question/manager/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/cash_helper.dart';
import 'package:experts_app/core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import 'package:experts_app/core/widget/radio_button.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/tab_item_widget.dart';
import 'package:experts_app/domain/entities/pointerModel.dart';
import 'package:experts_app/core/widget/drop_down_button.dart';
import 'package:experts_app/core/widget/check_box_question.dart';

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

  List<Pointers> pointers1 = [];
  List<Pointers> pointers2 = [];
  List<Pointers> pointers3 = [];
  List<Advices> advices = [];

  List<bool> _checkBoxValues = [];
  List<int> _answerTypes = [];

  List<List<int>> selectedPointers1 = [];
  List<List<int>> selectedPointers2 = [];
  List<List<int>> selectedPointers3 = [];
  List<List<int>> selectedAdvices = [];

  late int _selecetdAixs = 0;
  var addQuestionCubit = AddQuestionCubit();

  @override
  void initState() {
    super.initState();
    fetchPointers();
    fetchAdvices();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddQuestionCubit, AddQuestionStates>(
      bloc: addQuestionCubit,
      builder: (context, state) {
        return Container(
          height: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.jpg"),
                      fit: BoxFit.cover,
                      opacity: 1.0
                  )
              ),
          child: ListView(children: [
            Container(
              decoration: const BoxDecoration(
                // color: Colors.white,
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
                        FadeInRight(
                          delay: Duration(microseconds: 100),
                          child: Row(
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
                                items: const [
                                  MapEntry("اختر المحور", 0),
                                  MapEntry("المحور الاول", 1),
                                  MapEntry("المحور التاني", 2),
                                  MapEntry("المحور الثالث", 3)
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _selecetdAixs = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
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
                                if (value == null || value.trim().isEmpty) {
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Constants.theme.primaryColor.withOpacity(0.8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "اضافة اجابة",
                                      style: Constants.theme.textTheme.bodyLarge
                                    ),
                                    const Icon(Icons.add, size: 30, color: Colors.white,
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
                            return FadeInRight(
                              delay: const Duration(microseconds: 1300),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Constants.mediaQuery.width * 0.2,
                                    child: CustomTextField(
                                      controller: answerControllers[index],
                                      hint: "ادخل الاجابة",
                                      onValidate: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "من فضلك أدخل الاجابة";
                                        }
                                        return null;
                                      },
                                    ).setOnlyPadding(context, enableMediaQuery: false, 0, 5, 0, 0),
                                  ),

                                  RadioWidget(
                                    onChanged: (value) {
                                      setState(() {
                                        _answerTypes[index] = value!;
                                      });
                                    },
                                    titleRadio: "نوع الأجابة",
                                    items: const [
                                      MapEntry("اختيار واحد", 1),
                                      MapEntry("متعدد الأختيارات", 2),
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
                                              backgroundColor: Colors.black,
                                              content: SizedBox(height: Constants.mediaQuery.height * 0.6,
                                                  width: Constants.mediaQuery.width * 0.45,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      Container(
                                                        alignment: Alignment.center,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          border: Border.all(color: Constants.theme.primaryColor, width: 2.5,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          "اختر من التوصيات",
                                                          style: Constants.theme.textTheme.titleLarge
                                                        ),
                                                      ),
                                                      CheckBoxQuestion(
                                                        previous: selectedAdvices[index],
                                                        items: advices,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedAdvices[index] = value!;
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  )),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Constants.theme.primaryColor, width: 2.5,),
                                                      ),
                                                      child: Text(
                                                        "موافق", style: Constants.theme.textTheme.bodyMedium
                                                      ).setHorizontalPadding(context, enableMediaQuery: false, 20)),
                                                ),],);},
                                        );
                                      },
                                      child: Text(
                                        "التوصيات", style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.white,
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
                                              backgroundColor: Colors.black,
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
                                                  "اختر من المؤشرات", style: Constants.theme.textTheme.titleLarge
                                                ),
                                              ),
                                              content: SizedBox(height: Constants.mediaQuery.height * 0.6,
                                                width: Constants.mediaQuery.width * 0.45,
                                                child: TabItemWidget(
                                                  item1: "السيناريو الاول",
                                                  item2: "السيناريو التاني",
                                                  item3: "السيناريو التالت",
                                                  firstWidget: CheckBoxQuestion(
                                                    items: pointers1,
                                                    previous: selectedPointers1[index],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        selectedPointers1[index] =
                                                            value!;
                                                      });
                                                    },
                                                  ),
                                                  secondWidget: CheckBoxQuestion(
                                                    previous: selectedPointers2[index],
                                                    items: pointers2,
                                                    onChanged: (value) {selectedPointers2[index] = value!;
                                                    },
                                                  ),
                                                  thirdWidget: CheckBoxQuestion(
                                                    previous: selectedPointers3[index],
                                                    items: pointers3,
                                                    onChanged: (value) {
                                                      selectedPointers3[index] =
                                                          value!;
                                                    },
                                                  ),
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
                                                            BorderRadius.circular(
                                                                10),
                                                        border: Border.all(
                                                          color: Constants
                                                              .theme.primaryColor,
                                                          width: 2.5,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "موافق",
                                                        style: Constants.theme
                                                            .textTheme.bodyMedium
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
                                      child: Text("المؤاشرات",
                                          style: Constants
                                              .theme.textTheme.bodyMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                          )),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        " سؤال اجباري",
                                        style: Constants
                                            .theme.textTheme.bodyMedium
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
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInRight(
                          delay: Duration(microseconds: 1700),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Constants.theme.primaryColor
                                    .withOpacity(0.8)),
                            child: Text(
                              "اضافة السؤال",
                              style: Constants.theme.textTheme.bodyLarge
                                  ?.copyWith(color: Colors.white,),
                            ),
                            onPressed: () {
                              if (_selecetdAixs == 0) {
                                SnackBarService.showErrorMessage(
                                    "من فضلك اختر المحور");
                              } else if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (_isFormValid()) {
                                  storeQuestion(context);
                                } else {
                                  _showValidationError();
                                }
                                setState(() {});
                              }
                            },
                          ),
                        ),
                      ]),
                )
                    .setVerticalPadding(enableMediaQuery: false, context, 20)
                    .setHorizontalPadding(context, enableMediaQuery: false, 10),
              ),
            ),
          ]),
        );
      },
    );
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

  void storeQuestion(BuildContext context) {
    if (_isFormValid()) {
      Map<String, dynamic> requestData = {
        "axis_id": _selecetdAixs,
        "title": titleController.text,
        "question_options": [
          for (int i = 0; i < answerControllers.length; i++)
            {
              "type": _answerTypes[i],
              "required": _checkBoxValues[i],
              "title": answerControllers[i].text,
              "advices": selectedAdvices[i],
              "pointers": selectedPointers1[i] +
                  selectedPointers2[i] +
                  selectedPointers3[i]
            }
        ]
      };
      addQuestionCubit.addQuestion(requestData);
      showDialog(
          context: context,
          builder: (context) {
            return Directionality(
              textDirection: TextDirection.rtl,
              child:
              AlertDialog(
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
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Constants.theme.primaryColor,
                            width: 2.5,
                          ),
                        ),
                        child: Text(
                          "اغلاق",
                          style: Constants.theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.black),
                        ).setHorizontalPadding(
                            context, enableMediaQuery: false, 20)),
                  ),
                ],
              ),
            );
          });
    }
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
      _answerTypes.add(1);
      selectedPointers1.add([]);
      selectedPointers2.add([]);
      selectedPointers3.add([]);
      selectedAdvices.add([]);
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    answerController.dispose();
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




