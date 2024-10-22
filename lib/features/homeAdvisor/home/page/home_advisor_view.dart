
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdvisor/home/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/home/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/page/session_data_view_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/config/constants.dart';

class HomeAdvisorView extends StatefulWidget {
  const HomeAdvisorView({super.key});

  @override
  State<HomeAdvisorView> createState() => _HomeAdvisorViewState();
}

class _HomeAdvisorViewState extends State<HomeAdvisorView> {
  var homeAdvisorCubit = HomeAdvisorCubit();
  bool isMobile =false;
  @override
  void initState() {
    super.initState();
    homeAdvisorCubit.getHomeAdvisor();
  }
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        isMobile = constraints.maxWidth < 600;
        return BlocBuilder<HomeAdvisorCubit,HomeAdvisorStates>(
        bloc: homeAdvisorCubit,
        builder: (context, state) {
          if(state is LoadingHomeAdvisor){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is ErrorHomeAdvisor){
            return Center(
              child: Text(state.errorMessage,style: Constants.theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.red
              ),),
            );
          }
          if(state is SuccessHomeAdvisor){
            var home = state.home;
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  fit: BoxFit.cover,
                  opacity: 0.2
                )
              ),
              child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: isMobile?Constants.mediaQuery.width*0.4:Constants.mediaQuery.width*0.16,
                            height: Constants.mediaQuery.height*0.20,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 2.5,
                                ),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.back_hand_rounded,),
                                SizedBox(height: 10,),
                                Center(
                                  child: Text("عدد الحالات",textAlign:TextAlign.center ,style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black
                                  ),),
                                ),

                                Expanded(
                                  child: Center(
                                    child: Text(home!.pationtsCount.toString(),textAlign:TextAlign.center ,style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                        color: Colors.black
                                    ),),
                                  ),
                                ),
                              ],
                            )
                        ),
                        Container(
                            width: isMobile?Constants.mediaQuery.width*0.4:Constants.mediaQuery.width*0.16,
                            height: Constants.mediaQuery.height*0.20,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                border: Border.all(
                                  color: Colors.black54,
                                  width: 2.5,
                                ),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.bookmark_added_rounded),
                                SizedBox(height: 10,),
                                Center(
                                  child: Text("عدد الجلسات",textAlign:TextAlign.center ,style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                      color: Colors.black
                                  ),),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(home.sessionsCount.toString(),textAlign:TextAlign.center ,style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                        color: Colors.black
                                    ),),
                                  ),
                                ),
                              ],
                            )
                        ),

                      ],
                    ).setVerticalPadding(context,enableMediaQuery: false,50),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Container(
                            decoration:BoxDecoration(
                              border: Border.all(
                                color: Colors.black54,
                                width: 2.5,
                              ),

                            ),
                            child: Column(
                              children: [
                                Text("الجلسات الفرعية القادمة",style: Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.black,fontSize: isMobile?20:24),),
                                Table(
                                  columnWidths: {
                                    0 : FlexColumnWidth(4) ,
                                    1 : FlexColumnWidth(2) ,
                                    2 : FlexColumnWidth(2) ,
                                    3 : FlexColumnWidth(2) ,
                                  },
                                  children: [
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: Colors.black ,
                                        ),
                                        children: [
                                          TableCell(
                                            child: Container(
                                              height: 50 ,
                                              child: Center(
                                                child: Text(
                                                  "اسم الحالة",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    fontSize: isMobile?18:20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  "تاريخ الجلسة",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    fontSize: isMobile?18:20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  "الوقت",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    fontSize: isMobile?18:20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              height: 50,
                                              child: Center(
                                                child: Text(
                                                  "رقم التلفون",
                                                  textAlign: TextAlign.center,
                                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    fontSize: isMobile?18:20,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]
                                    ),
                                    // for(int index = 0; index < session.length ; index++)...[
                                    TableRow(
                                        decoration: BoxDecoration(
                                          color: Colors.black38 ,
                                        ),
                                        children: [
                                          TableCell(
                                            child: GestureDetector(
                                              onTap: (){
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        SessionDetailsViewHome(
                                                      pationt_data:home.upCommingSession?.pationt,
                                                      sessionId:home.upCommingSession!.id!,
                                                      isFinished:home.upCommingSession!.isFinished!,
                                                      sessionCaseManager:home.upCommingSession?.caseManager,
                                                      sessionComment:home.upCommingSession?.comments,
                                                      sessionDate:home.upCommingSession?.date,
                                                          isAttend: home.upCommingSession?.isAttended,
                                                          consultationService: home.upCommingSession?.consultationServiceId,
                                                    ),
                                                  ),

                                                );

                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  home.upCommingSession?.pationt?.name??"" ,
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: isMobile?16:20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                home.upCommingSession?.date.toString()??"",
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: isMobile?16:20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                home.upCommingSession?.time.toString()??"",
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: isMobile?16:20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                home.upCommingSession?.phoneNumber.toString()??"",
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: isMobile?16:20,
                                                ),
                                              ),
                                            ),
                                          ),

                                        ]
                                    ),
                                    //]
                                  ],


                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ]
              ),
            );
          }
          return Text("some thing went wrong");

        },
      );}
    );
  }
}
