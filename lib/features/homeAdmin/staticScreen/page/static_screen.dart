
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/staticScreen/Widegets/SenarioWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';

import '../../../../core/config/constants.dart';
import '../../../../domain/entities/HomeAdmin.dart';
import '../../../../domain/entities/HomeAdminModel.dart';
import '../../../../domain/entities/SenarioModels.dart';
import '../Widegets/CircleCharts.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';

class StaticScreen extends StatefulWidget {
  const StaticScreen({super.key});

  @override
  State<StaticScreen> createState() => _StaticScreenState();
}

class _StaticScreenState extends State<StaticScreen> {
  late HomeAdminCubit homeAdminCubit;
  bool isMobile = false;

  @override
  void initState() {
    super.initState();
    homeAdminCubit = HomeAdminCubit();
    homeAdminCubit.getHomeAdmin();
  }

  double calculatePercentage(int pationtPointersCount, int pointersCount) {
    if (pointersCount == 0) return 0;
    return (pationtPointersCount / pointersCount) * 100;
  }

  @override
  Widget build(BuildContext context) {
    // homeAdminCubit.getHomeAdminSenario();
    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: BlocBuilder<HomeAdminCubit, HomeAdminStates>(
              bloc: homeAdminCubit,
              builder: (context, state) {
                if (state is LoadingHomeAdmin) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ErrorHomeAdmin) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: Constants.theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  );
                }

