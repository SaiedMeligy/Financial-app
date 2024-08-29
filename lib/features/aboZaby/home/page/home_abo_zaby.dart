
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/aboZaby/home/page/patient_need_other_session_view.dart';
import 'package:experts_app/features/aboZaby/home/page/patient_no_need_other_session_view.dart';
import 'package:experts_app/features/aboZaby/home/page/patient_success_story_view.dart';
import 'package:experts_app/features/homeAdmin/staticScreen/Widegets/SenarioWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';

import '../../../../core/config/constants.dart';
import '../../../../domain/entities/HomeAdmin.dart';
import '../../../../domain/entities/SenarioModels.dart';
import '../../../homeAdmin/staticScreen/Widegets/CircleCharts.dart';
import '../../../homeAdmin/staticScreen/manager/cubit.dart';
import '../../../homeAdmin/staticScreen/manager/states.dart';


class HomeAboZaby extends StatefulWidget {
  const HomeAboZaby({super.key});

  @override
  State<HomeAboZaby> createState() => _HomeAboZabyState();
}

class _HomeAboZabyState extends State<HomeAboZaby> {
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
                                title: "عدد الأسر",
                                count: homeAdmin?.pationtsCount.toString() ?? "",
                                icon: Icons.back_hand_rounded,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => PatientSuccessStoryView(),));
                                },
                                child: _buildInfoCard(
                                  title: "عدد قصص النجاح",
                                  count: homeAdmin?.successStoryCount.toString() ?? "",
                                  icon: Icons.emoji_events,
                                ),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PatientNeedOtherSessionView()));

                  },
                                child: _buildInfoCardPatient(
                                  title: "عدد الأسر التى تتطلب جلسة إضافية",
                                  count: homeAdmin?.needOtherSession.toString() ?? "",
                                  icon: Icons.back_hand_rounded,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PatientNoNeedOtherSessionView()));


                                },
                                child: _buildInfoCardPatient(
                                    title: "عدد الأسر التى لا تتطلب جلسة إضافية",
                                    count: homeAdmin?.noNeedOtherSession.toString() ?? "",
                                    icon:  Icons.back_hand_rounded
                                ),
                              ),

                            ],
                          ),
                          // _buildScenarioReport(senario1, senario2, senario3, senarioReport),
                          Row(
                            children: [
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
                                title: "عدد الأسر",
                                count: homeAdmin?.pationtsCount.toString() ?? "",
                                icon: Icons.back_hand_rounded,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PatientSuccessStoryView(),));
                                },
                                child: _buildInfoCard(
                                    title: "عدد قصص النجاح",
                                    count: homeAdmin?.successStoryCount.toString() ?? "",
                                    icon: Icons.emoji_events
                                ),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PatientNeedOtherSessionView()));
                                  },
                                child: _buildInfoCardPatient(
                                  title: "عدد الأسر التى تتطلب جلسة إضافية",
                                  count: homeAdmin?.needOtherSession.toString() ?? "",
                                  icon: Icons.back_hand_rounded,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PatientNoNeedOtherSessionView(),));
                                },
                                child: _buildInfoCardPatient(
                                    title: "عدد الأسر التى لا تتطلب جلسة إضافية",
                                    count: homeAdmin?.noNeedOtherSession.toString() ?? "",
                                    icon:  Icons.back_hand_rounded
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: 10),
                          SenarioWadget(),
                          Row(
                            children: [
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
      height:isMobile? Constants.mediaQuery.height * 0.20:Constants.mediaQuery.height * 0.16,
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
      height:isMobile? Constants.mediaQuery.height * 0.25:Constants.mediaQuery.height * 0.27,
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

}
