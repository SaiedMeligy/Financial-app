
import 'package:experts_app/core/config/app_theme_manager.dart';
import 'package:experts_app/core/excel_exportation/RecordsTableWidget.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/TableWidget.dart';
import 'package:experts_app/features/aboZaby/home/page/patient_need_other_session_view.dart';
import 'package:experts_app/features/aboZaby/home/page/patient_no_need_other_session_view.dart';
import 'package:experts_app/features/aboZaby/home/page/patient_success_story_view.dart';
import 'package:experts_app/features/homeAdmin/staticScreen/Widegets/BuildInfoCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';

import '../../../../core/config/constants.dart';
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
                  List<AdvisorsStatistics> advisorsStatistics = homeAdmin?.advisorsStatistics ?? [];

                  List<SalesData> advisorData = topAdvisors.map((advisor) {
                    return SalesData(advisor.advicor?.name ?? '', advisor.pationtCount!.toDouble());
                  }).toList();

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      color: AppThemeManager.primaryColor,
                      child: Column(
                        children: [
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center ,
                            children: [
                              Text(
                                "العيادة المالية" ,
                                textAlign: TextAlign.start,
                                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                  color: AppThemeManager.secondryColor,
                                  fontSize: 20
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context, builder: (context) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: AppThemeManager.primaryColor,
                                          border: Border.all(
                                            width: 2.5 ,
                                            color: AppThemeManager.borderColor
                                          )
                                        ),
                                        child: AlertDialog(
                                        backgroundColor: AppThemeManager.primaryColor,
                                        content: SizedBox(
                                          width: Constants.mediaQuery.width * 0.4,
                                          height: Constants.mediaQuery.width * 0.10,
                                          child: RecordsTableWidget()
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              width: 120,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(7),
                                                border: Border.all(
                                                  color: AppThemeManager.borderColor,
                                                  width: 2.5,
                                                ),
                                              ),
                                              child: Text(
                                                "اغلاق" ,
                                                style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black , fontSize: 15),
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                      );
                                  });
                                },
                                icon: Icon(
                                  Icons.download_rounded ,
                                  color: AppThemeManager.secondryColor ,
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BuildInfoCard(
                                title: "عدد الأسر",
                                count: homeAdmin?.pationtsCount.toString() ?? "",
                                icon: Icon(
                                  Icons.family_restroom ,
                                  color: AppThemeManager.secondryColor,
                                  size: 30,
                                ),
                              ),
                              BuildInfoCard(
                                title: "عدد قصص النجاح",
                                count: homeAdmin?.successStoryCount.toString() ?? "",
                                icon: Icon(
                                  Icons.emoji_events_sharp ,
                                  color: Colors.yellow,
                                  size: 30,
                                ) ,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PatientSuccessStoryView()));
                                },
                              ),
                              BuildInfoCard(
                                title: "عدد الجلسات",
                                count: homeAdmin?.sessionsCount.toString() ?? "",
                                icon: Icon(
                                  Icons.calendar_month ,
                                  color: AppThemeManager.secondryColor,
                                  size: 30,
                                )
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              BuildInfoCard(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PatientNeedOtherSessionView(),));
                                },
                                title: "عدد الأسر التى\nتتطلب جلسة إضافية",
                                count: homeAdmin?.needOtherSession.toString() ?? "",
                                icon: Icon(
                                  CupertinoIcons.check_mark_circled_solid ,
                                  color: Colors.green,
                                  size: 30,
                                )
                              ),
                              BuildInfoCard(
                                title: "عدد الأسر التى\nلا تتطلب جلسة إضافية",
                                count: homeAdmin?.noNeedOtherSession.toString() ?? "",
                                icon:  Icon(
                                  Icons.warning ,
                                  color: Colors.yellow,
                                  size: 30,
                                ) ,
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PatientNoNeedOtherSessionView(),));
                                },
                              ),
                              BuildInfoCard(
                                title: "عدد الاسر التي\nخرجت من الدعم",
                                count: homeAdmin?.numberOfOutnes.toString() ?? "",
                                icon:  Icon(
                                  Icons.logout ,
                                  color: Colors.red,
                                  size: 30,
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          _buildTableAdvisorStatistics(advisorsStatistics),
                          SizedBox(height: 50),
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

  Widget _buildInfoCard({required String title, required String count, required Icon icon}) {
    return Container(
      width: 220,
      height: 120,
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppThemeManager.primaryColor ,
        border: Border.all(
          color: AppThemeManager.borderColor ,
          width: 2.5 ,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon ,
              SizedBox(width: 10,),
              Text(
                title ,
                textAlign: TextAlign.start,
                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontSize: 16
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              count,
              textAlign: TextAlign.center,
              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableAdvisorStatistics(List<AdvisorsStatistics> advisorsStatistics) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.68,
      height: advisorsStatistics.length * 57,
      decoration: BoxDecoration(
        color: Constants.theme.primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: TableWidget(
          advisorsStatistics: advisorsStatistics,
          headerData: ["الاسم" , "اساسية" , "منقوله"] ,
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

  printData(dynamic data) async {
    print("=======) " + (await data as HomeAdmin).advisorsStatistics![0].toString());
  }
}
