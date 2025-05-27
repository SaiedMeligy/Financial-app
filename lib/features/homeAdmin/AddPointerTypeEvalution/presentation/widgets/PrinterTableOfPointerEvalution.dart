import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:html' as html;

class PrinterTableOfPointerEvalution extends pw.StatelessWidget {
  int index ; 
  double lastSessionEvalution ; 
  pw.Font ttf ;
  String name ;
  List<SessionPointersEvaluations> sessionPointersEvaluations;
  String number;
  dynamic logo ;
  dynamic secondLogo ;

  PrinterTableOfPointerEvalution({
    required this.index ,
    required this.name ,
    required this.lastSessionEvalution ,
    required this.ttf ,
    required this.sessionPointersEvaluations ,
    required this.number ,
    required this.logo ,
    required this.secondLogo ,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              height: Constants.mediaQuery.height*0.16,
              width: Constants.mediaQuery.width*0.14,
              alignment: pw.Alignment.center,
              decoration: pw.BoxDecoration(
                image: pw.DecorationImage(
                  image: logo,
                  fit: pw.BoxFit.contain,
                ),
              ),
            ),
            pw.Container(
              height: Constants.mediaQuery.height*0.16,
              width: Constants.mediaQuery.width*0.14,
              alignment: pw.Alignment.center,
              decoration: pw.BoxDecoration(
                image: pw.DecorationImage(
                  image: secondLogo,
                  fit: pw.BoxFit.contain,
                ),
              ),
            ),
          ]
        ),
        if(index == 0)...[
          pw.Row(
            children: [
              pw.Expanded(
                child: pw.Container(
                  decoration: pw.BoxDecoration(
                    color: PdfColors.black ,
                    borderRadius: pw.BorderRadius.circular(5)
                  ),
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(8.0),
                    child: pw.Text(
                      "${getEhanceState(lastSessionEvalution)} - $name",
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 12,
                        color: PdfColors.white
                      ),
                      textDirection: pw.TextDirection.rtl,
                      textAlign: pw.TextAlign.center,
                    ),
                  ),
                )
              )
            ]
          ),
          pw.SizedBox(height: 5),
        ],
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.black, width: 1),
          children: [
            pw.TableRow(
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    "1-10",
                    style: pw.TextStyle(font: ttf, fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                    textAlign: pw.TextAlign.center
                  ),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                  child: pw.Text(
                    "مؤشرات الجلسة $number" ,
                    style: pw.TextStyle(font: ttf, fontSize: 12),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ),
              ],
            ),
            ...sessionPointersEvaluations!.map((pointerEvaluation) {
              return pw.TableRow(
                  children: [
                    pw.Text(
                        "${pointerEvaluation.evaluation}",
                        style: pw.TextStyle(font: ttf, fontSize: 12),
                        textDirection: pw.TextDirection.rtl,
                        textAlign: pw.TextAlign.center
                    ),
                    pw.Text(
                      "${pointerEvaluation.pointerName}" ,
                      style: pw.TextStyle(font: ttf, fontSize: 12),
                      textDirection: pw.TextDirection.rtl,
                    ),
                  ]
              );
            }).toList(),
            pw.TableRow(
              children: [
                pw.Text(
                  "%${calculatePersentage(sessionPointersEvaluations).toStringAsFixed(1)}",
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                  textDirection: pw.TextDirection.rtl,
                  textAlign: pw.TextAlign.center
                ),
                pw.Text(
                  "المجموع",
                  style: pw.TextStyle(font: ttf, fontSize: 12),
                  textDirection: pw.TextDirection.rtl,
                ),
              ]
            )
          ],
        )
      ]
    );
  }

  double calculatePersentage(List<SessionPointersEvaluations> sessionPointersEvaluations){
    double percentage = 0 ;
    sessionPointersEvaluations.forEach((element) {
      percentage += element.evaluation! ;
    });
    percentage = (percentage / sessionPointersEvaluations.length) * 10 ;
    return percentage ;
  }

  String getEhanceState(double value){
    if(value >= 85)
      return "ممتاز" ;
    else if(value >= 70)
      return "جيد جدا" ;
    else if(value >= 60)
      return "جيد" ;
    else
      return "ضعيف" ;
  }
}
