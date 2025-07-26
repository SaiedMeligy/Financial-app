import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/models/QuestionsStatistics.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/presentation/widgets/AnswerItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuestionstatisticsItem extends StatelessWidget {
  QuestionsStatistics questionStatistics ;
  int count ;

  QuestionstatisticsItem({
    required this.questionStatistics ,
    required this.count
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70 + questionStatistics.answersData!.length * 71,
      decoration: BoxDecoration(
        color: Color.fromRGBO(253, 255, 255, 1),
        borderRadius: BorderRadiusDirectional.circular(5),
        border: Border.all(
          color: Color.fromRGBO(227, 231, 241, 1)
        )
      ),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(235, 239, 255, 1) ,
                    borderRadius: BorderRadiusDirectional.circular(5) ,
                  ),
                  child: Icon(
                    Icons.question_mark
                  ),
                ),
                SizedBox(width: 10,),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    alignment: AlignmentDirectional.centerStart,
                    width: 300 ,
                    child: TextWidget(
                      text: questionStatistics.title.toString() ,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...questionStatistics.answersData!.map((answer) => AnswerItem(answer: answer, count: count)).toList()
        ],
      ),
    );
  }
}
