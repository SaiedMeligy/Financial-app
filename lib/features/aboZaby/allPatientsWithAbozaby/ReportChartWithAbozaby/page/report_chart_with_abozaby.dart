import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/tab_item_widget.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_circular_slider/multi_circular_slider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:html' as html;


import '../../../../../core/config/cash_helper.dart';
import '../../../../../domain/entities/AdviceMode.dart';
import '../../../../../domain/entities/QuestionModel.dart';

class ReportChartViewWithAbozaby extends StatefulWidget {
  final int? senario_id;
  final dynamic pationt_data;

  ReportChartViewWithAbozaby({super.key, required this.pationt_data, this.senario_id});

  @override
  State<ReportChartViewWithAbozaby> createState() => _ReportChartViewWithAbozabyState();
}

class _ReportChartViewWithAbozabyState extends State<ReportChartViewWithAbozaby> {
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
            List<int> selectedPointersIds = [];



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
                actions: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),

                    ////////////////////////////
                    child: IconButton(
                      icon: Icon(Icons.print, color: Colors.black),
                      onPressed: () async {
                        print('sssssssssssssssssssssssss');
                        final pdf = pw.Document();
                        final fontData = await rootBundle.load('assets/fonts/Amiri-Bold.ttf');
                        final ttf = pw.Font.ttf(fontData);

                        // final image = pw.MemoryImage(
                        //   (await rootBundle.load('assets/images/back.jpg')).buffer.asUint8List(),
                        // );
                        await Future.delayed(Duration(seconds: 1));
                        pdf.addPage(
                          pw.Page(
                            build: (pw.Context context) {
                              return pw.Directionality(
                              textDirection: pw.TextDirection.rtl,
                                  child:pw.Column(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                        width: 1,
                                      ),
                                      borderRadius: pw.BorderRadius.circular(10),
                                    ),
                                    child: pw.Center(
                                      child: pw.Column(
                                        mainAxisAlignment: pw.MainAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                            "السيناريوالأول(الحالات المتوازنة نسبيا) : " + double.parse(senario1).toStringAsFixed(2) + "%",
                                            style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                            textDirection: pw.TextDirection.rtl,
                                          ),
                                          pw.Text(
                                            "السيناريوالثاني(للحالات الغير متوازنة في الصرف) : " + double.parse(senario2).toStringAsFixed(2) + "%",
                                            style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                            textDirection: pw.TextDirection.rtl,
                                          ),
                                          pw.Text(
                                            "السيناريوالثالث(للحالات المتعثرة ماليا) : " + double.parse(senario3).toStringAsFixed(2) + "%",
                                            style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                            textDirection: pw.TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  pw.SizedBox(height: 20),
                                  pw.Table(
                                    border: pw.TableBorder.all(
                                      color: PdfColors.black,
                                      width: 1,
                                    ),
                                    children: [
                                      pw.TableRow(
                                        children: [
                                          pw.Center(child:
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.all(5.0),
                                            child: pw.Text(
                                              "المؤشرات",
                                              style: pw.TextStyle(font: ttf, fontSize: 12),
                                              textDirection: pw.TextDirection.rtl,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                    ]
                                  ),
                                  pw.Table(
                                    border: pw.TableBorder.all(
                                      color: PdfColors.black,
                                      width: 1,
                                    ),
                                    children: [
                                      pw.TableRow(
                                        children: [
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.all(8.0),
                                            child: pw.Text(
                                              "السيناريو الثالث",
                                              style: pw.TextStyle(font: ttf, fontSize: 12),
                                              textDirection: pw.TextDirection.rtl,
                                            ),
                                          ),
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.all(8.0),
                                            child: pw.Text(
                                              "السيناريو الثانى",
                                              style: pw.TextStyle(font: ttf, fontSize: 12),
                                              textDirection: pw.TextDirection.rtl,
                                            ),
                                          ),
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.all(8.0),
                                            child: pw.Text(
                                              "السيناريو الاول",
                                              style: pw.TextStyle(font: ttf, fontSize: 12),
                                              textDirection: pw.TextDirection.rtl,
                                            ),
                                          ),


                                        ],
                                      ),
                                      // Add more rows as needed
                                      pw.TableRow(
                                        children: [
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.all(5.0),
                                            child: pw.Container(
                                              height: 250,
                                              child: pw.Column(
                                                children: [
                                                  for (var index = 0; index < pointers3Temp.length; index++)
                                                    pw.Container(
                                                      margin: const pw.EdgeInsets.only(bottom: 5.0),
                                                      child: pw.Column(
                                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                        children: [
                                                          pw.Column(
                                                            mainAxisAlignment: pw.MainAxisAlignment.start,
                                                            children: [
                                                              pw.Table(
                                                                // border: pw.TableBorder.all(color: PdfColors.black),
                                                                children: [
                                                                  for (var index = 0; index < pointers3Temp.length; index++)
                                                                    ...[
                                                                      for (var pointer in pointers3Temp[index]["pationt_pointers"] ?? [])
                                                                        pw.TableRow(
                                                                          children: [
                                                                            pw.Padding(
                                                                              padding: const pw.EdgeInsets.all(2.0),
                                                                              child: pw.Text(
                                                                                pointer["text"],
                                                                                style: pw.TextStyle(
                                                                                  font: ttf,
                                                                                  fontSize: 8,
                                                                                  color: PdfColors.black,
                                                                                ),
                                                                                textDirection: pw.TextDirection.rtl,
                                                                              ),
                                                                            ),
                                                                          ],),],
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],),
                                                    ),],),),),
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.all(5.0),
                                            child: pw.Container(
                                              height: 250,
                                              child: pw.Column(
                                                children: [
                                                  for (var index = 0; index < pointers2Temp.length; index++)
                                                    pw.Container(
                                                      margin: const pw.EdgeInsets.only(bottom: 5.0),
                                                      child: pw.Column(
                                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                        children: [
                                                          pw.Column(
                                                            mainAxisAlignment: pw.MainAxisAlignment.start,
                                                            children: [
                                                              pw.Table(
                                                                // border: pw.TableBorder.all(color: PdfColors.black),
                                                                children: [
                                                                  for (var index = 0; index < pointers2Temp.length; index++)
                                                                    ...[
                                                                      for (var pointer in pointers2Temp[index]["pationt_pointers"] ?? [])
                                                                        pw.TableRow(
                                                                          children: [
                                                                            pw.Padding(
                                                                              padding: const pw.EdgeInsets.all(2.0),
                                                                              child: pw.Text(
                                                                                pointer["text"],
                                                                                style: pw.TextStyle(
                                                                                  font: ttf,
                                                                                  fontSize: 8,
                                                                                  color: PdfColors.black,
                                                                                ),
                                                                                textDirection: pw.TextDirection.rtl,
                                                                              ),
                                                                            ),
                                                                          ],),],
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],),
                                                    ),],),),),
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.all(5.0),
                                            child: pw.Container(
                                              height: 220,
                                              child: pw.Column(
                                                children: [
                                  for (var index = 0; index < pointers1Temp.length; index++)
                                    pw.Container(
                                      margin: const pw.EdgeInsets.only(bottom: 5.0),
                                      child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Column(
                                            mainAxisAlignment: pw.MainAxisAlignment.start,
                                            children: [
                                              pw.Table(
                                                // border: pw.TableBorder.all(color: PdfColors.black),
                                                children: [
                                                  for (var index = 0; index < pointers1Temp.length; index++)
                                                    ...[
                                                      for (var pointer in pointers1Temp[index]["pationt_pointers"] ?? [])
                                                        pw.TableRow(
                                                          children: [
                                                            pw.Padding(
                                                              padding: const pw.EdgeInsets.all(2.0),
                                                              child: pw.Text(
                                                                pointer["text"],
                                                                style: pw.TextStyle(
                                                                  font: ttf,
                                                                  fontSize: 8,
                                                                  color: PdfColors.black,
                                                                ),
                                                                textDirection: pw.TextDirection.rtl,
                              ),
                              ),
                              ],),],
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],),
                                    ),],),),),



                                        ],
                                      ),

                                    ],
                                  ),
                                  pw.SizedBox(height: 20),
                                  pw.Table(
                                    border: pw.TableBorder.all(
                                      color: PdfColors.black,
                                      width: 1,
                                    ),
                                    children: [
                                      pw.TableRow(
                                        children: [
                                          pw.Center(
                              child:pw.Padding(
                                            padding: const pw.EdgeInsets.all(5.0),
                                            child: pw.Text(
                                              "التوصيات",
                                              style: pw.TextStyle(font: ttf, fontSize: 12),
                                              textDirection: pw.TextDirection.rtl,
                                            ),
                                          ),
                                          ),
                                        ],
                                      ),
                                      // Add more rows as needed
                                      pw.TableRow(
                                        children: [
                                          pw.Padding(
                                            padding: const pw.EdgeInsets.all(5.0),
                                            child: pw.Container(
                                              height: 150,
                                              child: pw.Column(
                                                children: [
                                                  for (var index = 0; index < pointers1Temp.length; index++)
                                                    pw.Container(
                                                      margin: const pw.EdgeInsets.only(bottom: 5.0),
                                                      child: pw.Column(
                                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                                        children: [
                                                          pw.Column(
                                                            mainAxisAlignment: pw.MainAxisAlignment.start,
                                                            children: [
                                                              pw.Table(
                                                                // border: pw.TableBorder.all(color: PdfColors.black),
                                                                children: [
                                                                  for (var index = 0; index < advices.length; index++)
                                                                        pw.TableRow(
                                                                          children: [
                                                                            pw.Padding(
                                                                              padding: const pw.EdgeInsets.all(2.0),
                                                                              child: pw.Text(
                                                                                advices[index]["text"],
                                                                                style: pw.TextStyle(
                                                                                  font: ttf,
                                                                                  fontSize: 8,
                                                                                  color: PdfColors.black,
                                                                                ),
                                                                                textDirection: pw.TextDirection.rtl,
                                                                              ),
                                                                            ),
                                                                          ],),],

                                                              ),
                                                            ],
                                                          ),
                                                        ],),
                                                    ),],),),),

                                        ],
                                      ),

                                    ],

                                  )


                                ]
                                  ),
                              );
                            },
                          ),
                        );

                        try {
                          final pdfBytes = await pdf.save();
                          final blob = html.Blob([pdfBytes], 'application/pdf');
                          final url = html.Url.createObjectUrlFromBlob(blob);
                          html.window.open(url, '_blank');
                          html.Url.revokeObjectUrl(url);

                          // Use the printing package to handle printing
                          await Printing.layoutPdf(
                            onLayout: (PdfPageFormat format) async => pdf.save(),
                          );

                        } catch (e) {
                          print('Error: $e');
                        }
                      },
                    ),
                  ),

                ],
              ),
              body: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/back.jpg"),
                      fit: BoxFit.cover,
                      opacity: 0.1  ,
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
                                color: Constants.theme.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: isMobile?Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          isMobile?"السيناريوالأول \n(الحالات المتوازنة نسبيا) : "+double.parse(senario1).toStringAsFixed(2) + "%":"السيناريوالأول(الحالات المتوازنة نسبيا) : " + double.parse(senario1).toStringAsFixed(2) + "%",
                                          style:isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                                              fontSize: isMobile?16:24
                                          ):Constants.theme.textTheme.titleLarge
                                      ),
                                      Text(
                                        isMobile?"السيناريوالثاني \n(للحالات الغير متوازنة في الصرف) : " + double.parse(senario2).toStringAsFixed(2) + "%":"السيناريوالثاني(للحالات الغير متوازنة في الصرف) : " + double.parse(senario2).toStringAsFixed(2) + "%",
                                        style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile?16:24
                                        ):Constants.theme.textTheme.titleLarge,
                                      ),
                                      Text(
                                        isMobile?"السيناريوالثالث \n(للحالات المتعثرة ماليا) : " + double.parse(senario3).toStringAsFixed(2) + "%":"السيناريوالثالث(للحالات المتعثرة ماليا) : " + double.parse(senario3).toStringAsFixed(2) + "%",
                                        style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile?16:24
                                        ):Constants.theme.textTheme.titleLarge,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  MultiCircularSlider(
                                    size: isMobile?116:200,
                                    progressBarType: MultiCircularSliderType.circular,
                                    // values: countData,
                                    values: [
                                      pointers1Temp.isNotEmpty ? calculatePercentage(pointers1Temp[0]["pationt_pointers_count"] ?? 0, pointers1Temp[0]["pointers_count"] ?? 0) / 100 : 0,
                                      pointers2Temp.isNotEmpty ? calculatePercentage(pointers2Temp[0]["pationt_pointers_count"] ?? 0, pointers2Temp[0]["pointers_count"] ?? 0) / 100 : 0,
                                      pointers3Temp.isNotEmpty ? calculatePercentage(pointers3Temp[0]["pationt_pointers_count"] ?? 0, pointers3Temp[0]["pointers_count"] ?? 0) / 100 : 0,
                                    ],
                                    colors: [Colors.red, Colors.blue, Colors.green],
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
                              )
                                  :Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                          isMobile?"السيناريوالأول \n(الحالات المتوازنة نسبيا) : "+double.parse(senario1).toStringAsFixed(2) + "%":"السيناريوالأول(الحالات المتوازنة نسبيا) : " + double.parse(senario1).toStringAsFixed(2) + "%",
                                          style:isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                                              fontSize: isMobile?16:24
                                          ):Constants.theme.textTheme.titleLarge
                                      ),
                                      Text(
                                        isMobile?"السيناريوالثاني \n(للحالات الغير متوازنة في الصرف) : " + double.parse(senario2).toStringAsFixed(2) + "%":"السيناريوالثاني(للحالات الغير متوازنة في الصرف) : " + double.parse(senario2).toStringAsFixed(2) + "%",
                                        style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile?16:24
                                        ):Constants.theme.textTheme.titleLarge,
                                      ),
                                      Text(
                                        isMobile?"السيناريوالثالث \n(للحالات المتعثرة ماليا) : " + double.parse(senario3).toStringAsFixed(2) + "%":"السيناريوالثالث(للحالات المتعثرة ماليا) : " + double.parse(senario3).toStringAsFixed(2) + "%",
                                        style: isMobile? Constants.theme.textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile?16:24
                                        ):Constants.theme.textTheme.titleLarge,
                                      ),
                                    ],
                                  ),
                                  MultiCircularSlider(
                                    size: isMobile?116:200,
                                    progressBarType: MultiCircularSliderType.circular,
                                    // values: countData,
                                    values: [
                                      pointers1Temp.isNotEmpty ? calculatePercentage(pointers1Temp[0]["pationt_pointers_count"] ?? 0, pointers1Temp[0]["pointers_count"] ?? 0) / 100 : 0,
                                      pointers2Temp.isNotEmpty ? calculatePercentage(pointers2Temp[0]["pationt_pointers_count"] ?? 0, pointers2Temp[0]["pointers_count"] ?? 0) / 100 : 0,
                                      pointers3Temp.isNotEmpty ? calculatePercentage(pointers3Temp[0]["pationt_pointers_count"] ?? 0, pointers3Temp[0]["pointers_count"] ?? 0) / 100 : 0,
                                    ],
                                    colors: [Colors.red, Colors.blue, Colors.green],
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
                                  ],
                                ).setVerticalPadding(context,enableMediaQuery: false, 3),
                                Expanded(
                                  child: TabItemWidget(
                                    item1: "السيناريوالأول(الحالات المتوازنة نسبيا)",
                                    item2: "السيناريوالثاني(للحالات الغير متوازنة في الصرف)",
                                    item3: "السيناريوالثالث(للحالات المتعثرة ماليا)",
                                    firstWidget: Container(
                                      color: Constants.theme.primaryColor.withOpacity(0.4),
                                      child: ListView.builder(
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
                                              Expanded(
                                                child: Text(
                                                  pointer["text"],
                                                  style: TextStyle(
                                                    fontSize: isMobile?14:20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                            ],
                                          ).setHorizontalPadding(context,enableMediaQuery: false,10 );
                                        },
                                      ),
                                    ),
                                    secondWidget: Container(
                                      color: Constants.theme.primaryColor.withOpacity(0.4),
                                      child: ListView.builder(
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
                                                    Expanded(
                                                      child: Text(
                                                        pointer["text"],
                                                        style: TextStyle(
                                                          fontSize: isMobile?14:20,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ).setHorizontalPadding(context,enableMediaQuery: false,10 );
                                        },
                                      ),
                                    ),
                                    thirdWidget: Container(
                                      color: Constants.theme.primaryColor.withOpacity(0.4),
                                      child: ListView.builder(
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
                                                    Expanded(
                                                      child: Text(
                                                        pointer["text"],
                                                        style: TextStyle(
                                                          fontSize: isMobile?14:20,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                            ],
                                          ).setHorizontalPadding(context,enableMediaQuery: false,10 );
                                        },
                                      ),
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
                                  ],
                                ).setVerticalPadding(context,enableMediaQuery: false, 3),

                                Divider(
                                  thickness: 2,
                                  color: Colors.black,

                                ),
                                Expanded(

                                  child: Container(
                                    color: Constants.theme.primaryColor.withOpacity(0.4),
                                    child: ListView.builder(
                                      itemCount: advices.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    advices[index]["text"],
                                                    style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                                      color: Colors.black,
                                                      fontSize: isMobile?14:20
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ).setHorizontalPadding(context,enableMediaQuery: false,10 ),
                                          ],
                                        );
                                      },
                                    ),
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
  Future<void> addPointers(int pointerId, int patientId) async {
    final dio = Dio();
    try {
      final response = await dio.post(
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
        print('Success: ${response.data["message"]}');
        SnackBarService.showSuccessMessage(response.data["message"]);

      } else {
        print('Failed to add pointer. Status code: ${response.statusCode}');
        SnackBarService.showErrorMessage(response.data["message"]);
      }
    } catch (e) {
      print('Error occurred: $e');
      SnackBarService.showErrorMessage(e.toString());
    }
  }
  Future<void> deletePointers(int patientId, int pointerId) async {
    final dio = Dio();
    try {
      final response = await dio.post(
        '${Constants.baseUrl}/api/pationt/delete-patient-pointer',
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
        print('------------------>>>${response.data["message"]}');
        SnackBarService.showSuccessMessage(response.data["message"]);

      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      SnackBarService.showErrorMessage(e.toString());

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
          print('${response.data["message"]}');
          SnackBarService.showSuccessMessage(response.data["message"]);


        } else {
          print('Error: ${response.data["message"]}');
          SnackBarService.showErrorMessage(response.data["message"]);
        }
      } else {
        print('Failed to load advices. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      SnackBarService.showErrorMessage(e.toString());

    }
  }
  Future<void> deleteAdvices(int patientId, int adviceId) async {
    final dio = Dio();
    try {
      final response = await dio.post(
          '${Constants.baseUrl}/api/pationt/delete-patient-advice',
          options: Options(headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          }),
          data: {
            "patient_id": patientId,
            "advice_id": adviceId,
          }
      );
      if (response.statusCode == 200) {
        print('mmmmmmmmmmmmm${response.data["message"]}');
        SnackBarService.showSuccessMessage(response.data["message"]);
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      SnackBarService.showErrorMessage(e.toString());
    }
  }





}
