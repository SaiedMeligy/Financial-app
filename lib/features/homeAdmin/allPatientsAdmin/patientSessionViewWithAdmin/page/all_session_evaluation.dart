import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart'; // For printing the PDF
import 'dart:html' as html; // For web-specific PDF handling

import '../../../../../core/config/cash_helper.dart';
import '../../../../../domain/entities/AllEvaluationModel.dart';
import '../../../../../core/config/constants.dart';

class AllSessionEvaluation extends StatefulWidget {
  final List<int> sessionIds;

  AllSessionEvaluation({super.key, required this.sessionIds});

  @override
  _AllSessionEvaluationState createState() => _AllSessionEvaluationState();
}

class _AllSessionEvaluationState extends State<AllSessionEvaluation> {
  AllEvaluationModel? evaluationData;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchEvaluationData();
  }

  Future<void> fetchEvaluationData() async {
    final dio = Dio();
    try {
      final response = await dio.post(
        '${Constants.baseUrl}/api/PointersEvaluation/getEvalutionPointersForAllSession',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        }),
        data: {'sessionIds': widget.sessionIds},
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['success'] == true) {
          setState(() {
            evaluationData = AllEvaluationModel.fromJson(data);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'Failed to load data: ${data['message']}';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = 'Failed to load data: ${response.statusCode}';
          isLoading = false;
        });
      }
    } on DioException catch (e) {
      setState(() {
        errorMessage = 'Dio Error: ${e.message}';
        isLoading = false;
      });
      print('Dio Error: ${e.response?.data}');
    } catch (e) {
      setState(() {
        errorMessage = 'Unexpected Error: $e';
        isLoading = false;
      });
      print('Unexpected Error: $e');
    }
  }

  Future<void> _generatePdf() async {
    if (evaluationData == null) return;

    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/fonts/Amiri-Bold.ttf');
    final ttf = pw.Font.ttf(fontData);

    // Use MultiPage to handle dynamic pagination
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
            // Add all sessions to the PDF
            for (final session in evaluationData!.allSessionPointersEvaluation!)
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    'الجلسة ${session.sessionNumber}',
                    style: pw.TextStyle(font: ttf, fontSize: 18, fontWeight: pw.FontWeight.bold),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.Text(
                    'التقييم الإجمالي: ${session.totalEvalution}',
                    style: pw.TextStyle(font: ttf, fontSize: 16),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.SizedBox(height: 10),
                  if (session.sessionPointersEvaluation != null)
                    ...session.sessionPointersEvaluation!.map((pointer) {
                      return pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 5),
                        child: pw.Row(
                          children: [
                            pw.Container(
                              width: 25,
                              padding: const pw.EdgeInsets.all(4),
                              decoration: pw.BoxDecoration(
                                borderRadius: pw.BorderRadius.circular(5),
                                border: pw.Border.all(color: PdfColors.black, width: 1),
                              ),
                              child: pw.Center(
                                child: pw.Text(
                                  "${pointer.evaluation}",
                                  style: pw.TextStyle(font: ttf, fontSize: 14),
                                  textDirection: pw.TextDirection.rtl,
                                ),
                              ),
                            ),
                            pw.Expanded(
                              flex: 2,
                              child: pw.Text(
                                pointer.pointerName ?? "",
                                style: pw.TextStyle(font: ttf, fontSize: 14),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ),

                          ],
                        ),
                      );
                    }).toList(),
                  pw.Divider(),
                ],
              ),
          ];
        },
      ),
    );

    // Save or print the PDF
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Constants.theme.primaryColor,
        title: Text(
          "التقييم الإجمالي",
          style: Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        leadingWidth: 40,
        actions: [
          IconButton(
            icon: Icon(Icons.print, color: Colors.white, size: 40),
            onPressed: _generatePdf,
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
              opacity: 0.4,
            ),
          ),
          child: isLoading
              ? Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          )
              : errorMessage.isNotEmpty
              ? Center(
            child: Text(
              errorMessage,
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.red,
              ),
            ),
          )
              : ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            itemCount: evaluationData?.allSessionPointersEvaluation?.length ?? 0,
            itemBuilder: (context, index) {
              final session = evaluationData!.allSessionPointersEvaluation![index];
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ExpansionTile(
                  title: Row(
                    children: [
                      Icon(
                        Icons.assignment,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "الجلسة ${session.sessionNumber??''}",
                        style: Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    "التقييم الإجمالي: ${session.totalEvalution}",
                    style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                  ),
                  children: [
                    if (session.sessionPointersEvaluation != null)
                      ...session.sessionPointersEvaluation!.map((pointer) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16.w),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  pointer.pointerName ?? "",
                                  style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black87),
                                ),
                              ),
                              Container(
                                width: 25.w,
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: Colors.blueAccent.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(5.sp),
                                  border: Border.all(color: Colors.black, width: 1),
                                ),
                                child: Center(
                                  child: Text(
                                    "${pointer.evaluation}",
                                    style: Constants.theme.textTheme.bodyLarge?.copyWith(color: Colors.black87),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),

                            ],
                          ),
                        );
                      }).toList(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}