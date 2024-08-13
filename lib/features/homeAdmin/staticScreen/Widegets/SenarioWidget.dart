import 'package:experts_app/features/homeAdmin/staticScreen/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';

import '../../../../core/config/constants.dart';
import '../../../../domain/entities/HomeAdmin.dart';
import '../manager/states.dart';

class SenarioWadget extends StatefulWidget {
  const SenarioWadget({super.key});

  @override
  State<SenarioWadget> createState() => _SenarioWadgetState();
}

class _SenarioWadgetState extends State<SenarioWadget> {
  var homeCubit = HomeAdminCubit();
  bool isMobile = false;
  @override
  void initState() {
    super.initState();
    homeCubit.getHomeAdminSenario();
  }
  double calculatePercentage(int pationtPointersCount, int pointersCount) {
    if (pointersCount == 0) return 0;
    return (pationtPointersCount / pointersCount) * 100;
  }

  Widget build(BuildContext context) {
    return BlocBuilder<HomeAdminCubit,HomeAdminStates>(
      bloc: homeCubit,
      builder: (context, state) {
        if (state is LoadingHomeAdminSenario) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ErrorHomeAdmin) {
          return Text(state.errorMessage);
        }

        if(state is SuccessHomeAdminSenario){
          var senarioReport = state.senario?.senariosReport??[];
          print("------------>"+senarioReport.toString());

          var senario1 = calculatePercentage(senarioReport[0].pationtsPointersCount ?? 0, senarioReport?[0].pointersCount ?? 0).toString();
           var senario2 = calculatePercentage(senarioReport[1].pationtsPointersCount ?? 0, senarioReport?[1].pointersCount ?? 0).toString();
           var senario3 = calculatePercentage(senarioReport[2].pationtsPointersCount ?? 0, senarioReport?[2].pointersCount ?? 0).toString();
          //
          //
          //
          // // print("------------------->"+senarioReport.toString());
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
                    senario1.isNotEmpty ? calculatePercentage(senarioReport[0].pationtsPointersCount ?? 0, senarioReport[0].pointersCount ?? 0) / 100 : 0,
                    senario2.isNotEmpty ? calculatePercentage(senarioReport[1].pationtsPointersCount ?? 0, senarioReport[1].pointersCount ?? 0) / 100 : 0,
                    senario3.isNotEmpty ? calculatePercentage(senarioReport[2].pationtsPointersCount ?? 0, senarioReport[2].pointersCount ?? 0) / 100 : 0,
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
        else {
          Text("wrong");
        }
        return CircularProgressIndicator();
      },

    );
  }
  // Widget _buildScenarioReport(String senario1, String senario2, String senario3, List<SenariosReport> senarioReport) {
  //   return Container(
  //     width: double.infinity,
  //     height: isMobile?Constants.mediaQuery.height * 0.29:Constants.mediaQuery.height * 0.36,
  //     margin: EdgeInsets.all(10),
  //     decoration: BoxDecoration(
  //       color: Colors.black87,
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Text(
  //                 "السيناريو الاول : " + double.parse(senario1).toStringAsFixed(2) + "%",
  //                 style:isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
  //                     fontSize: 20
  //                 ):Constants.theme.textTheme.titleLarge
  //             ),
  //             Text(
  //               "السيناريو الثاني : " + double.parse(senario2).toStringAsFixed(2) + "%",
  //               style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
  //                   fontSize: 20
  //               ):Constants.theme.textTheme.titleLarge,
  //             ),
  //             Text(
  //               "السيناريو الثالث : " + double.parse(senario3).toStringAsFixed(2) + "%",
  //               style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
  //                   fontSize: 20
  //               ):Constants.theme.textTheme.titleLarge,
  //             ),
  //           ],
  //         ),
  //         MultiCircularSlider(
  //           size: isMobile ? 130 : 200,
  //           progressBarType: MultiCircularSliderType.circular,
  //           values: [
  //             senario1.isNotEmpty ? calculatePercentage(senarioReport[0].pationtsPointersCount ?? 0, senarioReport[0].pointersCount ?? 0) / 100 : 0,
  //             senario2.isNotEmpty ? calculatePercentage(senarioReport[1].pationtsPointersCount ?? 0, senarioReport[1].pointersCount ?? 0) / 100 : 0,
  //             senario3.isNotEmpty ? calculatePercentage(senarioReport[2].pationtsPointersCount ?? 0, senarioReport[2].pointersCount ?? 0) / 100 : 0,
  //           ],
  //           colors: [Colors.red, Colors.orange, Colors.green],
  //           showTotalPercentage: true,
  //           animationDuration: const Duration(milliseconds: 500),
  //           animationCurve: Curves.easeIn,
  //           trackColor: Colors.white,
  //           progressBarWidth: isMobile ? 26.0 : 52.0,
  //           trackWidth: isMobile ? 25 : 40,
  //           percentageTextStyle: TextStyle(color: Colors.black),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
