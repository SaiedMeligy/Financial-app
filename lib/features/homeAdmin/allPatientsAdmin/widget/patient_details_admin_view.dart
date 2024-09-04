import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:flutter/rendering.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/ReportChartWithAdmin/page/report_chart_with_admin.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/patientSessionViewWithAdmin/page/patient_session_view_with_admin.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/updateForm/page/update_form_admin_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:printing/printing.dart';

import '../../../../domain/entities/AllPatientModel.dart';
import '../replace_advisor/page/replace_advisor_view.dart';

class PatientDetailsAdminView extends StatefulWidget {
  PatientDetailsAdminView({super.key, required this.pationt_data});
  final dynamic pationt_data;

  @override
  State<PatientDetailsAdminView> createState() => _PatientDetailsAdminViewState();
}

class _PatientDetailsAdminViewState extends State<PatientDetailsAdminView> {
  late AddSessionCubit _patientFormViewCubit;
  bool isMobile = false;

  @override
  void initState() {
    super.initState();
    _patientFormViewCubit = AddSessionCubit();
    _patientFormViewCubit.getPatientDetails(widget.pationt_data.nationalId);
  }

  @override
  void dispose() {
    _patientFormViewCubit.close(); // Close the cubit when done
    super.dispose();
  }

  List<dynamic> filterQuestionsWithAnswer(List<dynamic> answers) {
    return answers;
    // where((answer) {
    //   return answer['question_options'].any((option) {
    //     if (option['answer'] is String) {
    //       return option['answer'] == "1";
    //     } else if (option['answer'] is int) {
    //       return option['answer'] == 1;
    //     }
    //     return false;
    //   });
    // }).toList();
  }

