import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/data/models/AnswersData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../PointerTypes/presentation/widgets/TextWidget.dart';

class AnswerItem extends StatelessWidget {
  AnswersData answer ;
  int count ;
  Icon iconYes = Icon(Icons.done , color: Colors.white) ;
  Icon iconNo = Icon(CupertinoIcons.minus , color: Colors.white) ;
  Icon simpleIcon = Icon(Icons.reddit , color: Colors.white) ;

  AnswerItem({
    required this.answer,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconFormatedWidget(
                title: answer.title.toString(),
                count: ( answer.count! / count ) * 100
              ),
              SizedBox(width: 5,),
              Container(
                width: 200 ,
                alignment: Alignment.centerRight,
                child: TextWidget(
                  text: answer.title.toString()
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  TextWidget(
                      text: answer.count.toString()
                  ),
                  SizedBox(width: 2,),
                  TextWidget(
                      text: "اجابة"
                  ),
                ],
              ),
              getProgressWidget(count: ( answer.count! / count ) * 100),
            ],
          ),
        ],
      ),
    );
  }


  Widget IconFormatedWidget({required String title , required double count}){
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10) ,
        color: count >= 80 ? Colors.green : count >= 60 ? Colors.yellow : Colors.red
      ),
      child: getIcon(title),
    );
  }

  Icon getIcon(String title){
    if(title.toString() == "نعم"){
      return iconYes ;
    }else if(title.toString() == "لا"){
      return iconNo ;
    }else{
      return simpleIcon ;
    }
  }

  Widget getProgressWidget({required double count}){
    return Wrap(
      children: [
        Container(
          width: 100,
          child: LinearProgressIndicator(
            value: count/100,
            borderRadius: BorderRadiusDirectional.circular(3),
            backgroundColor: Colors.black38,
            minHeight: 7,
            color: count >= 80 ? Colors.green : count >= 60 ? Colors.yellow : Colors.red ,
          ),
        ),
        SizedBox(width: 5,),
        TextWidget(text: count.toStringAsFixed(2) + "% "),
      ],
    );
  }
}