                if (state is SuccessHomeAdmin) {
                  var homeAdmin = state.home;
                  var topAdvisors = homeAdmin?.topAdvicors ?? [];

                  print("ssssssssssssssss>" + homeAdmin.toString());
                  // var senarioReport = homeAdmin?.senariosReport ?? [];

                  // var senario1 = calculatePercentage(senarioReport[0].pationtsPointersCount ?? 0, senarioReport[0]?.pointersCount ?? 0).toString();
                  // var senario2 = calculatePercentage(senarioReport[1].pationtsPointersCount ?? 0, senarioReport[1]?.pointersCount ?? 0).toString();
                  // var senario3 = calculatePercentage(senarioReport[2].pationtsPointersCount ?? 0, senarioReport[2]?.pointersCount ?? 0).toString();

                  List<SalesData> advisorData = topAdvisors.map((advisor) {
                    return SalesData(advisor.advicor?.name ?? '', advisor.pationtCount!.toDouble());
                  }).toList();

                  return isMobile
                      ? SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/back.jpg"),
                          fit: BoxFit.cover,
                          opacity: 0.2

                        ),
                      ),

                      child: Column(
                        children: [
                          Row(
                            children: [
                              _buildInfoCard(
                                title: "عدد الحالات",
                                count: homeAdmin?.pationtsCount.toString() ?? "",
                                icon: Icons.back_hand_rounded,
                              ),
                              _buildInfoCard(
                                title: "عدد قصص النجاح",
                                count: homeAdmin?.successStoryCount.toString() ?? "",
                                icon: Icons.emoji_events,
                              ),
                              _buildInfoCard(
                                title: "عدد الجلسات",
                                count: homeAdmin?.sessionsCount.toString() ?? "",
                                icon: Icons.bookmark_added_rounded,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildInfoCardPatient(
                                title: "عدد الحالات التى بحاجه الى جلسة اخرى",
                                count: homeAdmin?.needOtherSession.toString() ?? "",
                                icon: Icons.back_hand_rounded,
                              ),
                              _buildInfoCardPatient(
                                  title: "عدد الحالات الغير بحاجه الى جلسة اخرى",
                                  count: homeAdmin?.noNeedOtherSession.toString() ?? "",
                                  icon:  Icons.back_hand_rounded
                              ),

                            ],
                          ),
                          // _buildScenarioReport(senario1, senario2, senario3, senarioReport),
                          Row(
                            children: [
                              _buildTopAdvisors(topAdvisors),
                              Expanded(child: CircleCharts(advisorData: advisorData)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                      : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/back.jpg"),
                            fit: BoxFit.cover,
                            opacity: 0.4
                          )
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildInfoCard(
                                title: "عدد الحالات",
                                count: homeAdmin?.pationtsCount.toString() ?? "",
                                icon: Icons.back_hand_rounded,
                              ),
                              _buildInfoCard(
                                  title: "عدد قصص النجاح",
                                  count: homeAdmin?.successStoryCount.toString() ?? "",
                                  icon: Icons.emoji_events
                              ),
                              _buildInfoCard(
                                  title: "عدد الجلسات",
                                  count: homeAdmin?.sessionsCount.toString() ?? "",
                                  icon: Icons.bookmark_added_rounded
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildInfoCardPatient(
                                title: "عدد الحالات التى بحاجه الى جلسة اخرى",
                                count: homeAdmin?.needOtherSession.toString() ?? "",
                                icon: Icons.back_hand_rounded,
                              ),
                              _buildInfoCardPatient(
                                  title: "عدد الحالات الغير بحاجه الى جلسة اخرى",
                                  count: homeAdmin?.noNeedOtherSession.toString() ?? "",
                                  icon:  Icons.back_hand_rounded
                              ),

                            ],
                          ),
                          SizedBox(height: 10),
                          // BlocBuilder<HomeAdminCubit,HomeAdminStates>(
                          //   bloc: homeAdminCubit,
                          //   builder: (context, state) {
                          //     if (state is LoadingHomeAdmin) {}
                          //     if (state is ErrorHomeAdmin) {
                          //       return Text(state.errorMessage);
                          //     }
                          //     if(state is SuccessHomeAdminSenario){
                          //       var senarioReport = state.senario?.senariosReport??[];
                          //       print('------------->'+);
                          //             print("------------>"+senarioReport.toString());
                          //
                          //       // var senario1 = calculatePercentage(senarioReport[0].pationtsPointersCount ?? 0, senarioReport?[0].pointersCount ?? 0).toString();
                          //       // var senario2 = calculatePercentage(senarioReport[1].pationtsPointersCount ?? 0, senarioReport?[1].pointersCount ?? 0).toString();
                          //       // var senario3 = calculatePercentage(senarioReport[2].pationtsPointersCount ?? 0, senarioReport?[2].pointersCount ?? 0).toString();
                          //       //
                          //       //
                          //       //
                          //       //   return _buildScenarioReport(senario1, senario2, senario3, senarioReport.cast<SenariosReport>());
                          //     }
                          //     else {
                          //       Text("wrong");
                          //     }
                          //     return SizedBox.shrink();
                          //   },
                          //
                          // ),
                          SenarioWadget(),
                          Row(
                            children: [
                              
                              Container(
                                width: Constants.mediaQuery.width * 0.3,
                                height: Constants.mediaQuery.height * 0.57,
                                decoration: BoxDecoration(
                                  color: Constants.theme.primaryColor.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "اكثر استشاريين لديهم حالات",
                                        style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                          color:  Colors.black
                                        ),
                                      ),
                                      Divider(
                                        color: Constants.theme.primaryColor,
                                        thickness: 1,
                                        indent: 10,
                                        endIndent: 10,
                                      ),
                                      SizedBox(height: 20,),
                                      ...topAdvisors.take(3).map((advisor) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "الاسم: ${advisor.advicor?.name ?? ""}",
                                              style: Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 18,color: Colors.black87),
                                            ),
                                            Text(
                                              "العدد: ${advisor.pationtCount}",
                                              style: Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 18,color: Colors.black87),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                              ).setHorizontalPadding(context,enableMediaQuery: false, 5),
                              Expanded(
                                child: CircleCharts(advisorData: advisorData),
                              ),
                            ],
                          ),
                        ],
                      ).setHorizontalPadding(context,enableMediaQuery: false,15),
                    ),
                  );
                }
                else {
                  return Center(
                    child:
                    // Text(
                    //   "حدث خطأ ما",
                    //   style: Constants.theme.textTheme.bodyMedium?.copyWith(
                    //     color: Colors.red,
                    //   ),
                    // ),
                    CircularProgressIndicator()
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoCard({required String title, required String count, required IconData icon}) {
    return Container(
      width: isMobile ? Constants.mediaQuery.width * 0.3 : Constants.mediaQuery.width * 0.16,
      height:isMobile? Constants.mediaQuery.height * 0.17:Constants.mediaQuery.height * 0.16,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black54,
          width: 2.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Icon(icon,size: isMobile?20:30,),
          Expanded(
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,

                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize:isMobile? 16:22
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                count,
                textAlign: TextAlign.center,
                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize:isMobile? 16:22,
            
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildInfoCardPatient({required String title, required String count, required IconData icon}) {
    return Container(
      width: isMobile ? Constants.mediaQuery.width * 0.3 : Constants.mediaQuery.width * 0.2,
      height:isMobile? Constants.mediaQuery.height * 0.20:Constants.mediaQuery.height * 0.25,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey,
        border: Border.all(
          color: Colors.black54,
          width: 2.5,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Icon(icon,size: isMobile?20:30,),
          Expanded(
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize:isMobile? 16:22
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                count,
                textAlign: TextAlign.center,
                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize:isMobile? 16:22,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioReport(String senario1, String senario2, String senario3, List<SenariosReport> senarioReport) {
    return Container(
      width: double.infinity,
      height: isMobile?Constants.mediaQuery.height * 0.29:Constants.mediaQuery.height * 0.36,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "السيناريو الاول : " + double.parse(senario1).toStringAsFixed(2) + "%",
                style:isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                  fontSize: 20
                ):Constants.theme.textTheme.titleLarge
              ),
              Text(
                "السيناريو الثاني : " + double.parse(senario2).toStringAsFixed(2) + "%",
                style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                    fontSize: 20
                ):Constants.theme.textTheme.titleLarge,
              ),
              Text(
                "السيناريو الثالث : " + double.parse(senario3).toStringAsFixed(2) + "%",
                style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                    fontSize: 20
                ):Constants.theme.textTheme.titleLarge,
              ),
            ],
          ),
          MultiCircularSlider(
            size: isMobile ? 130 : 200,
            progressBarType: MultiCircularSliderType.circular,
            values: [
              senario1.isNotEmpty ? calculatePercentage(senarioReport[0].pationtsPointersCount ?? 0, senarioReport[0]?.pointersCount ?? 0) / 100 : 0,
              senario2.isNotEmpty ? calculatePercentage(senarioReport[1].pationtsPointersCount ?? 0, senarioReport[1]?.pointersCount ?? 0) / 100 : 0,
              senario3.isNotEmpty ? calculatePercentage(senarioReport[2].pationtsPointersCount ?? 0, senarioReport[2]?.pointersCount ?? 0) / 100 : 0,
            ],
            colors: [Colors.red, Colors.orange, Colors.green],
            showTotalPercentage: true,
            animationDuration: const Duration(milliseconds: 500),
            animationCurve: Curves.easeIn,
            trackColor: Colors.white,
            progressBarWidth: isMobile ? 26.0 : 52.0,
            trackWidth: isMobile ? 25 : 40,
            percentageTextStyle: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildTopAdvisors(List<TopAdvicors> topAdvisors) {
    return Container(
      width: MediaQuery.of(context).size.width*0.35,
      height: isMobile?Constants.mediaQuery.height * 0.63:Constants.mediaQuery.height * 0.57,
      decoration: BoxDecoration(
        color: Constants.theme.primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "اكثر استشارين لديهم حالات",
              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                fontSize: 16
              ),
            ),
            Divider(
              color: Constants.theme.primaryColor,
              thickness: 1,
              indent: 10,
              endIndent: 10,
            ),
            SizedBox(height: 20,),
            ...topAdvisors.take(3).map((advisor) {
              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "الاسم: ${advisor.advicor?.name ?? ""}",
                                      style: Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
                                    ),
                                    Text(
                                      "العدد: ${advisor.pationtCount}",
                                      style: Constants.theme.textTheme.bodyLarge?.copyWith(fontSize: 16),
                                    ),
                                  ],
                                );
            }).toList(),
          ],
        ),
      ),
    ).setHorizontalPadding(context,enableMediaQuery: false, 5);
  }
  String DividText (String text){
    String temp = "" ;
    List<String> Words = text.split(" ") ;
    if(Words.length > 3){
      for(int i=0; i<(Words.length/2).ceil();i++){
        temp += Words[i] + " " ;
      }
      temp = temp + "\n" ;
      for(int i=(Words.length/2).ceil(); i<Words.length;i++){
        temp += Words[i] + " " ;
      }
      return temp ;
    }


    return text ;

  }

}
