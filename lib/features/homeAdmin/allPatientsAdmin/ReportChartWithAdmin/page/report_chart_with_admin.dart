import 'package:dio/dio.dart';
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

import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/widget/check_box_question.dart';
import '../../../../../domain/entities/AdviceMode.dart';
import '../../../../../domain/entities/QuestionModel.dart';

class ReportChartViewWithAdmin extends StatefulWidget {
  final int? senario_id;
  final dynamic pationt_data;

  ReportChartViewWithAdmin({super.key, required this.pationt_data, this.senario_id});

  @override
  State<ReportChartViewWithAdmin> createState() => _ReportChartViewWithAdminState();
}

class _ReportChartViewWithAdminState extends State<ReportChartViewWithAdmin> {
  var addSessionCubit = AddSessionCubit();
  bool isMobile = false;
  List<Pointers> pointers1 = [];
  List<Pointers> pointers2 = [];
  List<Pointers> pointers3 = [];
  List<Advices> advicesList = [];
  List<Advices> addAdvicesList = [];
  List<List<int>> selectedPointers1 = [];
  List<List<int>> selectedPointers2 = [];
  List<List<int>> selectedPointers3 = [];
  List<List<int>> selectedAdvices = [];
  List<List<int>> selectedQuestions = [];

  @override
  void initState() {
    super.initState();
    addSessionCubit.getPatientDetails(widget.pationt_data.nationalId);
    fetchPointers();
    fetchAdvices();
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
          if (state is SuccessPatientNationalIdState) {
            var pointers = state.result.data["pationt"]["pointers"] ?? [];
            var patient = state.result.data["pationt"] ?? [];
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
            List<int> selectedAdviceIds = [];


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
                backgroundColor: Colors.black87,
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
                      opacity: 0.4  ,
                    ),
                  ),
                  child: ListView(
                    children: [
                      Column(
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
                                          style:isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                                              fontSize: isMobile?20:24
                                          ):Constants.theme.textTheme.titleLarge
                                      ),
                                      Text(
                                        "السيناريو الثاني : " + double.parse(senario2).toStringAsFixed(2) + "%",
                                        style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile?20:24
                                        ):Constants.theme.textTheme.titleLarge,
                                      ),
                                      Text(
                                        "السيناريو الثالث : " + double.parse(senario3).toStringAsFixed(2) + "%",
                                        style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile?20:24
                                        ):Constants.theme.textTheme.titleLarge,
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
                          Container(
                            height: Constants.mediaQuery.height*0.4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Spacer(),
                                    Text(
                                      "المؤشرات",
                                      textAlign: TextAlign.center,
                                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.black,
                                              title: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Constants.theme.primaryColor,
                                                    width: 2.5,
                                                  ),
                                                ),
                                                child: Text(
                                                  "اختر من المؤشرات",
                                                  style: Constants.theme.textTheme.titleLarge,
                                                ),
                                              ),
                                              content: SizedBox(
                                                height: Constants.mediaQuery.height * 0.6,
                                                width: Constants.mediaQuery.width * 0.45,
                                                child: TabItemWidget(
                                                  item1: "السيناريو الاول",
                                                  item2: "السيناريو التاني",
                                                  item3: "السيناريو التالت",
                                                  firstWidget: CheckBoxQuestion(
                                                    items: pointers1,
                                                    previous: selectedPointers1.isNotEmpty ? selectedPointers1[0] : [],
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (selectedPointers1.isEmpty) {
                                                          selectedPointers1.add(value!);
                                                        } else {
                                                          selectedPointers1[0] = value!;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  secondWidget: CheckBoxQuestion(
                                                    previous: selectedPointers2.isNotEmpty ? selectedPointers2[0] : [],
                                                    items: pointers2,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (selectedPointers2.isEmpty) {
                                                          selectedPointers2.add(value!);
                                                        } else {
                                                          selectedPointers2[0] = value!;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  thirdWidget: CheckBoxQuestion(
                                                    previous: selectedPointers3.isNotEmpty ? selectedPointers3[0] : [],
                                                    items: pointers3,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        if (selectedPointers3.isEmpty) {
                                                          selectedPointers3.add(value!);
                                                        } else {
                                                          selectedPointers3[0] = value!;
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(
                                                        color: Constants.theme.primaryColor,
                                                        width: 2.5,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "موافق",
                                                      style: Constants.theme.textTheme.bodyMedium,
                                                    ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.add_circle_rounded),
                                    )

                                  ],
                                ).setVerticalPadding(context,enableMediaQuery: false, 3),
                                Expanded(
                                  child: TabItemWidget(
                                    item1: "السيناريوالأول(الحالات المتوازنة نسبيا)",
                                    item2: "السيناريوالثاني(للحالات الغير متوازنة في الصرف)",
                                    item3: "السيناريوالثالث(للحالات المتعثرة ماليا)",
                                    firstWidget: ListView.builder(
                                      itemCount: pointers1Temp.length,
                                      itemBuilder: (context, index) {
                                        var pationtPointers = pointers1Temp[index]["pationt_pointers"] ?? [];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (var pointer in pationtPointers)
                                              Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              pointer["text"],
                                              style: TextStyle(
                                                fontSize: isMobile?16:20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            IconButton(onPressed: (){}, icon: Icon(Icons.delete))
                                          ],
                                        ),
                                          ],
                                        ).setHorizontalPadding(context,enableMediaQuery: false,10 );
                                      },
                                    ),
                                    secondWidget: ListView.builder(
                                      itemCount: pointers2Temp.length,
                                      itemBuilder: (context, index) {
                                        var pationtPointers = pointers2Temp[index]["pationt_pointers"] ?? [];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (var pointer in pationtPointers)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    pointer["text"],
                                                    style: TextStyle(
                                                      fontSize: isMobile?16:20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  IconButton(onPressed: (){}, icon: Icon(Icons.delete))
                                                ],
                                              ),
                                          ],
                                        ).setHorizontalPadding(context,enableMediaQuery: false,10 );
                                      },
                                    ),
                                    thirdWidget: ListView.builder(
                                      itemCount: pointers3Temp.length,
                                      itemBuilder: (context, index) {
                                        var pationtPointers = pointers3Temp[index]["pationt_pointers"] ?? [];
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            for (var pointer in pationtPointers)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    pointer["text"],
                                                    style: TextStyle(
                                                      fontSize: isMobile?16:20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  IconButton(onPressed: (){}, icon: Icon(Icons.delete))
                                                ],
                                              ),

                                          ],
                                        ).setHorizontalPadding(context,enableMediaQuery: false,10 );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: Constants.mediaQuery.height*0.4,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                              ),
                            ),
                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Spacer(),
                                    Text(
                                      "التوصيات",
                                      textAlign: TextAlign.center,
                                      style: Constants.theme.textTheme.titleLarge?.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Spacer(),
                                    // IconButton(
                                    //   onPressed: () {
                                    //     showDialog(
                                    //       context: context,
                                    //       builder: (context) {
                                    //         return AlertDialog(
                                    //           backgroundColor: Colors.black,
                                    //           content: SizedBox(height: Constants.mediaQuery.height * 0.6,
                                    //               width: Constants.mediaQuery.width * 0.45,
                                    //               child: Column(
                                    //                 crossAxisAlignment: CrossAxisAlignment.stretch,
                                    //                 children: [
                                    //                   Container(
                                    //                     alignment: Alignment.center,
                                    //                     decoration: BoxDecoration(
                                    //                       borderRadius: BorderRadius.circular(10),
                                    //                       border: Border.all(color: Constants.theme.primaryColor, width: 2.5,
                                    //                       ),
                                    //                     ),
                                    //                     child: Text(
                                    //                         "اختر من التوصيات",
                                    //                         style: Constants.theme.textTheme.titleLarge
                                    //                     ),
                                    //                   ),
                                    //                   //for(int index = 0; index <selectedAdvices.length; index++)
                                    //                   CheckBoxQuestion(
                                    //                     previous: selectedAdvices.isNotEmpty ? selectedAdvices[0] : [],
                                    //                     items: advicesList,
                                    //                     onChanged: (value) {
                                    //                       setState(() {
                                    //                         if (selectedAdvices.isEmpty) {
                                    //                           selectedAdvices.add(value!);
                                    //                           print("------------->>"+selectedAdvices.toString());
                                    //                         } else {
                                    //                           selectedAdvices[0] = value!;
                                    //                         }
                                    //                       });
                                    //                     },
                                    //                   ),
                                    //
                                    //
                                    //                   // Expanded(
                                    //                   //   child: ListView.builder(
                                    //                   //     itemCount: advicesList.length,
                                    //                   //     itemBuilder: (context, index) {
                                    //                   //       return CheckBoxQuestion(
                                    //                   //         previous: selectedAdvices[index],
                                    //                   //         items: advicesList,
                                    //                   //         onChanged: (value) {
                                    //                   //           setState(() {
                                    //                   //             selectedAdvices[index] = value!;
                                    //                   //           });
                                    //                   //         },
                                    //                   //       );
                                    //                   //     },
                                    //                   //   ),
                                    //                   // )
                                    //                 ],
                                    //               )),
                                    //           actions: [
                                    //             TextButton(
                                    //               onPressed: () {
                                    //                 Navigator.of(context).pop();
                                    //                 addAdvices(adviceId, patient["id"]);
                                    //
                                    //               },
                                    //               child: Container(
                                    //                   decoration: BoxDecoration(
                                    //                     borderRadius: BorderRadius.circular(10),
                                    //                     border: Border.all(color: Constants.theme.primaryColor, width: 2.5,),
                                    //                   ),
                                    //                   child: Text(
                                    //                       "موافق", style: Constants.theme.textTheme.bodyMedium
                                    //                   ).setHorizontalPadding(context, enableMediaQuery: false, 20)),
                                    //             ),],);
                                    //       },
                                    //     );
                                    //   },
                                    //   icon: Icon(Icons.add_circle_rounded),
                                    // )
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.black,
                                              content: SizedBox(
                                                height: Constants.mediaQuery.height * 0.6,
                                                width: Constants.mediaQuery.width * 0.45,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                                  children: [
                                                    Container(
                                                      alignment: Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        border: Border.all(color: Constants.theme.primaryColor, width: 2.5),
                                                      ),
                                                      child: Text(
                                                        "اختر من التوصيات",
                                                        style: Constants.theme.textTheme.titleLarge,
                                                      ),
                                                    ),
                                                    CheckBoxQuestion(
                                                      previous: selectedAdviceIds,
                                                      items: advicesList,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          selectedAdviceIds = value ?? [];
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    if (selectedAdviceIds.isNotEmpty) {
                                                      for (var adviceId in selectedAdviceIds) {
                                                        addAdvices(adviceId, patient["id"]);
                                                      }
                                                    }
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(color: Constants.theme.primaryColor, width: 2.5),
                                                    ),
                                                    child: Text(
                                                      "موافق", style: Constants.theme.textTheme.bodyMedium,
                                                    ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(Icons.add_circle_rounded),
                                    ),

                                  ],
                                ).setVerticalPadding(context,enableMediaQuery: false, 3),

                                Divider(
                                  thickness: 2,
                                  color: Colors.black,

                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: advices.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                advices[index]["text"],
                                                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                                  color: Colors.black,
                                                  fontSize: isMobile?16:20
                                                ),
                                              ),
                                              IconButton(onPressed: (){}, icon: Icon(Icons.delete))
                                            ],
                                          ).setHorizontalPadding(context,enableMediaQuery: false,10 ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ).setVerticalPadding(context,enableMediaQuery: false, 5),
                        ],
                      ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                    ],
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
  Future<void> fetchPointers() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/api/pointer',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["pointers"];
        List<Pointers> pointers = [];
        List<Pointers> pointers1Temp = [];
        List<Pointers> pointers2Temp = [];
        List<Pointers> pointers3Temp = [];

        pointers = data.map((json) => Pointers.fromJson(json)).toList();
        pointers.forEach(
              (pointer) {
            if (pointer.senarioId == 1) {
              pointers1Temp.add(pointer);
            } else if (pointer.senarioId == 2) {
              pointers2Temp.add(pointer);
            } else if (pointer.senarioId == 3) {
              pointers3Temp.add(pointer);
            }
          },
        );
        setState(() {
          pointers1 = pointers1Temp;
          pointers2 = pointers2Temp;
          pointers3 = pointers3Temp;
        });
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  Future<void> addPointers(int patientId, int pointerId) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/api/pationt/add-patient-pointer',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        }),
        data: {
          "patient_id": patientId,
          "pointer_id": pointerId,
        }
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["pointers"];
        List<Pointers> pointers = [];
        List<Pointers> pointers1Temp = [];
        List<Pointers> pointers2Temp = [];
        List<Pointers> pointers3Temp = [];

        pointers = data.map((json) => Pointers.fromJson(json)).toList();
        pointers.forEach(
              (pointer) {
            if (pointer.senarioId == 1) {
              pointers1Temp.add(pointer);
            } else if (pointer.senarioId == 2) {
              pointers2Temp.add(pointer);
            } else if (pointer.senarioId == 3) {
              pointers3Temp.add(pointer);
            }
          },
        );
        setState(() {
          pointers1 = pointers1Temp;
          pointers2 = pointers2Temp;
          pointers3 = pointers3Temp;
        });
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  Future<void> fetchAdvices() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/api/advice',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["advices"];
        print(data);
        List<Advices> advicesdata = [];
        advicesdata = data.map((json) => Advices.fromJson(json)).toList();
        setState(() {
          advicesList = advicesdata;
        });
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }
  Future<void> addAdvices(int adviceId, int patientId) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        '${Constants.baseUrl}/api/pationt/add-patient-advice',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token"),
        }),
        data: {
          "patient_id": patientId,
          "advice_id": adviceId,
        },
      );

      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response.data;

          // final List<Advices> data = response.data["advices"];
          // List<Advices> advicesdata = data.map((json) => Advices.fromJson(json)).toList();
          // setState(() {
          //   addAdvicesList = advicesdata;
          // });
        } else {
          print('Error: ${response.data["message"]}');
        }
      } else {
        print('Failed to load advices. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }




}
