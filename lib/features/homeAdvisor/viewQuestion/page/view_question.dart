
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/radio_button.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/widget/Question_text_field.dart';
import '../../../../core/widget/custom_text_field.dart';

class ViewQuestion extends StatefulWidget {

   ViewQuestion({super.key});
   List<int> axis = [];
  @override
  State<ViewQuestion> createState() => _ViewQuestionState();
}

class _ViewQuestionState extends State<ViewQuestion> {
  var questionViewCubit =QuestionViewCubit();
  Set<int> displayedAxisIds = {};


  @override
  void initState() {
    questionViewCubit.getAllQuestion();
  }
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionViewCubit,QuestionViewStates>(
      bloc: questionViewCubit,
      builder: (context, state) {
        if (state is LoadingQuestionViewState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SuccessQuestionViewState) {
          var question = state.question;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: ListView.builder(
              itemCount: question.length,
              itemBuilder: (context, index) {
                bool isAxisDisplayed = displayedAxisIds.contains(question[index].axis!.id);

                if (!isAxisDisplayed) {
                  displayedAxisIds.add(question[index].axis!.id!);
                }
                return
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //   color: Constants.theme.primaryColor,
                      //   width: 2.5,
                      // )
                    ),
                    child:
                    Column(


                      children: [
                        // if(!axis.contains(question[index].axis?.id))
                        //   Text(question[index].axis!.name.toString(),style: TextStyle(color: Colors.black),),
                        // if(!axis.contains(question[index].axis?.id))
                        //
                        //   axis.add(question[index].axis!.id!)
                        if(!isAxisDisplayed)
                        Text(question[index].axis!.name.toString(),style: TextStyle(
                          color: Colors.black
                        )),

                        Container(
                          width: double.infinity,
                          child: CustomPaint(
                            foregroundPainter: LinePainter(
                              text: question[index].title.toString() ,
                            ),
                            child: Container(
                              width: Constants.mediaQuery.width*0.2,
                              height: question[index].questionOptions!.length > 2 ? question[index].questionOptions!.length * 100 : 200 ,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Constants.theme.primaryColor,
                                  width: 2.5,
                                )
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for(int i = 0 ; i < question[index].questionOptions!.length ; i++)...[
                                    Container(
                                      width: Constants.mediaQuery.width * 0.4 ,
                                      height: Constants.mediaQuery.height * 0.1 ,
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Constants.theme.primaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Constants.theme.primaryColor,
                                          width: 2.5,
                                        )
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            question[index].questionOptions![i].title.toString() ,
                                            style: Constants.theme.textTheme.bodyMedium
                                          ),

                                          /// ==
                                          if(question[index].questionOptions![i].type == 0)
                                            Radio<int>(
                                              value: 1 ,
                                              groupValue: 1 ,
                                              onChanged: (value) {
                                                setState(() {
                                                  // _selectedValue = value;
                                                });
                                              },
                                            ),
                                          if(question[index].questionOptions![i].type == 1)
                                            Checkbox(value: true , onChanged: (value){}),

                                          if(question[index].questionOptions![i].type == 2)
                                            Container(
                                              width: Constants.mediaQuery.width * 0.2 ,
                                              height: Constants.mediaQuery.height * 0.2 ,
                                              decoration: BoxDecoration(
                                                color: Constants.theme.primaryColor
                                              ),
                                              child:
                                              const QuestionTextField(hint: "ادخل النص",
                                              maxLines: 3,)
                                            )

                                        ],
                                      ),
                                    )
                                  ]
                                ],
                              ),
                              // color: Colors.amberAccent,
                            )
                          ),
                        ),
                      ],
                    ).setVerticalPadding(context,enableMediaQuery: false ,10).setHorizontalPadding(context,enableMediaQuery: false, 10),
                  ).setHorizontalPadding(context,enableMediaQuery: false,10).setVerticalPadding(context,enableMediaQuery: false, 10);
              }
            ),
          );
        } else if (state is ErrorQuestionViewState) {
          return Center(child: Text(state.errorMessage));
        }
        return const SizedBox.shrink();
      },
    );
  }
}


class LinePainter extends CustomPainter {
  final String text;
  LinePainter({required this.text});


  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Constants.theme.primaryColor
      ..strokeWidth = 15;

    var path = Path();

    // Rectangle
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.30 , 0);
    path.lineTo(size.width * 0.30 , size.height);
    path.lineTo(0, size.height);
    path.close();

    // Triangle on the right side of the rectangle
    path.moveTo(size.width * 0.30, 10); // Triangle's top point
    path.lineTo(size.width - 650 , 50);        // Triangle's right point
    path.lineTo(size.width * 0.30 , 90); // Triangle's bottom point
    path.close();

    canvas.drawPath(path, paint);

    var textPainter = TextPainter(

      text: TextSpan(

        text: text ,
        style: Constants.theme.textTheme.titleLarge?.copyWith(

        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width * 0.30,
    );

    // Position the text at the center of the rectangle
    var offset = Offset(
      (size.width * 0.30 - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  // class Operation extends StatelessWidget {
  // final int id;
  // const Operation({Key? key,required this.id}) : super(key: key,);
  //
  // @override
  // Widget build(BuildContext context) {
  // widget.
  // return Text(
  //
  //
  // );
  // }

  }



