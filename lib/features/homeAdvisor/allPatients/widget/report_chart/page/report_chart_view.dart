import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/tab_item_widget.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';

class ReportChartView extends StatefulWidget {
  final int? senario_id;
  final dynamic pationt_data;

  ReportChartView({super.key, required this.pationt_data, this.senario_id});

  @override
  State<ReportChartView> createState() => _ReportChartViewState();
}

class _ReportChartViewState extends State<ReportChartView> {
  var addSessionCubit = AddSessionCubit();
  bool isMobile = false;

  @override
  void initState() {
    super.initState();
    addSessionCubit.getSessionDetails(widget.pationt_data.nationalId);
  }

  double calculatePercentage(int pationtPointersCount, int pointersCount) {
    if (pointersCount == 0) return 0;
    return (pationtPointersCount / pointersCount) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;

        return BlocBuilder<AddSessionCubit, AddSessionStates>(
        bloc: addSessionCubit,
        builder: (context, state) {
          if (state is LoadingAddSessionState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorAddSessionState) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is SuccessAddSessionState) {
            var pointers = state.result.data["pationt"]["pointers"] ?? [];
            var advices = state.result.data["pationt"]["advices"] ?? [];

            List<dynamic> pointers1Temp = [];
            List<dynamic> pointers2Temp = [];
            List<dynamic> pointers3Temp = [];

            for (var pointer in pointers) {
              if (pointer["id"] == 1) {
                pointers1Temp.add(pointer);
              } else if (pointer["id"] == 2) {
                pointers2Temp.add(pointer);
              } else if (pointer["id"] == 3) {
                pointers3Temp.add(pointer);
              }
            }
            var senario1 = calculatePercentage(pointers1Temp[0]["pationt_pointers_count"] ?? 0, pointers1Temp[0]["pointers_count"] ?? 0).toString();
            var senario2 = calculatePercentage(pointers2Temp[0]["pationt_pointers_count"] ?? 0, pointers2Temp[0]["pointers_count"] ?? 0).toString();
            var senario3 = calculatePercentage(pointers3Temp[0]["pationt_pointers_count"] ?? 0, pointers3Temp[0]["pointers_count"] ?? 0).toString();

            if (pointers1Temp.isNotEmpty) {
              print("----------->>>${calculatePercentage(pointers1Temp[0]["pationt_pointers_count"] ?? 0, pointers1Temp[0]["pointers_count"] ?? 0).toString()}%");
            }
            if (pointers2Temp.isNotEmpty) {
              print("----------->>>${calculatePercentage(pointers2Temp[0]["pationt_pointers_count"] ?? 0, pointers2Temp[0]["pointers_count"] ?? 0).toString()}%");
            }
            if (pointers3Temp.isNotEmpty) {
              print("----------->>>${calculatePercentage(pointers3Temp[0]["pationt_pointers_count"] ?? 0, pointers3Temp[0]["pointers_count"] ?? 0).toString()}%");
            }

            if (pointers.isEmpty && advices.isEmpty) {
              return Center(
                child: Text("No data available"),
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: Text("تفاصيل الحالة"),
                centerTitle: true,
                titleTextStyle: Constants.theme.textTheme.titleLarge,
                backgroundColor: Constants.theme.primaryColor,
                elevation: 0,
                automaticallyImplyLeading: true,
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/back.jpg"),
                      fit: BoxFit.cover,
                      opacity: 0.8,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          height: isMobile?Constants.mediaQuery.height * 0.35:Constants.mediaQuery.height * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: Container(
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
                                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                                        fontSize: isMobile?20:24
                                      )
                                    ),
                                    Text(
                                      "السيناريو الثاني : " + double.parse(senario2).toStringAsFixed(2) + "%",
                                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                                          fontSize: isMobile?20:24
                                      )
                                    ),
                                    Text(
                                      "السيناريو الثالث : " + double.parse(senario3).toStringAsFixed(2) + "%",
                                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                                          fontSize: isMobile?20:24
                                      )
                                    ),
                                  ],
                                ),
                                MultiCircularSlider(
                                  size: isMobile?120:200,
                                  progressBarType: MultiCircularSliderType.circular,
                                  // values: countData,
                                  values: [
                                    pointers1Temp.isNotEmpty ? calculatePercentage(pointers1Temp[0]["pationt_pointers_count"] ?? 0, pointers1Temp[0]["pointers_count"] ?? 0) / 100 : 0,
                                    pointers2Temp.isNotEmpty ? calculatePercentage(pointers2Temp[0]["pationt_pointers_count"] ?? 0, pointers2Temp[0]["pointers_count"] ?? 0) / 100 : 0,
                                    pointers3Temp.isNotEmpty ? calculatePercentage(pointers3Temp[0]["pationt_pointers_count"] ?? 0, pointers3Temp[0]["pointers_count"] ?? 0) / 100 : 0,
                                  ],
                                  colors: [Colors.red, Colors.orange, Colors.green],
                                  showTotalPercentage: true,
                                  // label: 'This is label text',
                                  animationDuration: const Duration(milliseconds: 500),
                                  animationCurve: Curves.easeIn,
                                  trackColor: Colors.white,
                                  progressBarWidth: 52.0,
                                  trackWidth: 40,
                                  //labelTextStyle: TextStyle(color: Colors.black),
                                  percentageTextStyle: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "المؤشرات",
                                  style: Constants.theme.textTheme.titleLarge?.copyWith(
                                    color: Colors.black
                                  )               ,
                                ),
                                Expanded(
                                  child: TabItemWidget(
                                    item1: "السيناريو الاول",
                                    item2: "السيناريو التاني",
                                    item3: "السيناريو التالت",
                                    firstWidget: ListView.builder(
                                      itemCount: pointers1Temp.length,
                                      itemBuilder: (context, index) {
                                        var pationtPointers = pointers1Temp[index]["pationt_pointers"] ?? [];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (var pointer in pationtPointers)
                                              Text(
                                                pointer["text"],
                                                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                                  color: Colors.black,
                                                    fontSize: isMobile?18:22
                                                )
                                              ),
                                          ],
                                        );
                                      },
                                    ).setHorizontalPadding(context,enableMediaQuery: false,10 ),
                                    secondWidget: ListView.builder(
                                      itemCount: pointers2Temp.length,
                                      itemBuilder: (context, index) {
                                        var pationtPointers = pointers2Temp[index]["pationt_pointers"] ?? [];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (var pointer in pationtPointers)
                                              Text(
                                                  pointer["text"],
                                                  style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                                      color: Colors.black,
                                                      fontSize: isMobile?18:22
                                                  )
                                              ),
                                          ],
                                        );
                                      },
                                    ).setHorizontalPadding(context,enableMediaQuery: false,10 ),
                                    thirdWidget: ListView.builder(
                                      itemCount: pointers3Temp.length,
                                      itemBuilder: (context, index) {
                                        var pationtPointers = pointers3Temp[index]["pationt_pointers"] ?? [];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (var pointer in pationtPointers)
                                              Text(
                                                  pointer["text"],
                                                  style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                                      color: Colors.black,
                                                      fontSize: isMobile?18:22
                                                  )
                                              ),
                                          ],
                                        );
                                      },
                                    ).setHorizontalPadding(context,enableMediaQuery: false,10 ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "التوصيات",
                                  style: Constants.theme.textTheme.titleLarge?.copyWith(
                                    color: Colors.black
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: advices.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            advices[index]["text"],
                                            style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                              color: Colors.black,
                                                fontSize: isMobile?18:22
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Text("Something went wrong");
        },
      );}
    );
  }
}
