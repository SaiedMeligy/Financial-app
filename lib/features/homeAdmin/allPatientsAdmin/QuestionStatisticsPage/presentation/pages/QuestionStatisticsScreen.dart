import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/presentation/widgets/shimmer/shimmer_loading.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/presentation/cubit/questionstatistics_cubit.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/presentation/widgets/QuestionstatisticsItem.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/QuestionStatisticsPage/presentation/widgets/SupStatisticsItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Questionstatisticsscreen extends StatefulWidget {

  Questionstatisticsscreen({super.key});
  @override
  State<Questionstatisticsscreen> createState() => _QuestionstatisticsscreenState();
}

class _QuestionstatisticsscreenState extends State<Questionstatisticsscreen> {
  QuestionstatisticsCubit _cubit = QuestionstatisticsCubit();
  bool search = false ;
  @override
  void initState() {
    _cubit.getQuestionStatistics("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 249, 254, 1),
      body: Container(
        width: MediaQuery.sizeOf(context).width ,
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width / 2.2 + 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextWidget(
                    text: "احصائيات الاجابات" ,
                    fontWeight: FontWeight.bold,
                  ),
                  if(!search)...[
                    IconButton(
                      onPressed: () {
                        search = true ;
                        setState(() {

                        });
                      },
                      icon: Icon(Icons.search)
                    ),
                  ]
                  else...[
                    Container(
                      width: 200 ,
                      height: 35,
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black ,
                          fontSize: 12 ,
                        ),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: (){
                              search = false ;
                              setState(() {

                              });
                            },
                            icon: Icon(
                              Icons.dangerous_sharp ,
                              size: 12,
                            )
                          ),
                          prefixIcon: Icon(
                            Icons.search ,
                            size: 12,
                          ),
                        ),
                        onChanged: (value) {
                          _cubit.getQuestionStatistics(value);
                        },
                      ),
                    )
                  ]
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width / 2.2 + 250,
              child: BlocBuilder(
                bloc: _cubit ,
                builder: (context, state) {
                  if(state is QuestionstatisticsLoaded){
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SupStatisticsItem(
                              title: "عدد الاسئلة",
                              subtitle: state.QuestionStatistics.questionsStatistics!.length.toString(),
                              icon: Icon(Icons.menu),
                            ),
                            SupStatisticsItem(
                              title: "عدد الحالات",
                              subtitle: state.QuestionStatistics.patientCount.toString(),
                              icon: Icon(Icons.menu),
                            ),
                          ],
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.56,
                          child: ListView(
                            children: [
                            ...state.QuestionStatistics.questionsStatistics!.map((e) => QuestionstatisticsItem(
                                questionStatistics: e ,
                                count: state.QuestionStatistics.patientCount!
                              )).toList()
                            ],
                          ),
                        )
                      ],
                    );
                  }else if(state is QuestionstatisticsError){
                    return Container(
                      child: TextWidget(text: state.message),
                    );
                  } else if(state is QuestionstatisticsLoading){
                    return ShimmerLoading();
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