    Future<void> _printPDF() async {
      try {
        final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
        final ttf = pw.Font.ttf(font);
        final pdf = pw.Document();
        pdf.addPage(
          pw.Page(
            build: (pw.Context context) {
              return pw.Center(
                child: pw.Text(
                  "Example PDF Content",
                  style: pw.TextStyle(
                    fontSize: 30,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.red,
                    font: ttf,
                  ),
                ),
              );
            },
          ),
        );

        // Save the PDF as bytes
        final pdfBytes = await pdf.save();

        // Create a blob and open in a new tab
        final blob = html.Blob([pdfBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        html.window.open(url, '_blank');
        html.Url.revokeObjectUrl(url);
      } catch (e) {
        print('Error: $e');
      }
    }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;

        return BlocBuilder<AddSessionCubit, AddSessionStates>(
        bloc: _patientFormViewCubit,
        builder: (context, state) {
          if (state is LoadingAddSessionState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorFormState) {
            Navigator.pop(context);
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessPatientNationalIdState) {
            var formData = state.result.data["pationt"]["form"];
            var patient = formData["pationt"];
            var advicor = formData["advicor"];
            var answers = formData["answers"];
            var comments = formData["comments"];
            var consultation = formData["consultationService"];
            var filteredAnswers = filterQuestionsWithAnswer(answers);
            print("mmmmmmmm"+formData.toString());

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/back.jpg"),
                      fit: BoxFit.cover,
                      opacity: 0.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: isMobile?Constants.mediaQuery.height * 0.26:Constants.mediaQuery.height * 0.2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Constants.theme.primaryColor,
                        ),
                        child: isMobile?
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color:  Colors.white,
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                child: IconButton(
                                    icon: const Icon(Icons.arrow_forward,color: Colors.black),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.edit, color: Colors.black),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return UpdateFormAdminView(pationt_data: widget.pationt_data);
                                      }));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: Icon(CupertinoIcons.arrow_up_arrow_down_circle, color: Colors.black),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return ReplaceAdvisorView(pationt_data: widget.pationt_data);
                                      }));
                                    },
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.print, color: Colors.black),
                                      onPressed: () async {
                                        print('sssssssssssssssssssssssss');
                                        final pdf = pw.Document();
                                        // final notoSans = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
                                        // final ttf = pw.Font.ttf(notoSans);
                                        final fontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
                                        final ttf = pw.Font.ttf(fontData);

                                        final image = pw.MemoryImage(
                                          (await rootBundle.load('assets/images/back.jpg')).buffer.asUint8List(),
                                        );
                                        await Future.delayed(Duration(seconds: 1));
                                        pdf.addPage(
                                          pw.Page(
                                            build: (pw.Context context) {
                                              return pw.Container(
                                                // decoration: pw.BoxDecoration(
                                                //
                                                //   image: pw.DecorationImage(image: image,fit: pw.BoxFit.cover,
                                                //   ),

                                                //),
                                                child:pw.Center(
                                                  child: pw.Column(
                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                    children: [
                                                      pw.Container(
                                                          decoration: pw.BoxDecoration(
                                                              border: pw.Border.all(
                                                                  color: PdfColors.black,
                                                                  width: 1
                                                              ),
                                                              borderRadius: pw.BorderRadius.circular(10)
                                                          ),
                                                          child: pw.Row(
                                                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                pw.SizedBox(width: 20,),
                                                                pw.Container(
                                                                  alignment: pw.Alignment.centerRight,
                                                                  child: pw.Text(
                                                                    "${patient["name"]}" ,
                                                                    style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black ),
                                                                    textDirection: pw.TextDirection.rtl,
                                                                  ),
                                                                ),
                                                                pw.Container(
                                                                  alignment: pw.Alignment.centerRight,
                                                                  child: pw.Text(
                                                                    "اسم الحالة" ,
                                                                    style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black ),
                                                                    textDirection: pw.TextDirection.rtl,
                                                                  ),
                                                                ),
                                                                pw.SizedBox(width: 20,),
                                                              ]
                                                          )
                                                      ),

                                                      pw.Container(
                                                          margin: pw.EdgeInsets.all(5),
                                                          decoration: pw.BoxDecoration(
                                                              border: pw.Border.all(
                                                                  color: PdfColors.black,
                                                                  width: 1
                                                              ),
                                                              borderRadius: pw.BorderRadius.circular(10)
                                                          ),
                                                          child: pw.Row(
                                                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                pw.SizedBox(width: 20,),
                                                                pw.Container(
                                                                  alignment: pw.Alignment.centerRight,
                                                                  child: pw.Text(
                                                                    "${patient["national_id"]}" ,
                                                                    style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black ),
                                                                    textDirection: pw.TextDirection.rtl,
                                                                  ),
                                                                ),
                                                                pw.Container(
                                                                  alignment: pw.Alignment.centerRight,
                                                                  child: pw.Text(
                                                                    "رقم الهوية الأماراتية" ,
                                                                    style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                                                    textDirection: pw.TextDirection.rtl,
                                                                  ),
                                                                ),
                                                                pw.SizedBox(width: 20,),
                                                              ]
                                                          )
                                                      ),

                                                      pw.Container(
                                                          margin: pw.EdgeInsets.all(5),
                                                          decoration: pw.BoxDecoration(
                                                              color: PdfColors.white,
                                                              border: pw.Border.all(
                                                                  width: 1
                                                              ),
                                                              borderRadius: pw.BorderRadius.circular(10)
                                                          ),
                                                          child: pw.Row(
                                                              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                pw.SizedBox(width: 20,),
                                                                pw.Container(
                                                                  alignment: pw.Alignment.centerRight,
                                                                  child: pw.Text(
                                                                    "${advicor["name"]}" ,
                                                                    style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                                                    textDirection: pw.TextDirection.rtl,
                                                                  ),
                                                                ),
                                                                pw.Container(
                                                                  alignment: pw.Alignment.centerRight,
                                                                  child: pw.Text(
                                                                    "اسم الاستشارى" ,
                                                                    style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                                                    textDirection: pw.TextDirection.rtl,
                                                                  ),
                                                                ),
                                                                pw.SizedBox(width: 20,),
                                                              ]
                                                          )
                                                      ),
                                                      pw.Container(
                                                        width: 350,
                                                        alignment: pw.Alignment.center,
                                                        child: pw.Text(formData["need_other_session"]==1?" الحالة بحاجه الى جلسة اخرى ":" الحالة ليست بحاجه الى جلسة اخرى  ",
                                                          style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black,),
                                                          textDirection: pw.TextDirection.rtl,
                                                        ),

                                                      ),
                                                      pw.SizedBox(height: 5,),
                                                      pw.Container(
                                                        width: 350,
                                                        alignment: pw.Alignment.center,

                                                        child: pw.Text(" ملاحظات الاستشارى ",
                                                          style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black,),
                                                          textDirection: pw.TextDirection.rtl,
                                                        ),

                                                      ),
                                                      pw.SizedBox(width:40),
                                                      pw.Column(
                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                          children: [
                                                            pw.Container(
                                                              alignment: pw.Alignment.center,
                                                              child: pw.Text(
                                                                DividCommentsText("${comments}"),
                                                                style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                                                textDirection: pw.TextDirection.rtl,
                                                              ),),
                                                          ]
                                                      ),

                                                      pw.Divider(
                                                        thickness: 1,
                                                        color: PdfColors.grey,
                                                      ),
                                                      pw.Container(
                                                          height: Constants.mediaQuery.height * 0.10,
                                                          margin: pw.EdgeInsets.all(5),
                                                          child: pw.Row(
                                                              mainAxisAlignment: pw.MainAxisAlignment.center,
                                                              children: [
                                                                pw.Container(
                                                                  alignment: pw.Alignment.centerRight,
                                                                  child: pw.Text(
                                                                    DividCommentsText(
                                                                        "${consultation["name"]}"),
                                                                    style: pw.TextStyle(
                                                                        font: ttf,
                                                                        fontSize: 14,
                                                                        color: PdfColors.black),
                                                                    textDirection: pw
                                                                        .TextDirection
                                                                        .rtl,
                                                                  ),
                                                                ),
                                                                pw.Container(
                                                                  alignment: pw.Alignment.centerRight,
                                                                  child: pw.Text(
                                                                    "الخدمة الاستشارية: ",
                                                                    style: pw.TextStyle(
                                                                        font: ttf,
                                                                        fontSize: 16,
                                                                        color: PdfColors.black),
                                                                    textDirection: pw
                                                                        .TextDirection
                                                                        .rtl,
                                                                  ),
                                                                ),
                                                              ]
                                                          )
                                                      ),
                                                      pw.Row(
                                                          children: [
                                                            pw.SizedBox(width: 10,),
                                                            pw.Container(
                                                              alignment: pw.Alignment.center,
                                                              child: pw.Text(
                                                                DividCommentsText(" وصف الخدمة الاستشارية :${consultation["description"]}"),
                                                                style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                                                textDirection: pw.TextDirection.rtl,
                                                              ),
                                                            ),
                                                            pw.SizedBox(width: 10,),
                                                          ]
                                                      )


                                                    ],
                                                  ),
                                                ),
                                              );

                                            },
                                          ),
                                        );
                                        List<List<dynamic>> answe = [] ;
                                        print("pppppppppppp"+filteredAnswers.length.toString());
                                        print("fffffffffffff"+(widget.pationt_data as Pationts).toString());

                                        for (int count = 0; count < (filteredAnswers.length / 9).ceil(); count++) {
                                          List currentList = [];

                                          for (int i = 0; i < 9; i++) {
                                            int index = count * 9 + i;
                                            if (index < filteredAnswers.length) {
                                              currentList.add(filteredAnswers[index]);
                                            } else {
                                              break;
                                            }
                                          }

                                          if (currentList.isNotEmpty) {
                                            answe.add(currentList);
                                          }
                                        }

                                        for (int y = 0; y < answe.length; y++) {
                                          pdf.addPage(
                                            pw.Page(
                                              build: (pw.Context context) {
                                                return pw.Column(
                                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                                  children: [
                                                    for (int i = 0; i < answe[y].length; i++) ...[
                                                      pw.Container(
                                                        height: answe[y][i]["question_options"]
                                                            .where((option) =>
                                                        (option['type'] == 1 || option['type'] == 2) && option['answer'] == "1" ||
                                                            (option['type'] == 3 && option['answer'] != null))
                                                            .length *
                                                            ((answe[y][i]["question_options"].where((option) =>
                                                            (option['type'] == 1 || option['type'] == 2) && option['answer'] == "1" ||
                                                                (option['type'] == 3 && option['answer'] != null))
                                                                .length > 3)
                                                                ? 20 // Height when length > 3
                                                                : (answe[y][i]["question_options"]
                                                                .where((option) =>
                                                            (option['type'] == 1 || option['type'] == 2) && option['answer'] == "1" ||
                                                                (option['type'] == 3 && option['answer'] != null))
                                                                .length > 2)
                                                                ? 40 // Height when length is 3
                                                                : 45 // Height when length is 2 or less
                                                            ),
                                                        child: pw.Column(
                                                          mainAxisAlignment: pw.MainAxisAlignment.start,
                                                          children: [
                                                            pw.Container(
                                                              height: answe[y][i]["title"].toString().split(" ").length > 15 ? 30 : 15,
                                                              margin: pw.EdgeInsets.only(left: 10),
                                                              child: pw.Row(
                                                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                                                children: [
                                                                  pw.SizedBox(width: 5),
                                                                  pw.Text(
                                                                    DividText("${answe[y][i]['title']}"),
                                                                    style: pw.TextStyle(font: ttf, fontSize: 8, color: PdfColors.black),
                                                                    textDirection: pw.TextDirection.rtl,
                                                                    maxLines: 5,
                                                                  ),
                                                                  pw.SizedBox(width: 5),
                                                                ],
                                                              ),
                                                            ),
                                                            for (int x = 0; x < answe[y][i]["question_options"].length; x++) ...[
                                                              if (answe[y][i]["question_options"][x]['type'] == 1 && answe[y][i]["question_options"][x]['answer'] == "1") ...[
                                                                pw.Row(
                                                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                                                  children: [
                                                                    pw.Text(
                                                                      "${answe[y][i]["question_options"][x]['title']}",
                                                                      style: pw.TextStyle(font: ttf, fontSize: 8),
                                                                      textDirection: pw.TextDirection.rtl,
                                                                    ),
                                                                    pw.SizedBox(width: 10),
                                                                  ],
                                                                ),
                                                              ],
                                                              if (answe[y][i]["question_options"][x]['type'] == 2 && answe[y][i]["question_options"][x]['answer'] == "1") ...[
                                                                pw.Row(
                                                                  mainAxisAlignment: pw.MainAxisAlignment.end,
                                                                  children: [
                                                                    pw.Text(
                                                                      "${answe[y][i]["question_options"][x]['title']}",
                                                                      style: pw.TextStyle(font: ttf, fontSize: 8),
                                                                      textDirection: pw.TextDirection.rtl,
                                                                    ),
                                                                    pw.SizedBox(width: 10),
                                                                  ],
                                                                ),
                                                              ],
                                                              if (answe[y][i]["question_options"][x]['type'] == 3 && answe[y][i]["question_options"][x]['answer'] != null) ...[
                                                                pw.Directionality(
                                                                  textDirection: pw.TextDirection.rtl,
                                                                  child: pw.Row(
                                                                    mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                    children: [
                                                                      pw.Text(
                                                                        "${answe[y][i]["question_options"][x]['title']} : ",
                                                                        style: pw.TextStyle(font: ttf, fontSize: 8),
                                                                        textDirection: pw.TextDirection.rtl,
                                                                      ),
                                                                      pw.Text(
                                                                        "${answe[y][i]["question_options"][x]['answer']}",
                                                                        style: pw.TextStyle(font: ttf, fontSize: 8),
                                                                        textDirection: pw.TextDirection.rtl,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                pw.SizedBox(width: 10),
                                                              ],
                                                            ],
                                                          ],
                                                        ),
                                                      ),
                                                      pw.Divider(
                                                        thickness: 1,
                                                        color: PdfColors.grey,
                                                      ),
                                                    ],
                                                  ],
                                                );
                                              },
                                            ),
                                          );
                                        }

                                        try {
                                          // Save the PDF as bytes
                                          final pdfBytes = await pdf.save();

                                          // Create a blob and open in a new tab
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
                                    )
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: const Icon(Icons.list, color: Colors.black),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return PatientSessionViewWithAdmin(
                                          pationt_data: widget.pationt_data,
                                        );
                                      }));
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.thumb_up_alt_outlined, color: Colors.black),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        return ReportChartViewWithAdmin(
                                          pationt_data: widget.pationt_data,
                                        );
                                      }));
                                    },
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "الحالة : ${patient["name"]}  ",
                                  style:  TextStyle(
                                    fontSize: isMobile?16:24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "الاستشارى : ${advicor["name"]}  ",
                                  style:  TextStyle(
                                    fontSize: isMobile?16:24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "تاريخ الجلسة : ${formData["date"]}  ",
                                  style:  TextStyle(
                                    fontSize: isMobile?16:24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.edit, color: Colors.black),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return UpdateFormAdminView(pationt_data: widget.pationt_data);
                                          }));
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: IconButton(
                                        icon: Icon(CupertinoIcons.arrow_up_arrow_down_circle, color: Colors.black),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return ReplaceAdvisorView(pationt_data: widget.pationt_data);
                                          }));
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.print, color: Colors.black),
                                    onPressed: () async {
                                      print('sssssssssssssssssssssssss');
                                      final pdf = pw.Document();
                                      // final notoSans = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
                                      // final ttf = pw.Font.ttf(notoSans);
                                      final fontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
                                      final ttf = pw.Font.ttf(fontData);

                                      final image = pw.MemoryImage(
                                        (await rootBundle.load('assets/images/back.jpg')).buffer.asUint8List(),
                                      );
                                      await Future.delayed(Duration(seconds: 1));
                                      pdf.addPage(
                                        pw.Page(
                                          build: (pw.Context context) {
                                            return pw.Container(
                                              // decoration: pw.BoxDecoration(
                                              //
                                              //   image: pw.DecorationImage(image: image,fit: pw.BoxFit.cover,
                                              //   ),

                                              //),
                                              child:pw.Center(
                                                child: pw.Column(
                                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                                  children: [
                                                    pw.Container(
                                                        decoration: pw.BoxDecoration(
                                                            border: pw.Border.all(
                                                                color: PdfColors.black,
                                                                width: 1
                                                            ),
                                                            borderRadius: pw.BorderRadius.circular(10)
                                                        ),
                                                        child: pw.Row(
                                                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              pw.SizedBox(width: 20,),
                                                              pw.Container(
                                                                alignment: pw.Alignment.centerRight,
                                                                child: pw.Text(
                                                                  "${patient["name"]}" ,
                                                                  style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black ),
                                                                  textDirection: pw.TextDirection.rtl,
                                                                ),
                                                              ),
                                                              pw.Container(
                                                                alignment: pw.Alignment.centerRight,
                                                                child: pw.Text(
                                                                  "اسم الحالة" ,
                                                                  style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black ),
                                                                  textDirection: pw.TextDirection.rtl,
                                                                ),
                                                              ),
                                                              pw.SizedBox(width: 20,),
                                                            ]
                                                        )
                                                    ),

                                                    pw.Container(
                                                        margin: pw.EdgeInsets.all(5),
                                                        decoration: pw.BoxDecoration(
                                                            border: pw.Border.all(
                                                                color: PdfColors.black,
                                                                width: 1
                                                            ),
                                                            borderRadius: pw.BorderRadius.circular(10)
                                                        ),
                                                        child: pw.Row(
                                                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              pw.SizedBox(width: 20,),
                                                              pw.Container(
                                                                alignment: pw.Alignment.centerRight,
                                                                child: pw.Text(
                                                                  "${patient["national_id"]}" ,
                                                                  style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black ),
                                                                  textDirection: pw.TextDirection.rtl,
                                                                ),
                                                              ),
                                                              pw.Container(
                                                                alignment: pw.Alignment.centerRight,
                                                                child: pw.Text(
                                                                  "رقم الهوية الأماراتية" ,
                                                                  style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black),
                                                                  textDirection: pw.TextDirection.rtl,
                                                                ),
                                                              ),
                                                              pw.SizedBox(width: 20,),
                                                            ]
                                                        )
                                                    ),

                                                    pw.Container(
                                                        margin: pw.EdgeInsets.all(5),
                                                        decoration: pw.BoxDecoration(
                                                            color: PdfColors.white,
                                                            border: pw.Border.all(
                                                                width: 1
                                                            ),
                                                            borderRadius: pw.BorderRadius.circular(10)
                                                        ),
                                                        child: pw.Row(
                                                            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              pw.SizedBox(width: 20,),
                                                              pw.Container(
                                                                alignment: pw.Alignment.centerRight,
                                                                child: pw.Text(
                                                                  "${advicor["name"]}" ,
                                                                  style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black),
                                                                  textDirection: pw.TextDirection.rtl,
                                                                ),
                                                              ),
                                                              pw.Container(
                                                                alignment: pw.Alignment.centerRight,
                                                                child: pw.Text(
                                                                  "اسم الاستشارى" ,
                                                                  style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black),
                                                                  textDirection: pw.TextDirection.rtl,
                                                                ),
                                                              ),
                                                              pw.SizedBox(width: 20,),
                                                            ]
                                                        )
                                                    ),
                                                    pw.Container(
                                                      width: 350,
                                                      alignment: pw.Alignment.center,
                                                      child: pw.Text(formData["need_other_session"]==1?" الحالة بحاجه الى جلسة اخرى ":" الحالة ليست بحاجه الى جلسة اخرى  ",
                                                        style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black,),
                                                        textDirection: pw.TextDirection.rtl,
                                                      ),

                                                    ),
                                                    pw.SizedBox(height: 5,),
                                                    pw.Container(
                                                      width: 350,
                                                      alignment: pw.Alignment.center,

                                                      child: pw.Text(" ملاحظات الاستشارى ",
                                                        style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black,),
                                                        textDirection: pw.TextDirection.rtl,
                                                      ),

                                                    ),
                                                    pw.SizedBox(width:40),
                                                    pw.Column(
                                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                                        children: [
                                                          pw.Container(
                                                            alignment: pw.Alignment.center,
                                                            child: pw.Text(
                                                              DividCommentsText("${comments}"),
                                                              style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black),
                                                              textDirection: pw.TextDirection.rtl,
                                                            ),),
                                                        ]
                                                    ),

                                                    pw.Divider(
                                                      thickness: 1,
                                                      color: PdfColors.grey,
                                                    ),
                                                    pw.Container(
                                                        height: Constants.mediaQuery.height * 0.10,
                                                        margin: pw.EdgeInsets.all(5),
                                                        child: pw.Row(
                                                            mainAxisAlignment: pw.MainAxisAlignment.center,
                                                            children: [
                                                              pw.Container(
                                                                alignment: pw.Alignment.centerRight,
                                                                child: pw.Text(
                                                                  DividCommentsText(
                                                                      "${consultation["name"]}"),
                                                                  style: pw.TextStyle(
                                                                      font: ttf,
                                                                      fontSize: 14,
                                                                      color: PdfColors.black),
                                                                  textDirection: pw
                                                                      .TextDirection
                                                                      .rtl,
                                                                ),
                                                              ),
                                                              pw.Container(
                                                                alignment: pw.Alignment.centerRight,
                                                                child: pw.Text(
                                                                  "الخدمة الاستشارية: ",
                                                                  style: pw.TextStyle(
                                                                      font: ttf,
                                                                      fontSize: 16,
                                                                      color: PdfColors.black),
                                                                  textDirection: pw
                                                                      .TextDirection
                                                                      .rtl,
                                                                ),
                                                              ),
                                                            ]
                                                        )
                                                    ),
                                                    pw.Row(
                                                        children: [
                                                          pw.SizedBox(width: 10,),
                                                          pw.Container(
                                                            alignment: pw.Alignment.center,
                                                            child: pw.Text(
                                                              DividCommentsText(" وصف الخدمة الاستشارية :${consultation["description"]}"),
                                                              style: pw.TextStyle(font: ttf, fontSize: 15, color: PdfColors.black),
                                                              textDirection: pw.TextDirection.rtl,
                                                            ),
                                                          ),
                                                          pw.SizedBox(width: 10,),
                                                        ]
                                                    )


                                                  ],
                                                ),
                                              ),
                                            );

                                          },
                                        ),
                                      );
                                      List<List<dynamic>> answe = [] ;
                                      print("pppppppppppp"+filteredAnswers.length.toString());
                                      print("fffffffffffff"+(widget.pationt_data as Pationts).toString());

                                      for (int count = 0; count < (filteredAnswers.length / 8).ceil(); count++) {
                                        List currentList = [];

                                        for (int i = 0; i < 8; i++) {
                                          int index = count * 8 + i;
                                          if (index < filteredAnswers.length) {
                                            currentList.add(filteredAnswers[index]);
                                          } else {
                                            break;
                                          }
                                        }

                                        if (currentList.isNotEmpty) {
                                          answe.add(currentList);
                                        }
                                      }

                                      for (int y = 0; y < answe.length; y++) {
                                        pdf.addPage(
                                          pw.Page(
                                            build: (pw.Context context) {
                                              return pw.Column(
                                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                                children: [
                                                  for (int i = 0; i < answe[y].length; i++) ...[
                                                    pw.Container(
                                                      height: answe[y][i]["question_options"]
                                                          .where((option) =>
                                                      (option['type'] == 1 || option['type'] == 2) && option['answer'] == "1" ||
                                                          (option['type'] == 3 && option['answer'] != null))
                                                          .length *
                                                          ((answe[y][i]["question_options"].where((option) =>
                                                          (option['type'] == 1 || option['type'] == 2) && option['answer'] == "1" ||
                                                              (option['type'] == 3 && option['answer'] != null))
                                                              .length > 3)
                                                              ? 22 // Height when length > 3
                                                              : (answe[y][i]["question_options"]
                                                              .where((option) =>
                                                          (option['type'] == 1 || option['type'] == 2) && option['answer'] == "1" ||
                                                              (option['type'] == 3 && option['answer'] != null))
                                                              .length > 2)
                                                              ? 25 // Height when length is 3
                                                              : 55  // Height when length is 2 or less
                                                          ),
                                                      child: pw.Column(
                                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                                        children: [
                                                          pw.Container(
                                                            height: answe[y][i]["title"].toString().split(" ").length > 15 ? 30 : 15,
                                                            margin: pw.EdgeInsets.only(left: 10),
                                                            child: pw.Row(
                                                              mainAxisAlignment: pw.MainAxisAlignment.end,
                                                              children: [
                                                                pw.SizedBox(width: 5),
                                                                pw.Text(
                                                                  DividText("${answe[y][i]['title']}"),
                                                                  style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                                                  textDirection: pw.TextDirection.rtl,
                                                                  maxLines: 5,
                                                                ),
                                                                pw.SizedBox(width: 5),
                                                              ],
                                                            ),

                                                          ),
                                                          pw.SizedBox(height:5),
                                                          for (int x = 0; x < answe[y][i]["question_options"].length; x++) ...[
                                                            if (answe[y][i]["question_options"][x]['type'] == 1 && answe[y][i]["question_options"][x]['answer'] == "1") ...[
                                                              pw.Row(
                                                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                                                children: [
                                                                  pw.Text(
                                                                    "${answe[y][i]["question_options"][x]['title']}",
                                                                    style: pw.TextStyle(font: ttf, fontSize: 10),
                                                                    textDirection: pw.TextDirection.rtl,
                                                                  ),
                                                                  pw.SizedBox(width: 10),
                                                                ],
                                                              ),
                                                            ],
                                                            if (answe[y][i]["question_options"][x]['type'] == 2 && answe[y][i]["question_options"][x]['answer'] == "1") ...[
                                                              pw.Row(
                                                                mainAxisAlignment: pw.MainAxisAlignment.end,
                                                                children: [
                                                                  pw.Text(
                                                                    "${answe[y][i]["question_options"][x]['title']}",
                                                                    style: pw.TextStyle(font: ttf, fontSize: 10),
                                                                    textDirection: pw.TextDirection.rtl,
                                                                  ),
                                                                  pw.SizedBox(width: 10),
                                                                ],
                                                              ),
                                                            ],
                                                            if (answe[y][i]["question_options"][x]['type'] == 3 && answe[y][i]["question_options"][x]['answer'] != null) ...[
                                                              pw.Directionality(
                                                                textDirection: pw.TextDirection.rtl,
                                                                child: pw.Row(
                                                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                                                  children: [
                                                                    pw.Text(
                                                                      "${answe[y][i]["question_options"][x]['title']} : ",
                                                                      style: pw.TextStyle(font: ttf, fontSize: 10),
                                                                      textDirection: pw.TextDirection.rtl,
                                                                    ),
                                                                    pw.Text(
                                                                      "${answe[y][i]["question_options"][x]['answer']}",
                                                                      style: pw.TextStyle(font: ttf, fontSize: 10),
                                                                      textDirection: pw.TextDirection.rtl,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              pw.SizedBox(width: 10),
                                                            ],
                                                          ],
                                                        ],
                                                      ),
                                                    ),
                                                    pw.Divider(
                                                      thickness: 1,
                                                      color: PdfColors.grey,
                                                    ),
                                                  ],
                                                ],
                                              );
                                            },
                                          ),
                                        );
                                      }

                                      try {
                                        // Save the PDF as bytes
                                        final pdfBytes = await pdf.save();

                                        // Create a blob and open in a new tab
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
                                  )
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "الحالة : ${patient["name"]}  ",
                                  style:  TextStyle(
                                    fontSize: isMobile?16:24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "الاستشارى : ${advicor["name"]}  ",
                                  style:  TextStyle(
                                    fontSize: isMobile?16:24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "تاريخ الجلسة : ${formData["date"]}  ",
                                  style:  TextStyle(
                                    fontSize: isMobile?16:24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color:  Colors.white,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: IconButton(
                                        icon: const Icon(Icons.arrow_forward,color: Colors.black),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.list, color: Colors.black),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return PatientSessionViewWithAdmin(
                                            pationt_data: widget.pationt_data,
                                          );
                                        }));
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.thumb_up_alt_outlined, color: Colors.black),
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                                          return ReportChartViewWithAdmin(
                                            pationt_data: widget.pationt_data,
                                          );
                                        }));
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      formData==null?Container():
                      Expanded(
                        child: Container(
                          height: Constants.mediaQuery.height * 0.8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Constants.theme.primaryColor.withOpacity(0.5),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: ListView.builder(
                            itemCount: answers.length + 1,
                            itemBuilder: (context, index) {
                              if (index < answers.length) {
                                var answer = answers[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Text(
                                        answer["title"],
                                        style: isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold,):Constants.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold,),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: answer["question_options"].length * 50,
                                      margin:  EdgeInsets.symmetric(horizontal: isMobile?5:20, vertical: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: ListView(
                                        children: [
                                          Column(
                                            children: answer["question_options"].map<Widget>((option) {
                                              return Row(
                                                children: [
                                                    Expanded(
                                                      child: Text(
                                                        option["title"].toString(),
                                                        style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,),
                                                      ),
                                                    ),
                                                  if (option["type"] == 1 )
                                                    Expanded(
                                                      child: Radio<bool>(
                                                        value: option["answer"]=="1"?true:false,
                                                        groupValue: true,
                                                        onChanged: (value) {},
                                                      ),
                                                    ),
                                                  if (option["type"] == 2 )
                                                    Expanded(
                                                      child: Checkbox(
                                                        value: option["answer"]=="1"?true:false,
                                                        onChanged: (value) {},
                                                      ),
                                                    ),
                                                  if (option["type"] == 3 && option["answer"] != null)

                                                    Expanded(
                                                      child: Text(
                                                        option["answer"].toString(),
                                                        style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        ],
                                      ).setHorizontalPadding(context, enableMediaQuery: false, isMobile?5:20),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      height: 3,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.black45,
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    Text(formData["need_other_session"]==1?"الحالة بحاجه الى جلسة اخرى":"الحالة ليست بحاجه الي جلسة اخرى",style: Constants.theme.textTheme.bodyLarge,),
                                    SizedBox(height: 10),
                                    Divider(
                                      thickness: 2,
                                      height: 3,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.black54,
                                    ),
                                    SizedBox(height: 10),

                                    Text(consultation["name"],style: Constants.theme.textTheme.bodyLarge,),
                                    SizedBox(height: 10),
                                    Container(
                                      height: Constants.mediaQuery.height * 0.15,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        consultation["description"],
                                        style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                          color: Colors.black,
                                        ),
                                      ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                    ),
                                    SizedBox(height: 20),
                                    Text("ملاحظات الاستشارى",style: Constants.theme.textTheme.bodyLarge,),
                                    SizedBox(height: 10),
                                    Container(
                                      height: Constants.mediaQuery.height * 0.2,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          formData["comments"],
                                          style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                            color: Colors.black,
                                          ),
                                        ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                      ),
                                    ),
                                  ],
                                ).setVerticalPadding(context, enableMediaQuery: false, 20).setHorizontalPadding(context,enableMediaQuery: false, 20);
                              }
                            },
                          ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                        ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                      )

                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text("Something went wrong"),
            );
          }
        },
      );}
    );
  }
  Future<void> _PDF() async {
    try {
      final font = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
      final ttf = pw.Font.ttf(font);
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Text(
                "sameh",
                style: pw.TextStyle(
                  fontSize: 30,
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.red ,
                  font: ttf,
                ),
              ),
            );
          },
        ),
      );
      // Save the PDF as bytes
      final pdfBytes = await pdf.save();
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Open the PDF in a new tab
      html.window.open(url, '_blank');

      // Release the blob URL
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      print('Error: $e');
    }
  }
  String DividText (String text){
    String temp = "" ;
    List<String> Words = text.split(" ") ;
    if(Words.length > 18){
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

  String DividCommentsText(String text) {
    String temp = "";
    List<String> Words = text.split(" ");
    int wordsPerLine = 12;

    for (int i = 0; i < Words.length; i += wordsPerLine) {
      int end = (i + wordsPerLine < Words.length) ? i + wordsPerLine : Words.length;
      temp += Words.sublist(i, end).join(" ") + "\n";
    }

    return temp.trim();
  }

}
