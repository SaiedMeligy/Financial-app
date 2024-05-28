import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/core/widget/border_rounded_button.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/widget/drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/constants.dart';
import '../../../../core/widget/custom_text_field.dart';
import '../../../../core/widget/Question_text_field.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/states.dart';

class ViewQuestion extends StatefulWidget {
  ViewQuestion({super.key , required this.pationt_data});
  List<int> axis = [];
  dynamic pationt_data;
  @override
  State<ViewQuestion> createState() => _ViewQuestionState();
}

class _ViewQuestionState extends State<ViewQuestion> {
  var questionViewCubit = QuestionViewCubit();
  List<ConsultationServices> menuItem = [];
  List<bool> _checkBoxValues = [];
  List<Map<dynamic, dynamic>> answers = [];
  int needOtherSession=0 ;
  late int selected_consultation_service;
  @override
  void initState() {
    super.initState();

    questionViewCubit.getAllQuestion();
  }

  Widget build(BuildContext context) {
    print(widget.pationt_data);

    return BlocBuilder<QuestionViewCubit, QuestionViewStates>(
      bloc: questionViewCubit,
      builder: (context, state) {
        if (state is LoadingQuestionViewState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessQuestionViewState) {
          var question = state.question;
          List<int> axisDisplay = [];
          question.forEach((q) {
            if (!axisDisplay.contains(q.axisId)) {
              axisDisplay.add(q.axisId!);
            } else {
              axisDisplay.add(0);
            }
          });

          Map<dynamic, dynamic> answer = {};
          for( int index = 0 ;  index < question.length ; index++) {
            for (int i = 0; i < question[index].questionOptions!.length; i++) {
              if (question[index].questionOptions![i].type == 1) {
                answer.addAll({
                  "RADIO_BUTTON": -1,
                });
              }
              else if (question[index].questionOptions![i].type == 2) {
                answer.addAll({
                  question[index].questionOptions![i].id : false,
                });
              } else {
                answer.addAll({
                  question[index].questionOptions![i].id: TextEditingController(text: ""),
                });
              }
            }
            answers.add(answer);
          }

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: true,
                backgroundColor: Colors.black87,
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg',),
                    fit: BoxFit.cover,
                    opacity: 0.5
                  )
                ),
                child: Row(
                  children: [
                    Container(
                      height: double.maxFinite,
                      width: Constants.mediaQuery.width*0.2,
                      color: Colors.black,
                      child: Column(
                        children: [
                          Text(widget.pationt_data['pationt']['name'],style: Constants.theme.textTheme.bodyMedium,),
                          Text(CacheHelper.getData(key: 'name'),style: Constants.theme.textTheme.bodyMedium,),
                          Text("الرقم القومي",style: Constants.theme.textTheme.bodyMedium,),
                          Text(
                            "${DateTime.now().minute.toString()} : ${DateTime.now().hour.toString()}",style: Constants.theme.textTheme.bodyMedium,),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                height: double.maxFinite,
                                child: ListView.builder(
                                    itemCount: question.length + 1,
                                    itemBuilder: (context, index) {

                                      return Column(
                                        children: [
                                          if (question.length != index) ...[
                                            if (axisDisplay[index] != 0)
                                              Column(
                                                children: [
                                                  Text(
                                                    question[index].axis!.name.toString(),
                                                    style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  Container(
                                                    height: 3,
                                                    width:140,
                                                    color: Colors.black54,
                                                  )
                                                ],
                                              ),
                                            SizedBox(height:10),
                                            Container(
                                              width: double.infinity,
                                              child: CustomPaint(
                                                  foregroundPainter: LinePainter(
                                                    text: question[index].title.toString(),
                                                  ),
                                                  child: Container(
                                                    width: Constants.mediaQuery.width * 0.2,
                                                    height: question[index].questionOptions!.length > 2
                                                        ? question[index].questionOptions!.length * 100
                                                        : 200,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(
                                                          color: Colors.black87,
                                                          width: 2.5,
                                                        )),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        for (int i = 0; i < question[index].questionOptions!.length; i++) ...[
                                                          Container(
                                                            width: Constants.mediaQuery.width * 0.4,
                                                            height: Constants.mediaQuery.height * 0.1,
                                                            margin: EdgeInsets.all(8),
                                                            decoration: BoxDecoration(
                                                                color: Colors.white54,
                                                                borderRadius: BorderRadius.circular(10),
                                                                border:question[index].questionOptions![i].type != 3
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
                                                                Text(
                                                                    question[index].questionOptions![i].title.toString(),
                                                                    style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                                      color: Colors.black,
                                                                    )),
                                                                if (question[index].questionOptions![i].type == 1)
                                                                  Radio<int>(
                                                                    value: question[index].questionOptions![i].id!,
                                                                    groupValue: answers[index]["RADIO_BUTTON"] as int?,
                                                                    onChanged: (value) {
                                                                      answers[index]["RADIO_BUTTON"] = value!;
                                                                      print("//////////////"+answers.toString());

                                                                      setState(() {

                                                                      });
                                                                    },
                                                                  ),
                                                                if (question[index].questionOptions![i].type == 2)
                                                                  Checkbox(
                                                                      value: answers[index][question[index].questionOptions![i].id],
                                                                      onChanged: (value) {
                                                                        answers[index][question[index].questionOptions![i].id] = value!;
                                                                        setState(() {

                                                                        });
                                                                      }),
                                                                if (question[index].questionOptions![i].type == 3)
                                                                  Container(
                                                                      width: Constants.mediaQuery.width * 0.2,
                                                                      height: Constants.mediaQuery.height * 0.2,
                                                                      decoration: BoxDecoration(
                                                                      ),
                                                                      child: QuestionTextField(
                                                                        hint: "ادخل النص",
                                                                        maxLines: 3,
                                                                        controller: answers[index][question[index].questionOptions![i].id] as TextEditingController,
                                                                      )
                                                                  ).setVerticalPadding(context,enableMediaQuery: false ,5)
                                                              ],
                                                            ),
                                                          ),
                                                        ]
                                                      ],
                                                    ),
                                                  )),
                                            ),

                                          ]
                                          else ...[
                                            Text(
                                              "ملاحظات الاستشاري",
                                              style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                color: Colors.black,
                                              ),
                                            ),
                                            CustomTextField(
                                              maxLines: 4,
                                              hint: "ملاحظات الاستشاري",
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      " هل يحتاج الي جلسة اخري",
                                                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                          color: Colors.black),
                                                    ),
                                                    Checkbox(
                                                      value: (needOtherSession==1),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          needOtherSession = (value!)?1:0;
                                                        });


                                                      },
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "الخدمة الاستشارية",
                                                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10,),
                                                    DropDown(
                                                      onChange: (value){
                                                        setState(() {
                                                          selected_consultation_service = value;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            BorderRoundedButton(
                                              title: "التالي",
                                              onPressed: (){
                                              //   Map<String,dynamic> storeDate =
                                              //   {
                                              //     "advicor_id": CacheHelper.getData(key: 'id'),
                                              //     "pationt_id": widget.pationt_data['pationt']['id'],
                                              //     "need_other_session": needOtherSession,
                                              //     "consultation_service_id": selected_consultation_service,
                                              //     "comments": "لا يوجد تعليقات",
                                              //     "date": "2024-05-14",
                                              //     "answers": [
                                              //         for(int i=0;i<answers.length;i++){
                                              //             {
                                              //                 "question_option_id": answers[i].entries.first.key,
                                              //                 "pationt_answer": answers[i].entries.first.value
                                              //             }
                                              //         }
                                              //     ]
                                              // };
                                                
                                                print("+++++++++++++++${answers}");

                                                // questionViewCubit.getStoreForm(storeDate);
                                              },
                                            ).setHorizontalPadding(
                                                context,
                                                enableMediaQuery: false,
                                                10),


                                          ]
                                        ],
                                      )
                                          .setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(
                                          context, enableMediaQuery: false, 10);

                                    }),
                              ),
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
  bool checkValue(){
    bool result = true ;
    answers.forEach((element) {
      if(element.isEmpty){
        result = false ;
      }
    });
    return result ;
  }

}

class LinePainter extends CustomPainter {
  final String text;
  final double padding; // Add padding property

  LinePainter({required this.text, this.padding = 15}); // Default padding is 10.0

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black87
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
      maxWidth: size.width * 0.30 - 2 * margin, // Subtract padding from maxWidth
    );

    var offset = Offset(
      margin + (size.width * 0.30 - 2 * margin - textPainter.width) / 2, // Adjust x position based on padding
      (size.height - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

