import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/PointerImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:html' as html;

class PrinterTableOfEhancePercentage extends pw.StatelessWidget {
  pw.Font ttf ;
  List<PointerImprovement> allPointerImprovement;
  dynamic logo ;
  dynamic secondLogo ;
  int maxLength = 0 ;

  PrinterTableOfEhancePercentage({
    required this.ttf ,
    required this.allPointerImprovement ,
    required this.logo ,
    required this.secondLogo ,
  });

  @override
  pw.Widget build(pw.Context context) {
    allPointerImprovement.forEach((element) {
      if(element.evaluationsBySession.length > maxLength)
        maxLength = element.evaluationsBySession.length ;
    });
    return pw.Directionality(
      textDirection: pw.TextDirection.rtl,
      child: pw.Column(
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
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                      "تحسن مؤشرات الحاله" ,
                      style: pw.TextStyle(font: ttf, fontSize: 12),
                      textDirection: pw.TextDirection.rtl,
                      textAlign: pw.TextAlign.center
                  ),
                ]
            ),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.black, width: 1),
              children: [
                pw.TableRow(
                    children: [
                      pw.Text(
                        "التحسن" ,
                        style: pw.TextStyle(font: ttf, fontSize: 12),
                        textDirection: pw.TextDirection.rtl,
                        textAlign: pw.TextAlign.center
                      ),
                      for(int i = maxLength ; i > 0 ; i--)...[
                        pw.Text(
                          numbers[i].toString() ,
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                          textDirection: pw.TextDirection.rtl,
                          textAlign: pw.TextAlign.center
                        )
                      ] ,
                      pw.Text(
                          "" ,
                          style: pw.TextStyle(font: ttf, fontSize: 12),
                          textDirection: pw.TextDirection.rtl,
                          textAlign: pw.TextAlign.center
                      ),
                    ]
                ),
                ...allPointerImprovement.map((pointerImprovement) {
                  return pw.TableRow(
                      children: [
                        pw.Text(
                            getEhanceState(pointerImprovement.evaluationsBySession),
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                            textDirection: pw.TextDirection.rtl,
                            textAlign: pw.TextAlign.center
                        ),
                        for(int i = maxLength ; i > 0 ; i--)...[
                          pw.Text(
                              pointerImprovement.evaluationsBySession[i] == null ? "" : pointerImprovement.evaluationsBySession[i].toString() ,
                              style: pw.TextStyle(font: ttf, fontSize: 12),
                              textDirection: pw.TextDirection.rtl,
                              textAlign: pw.TextAlign.center
                          ),
                        ],
                        pw.Text(
                            pointerImprovement.pointerName.toString() ,
                            style: pw.TextStyle(font: ttf, fontSize: 12),
                            textDirection: pw.TextDirection.rtl,
                            textAlign: pw.TextAlign.center
                        ),
                      ]
                  );
                }).toList() ,
              ],
            )
          ]
      )
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

  Map<int , String> numbers = {
    1 : "الاولى",
    2 : "الثانيه",
    3 : "الثالثه",
    4 : "الرابعه",
    5 : "الخامسه",
    6 : "السادسه",
    7 : "السابعه",
    8 : "الثامنه",
    9 : "التاسعه",
    10 : "العاشره",
  };

  String getEhanceState(Map<int, double> data){
    double value = 0 ;
    for(int i = maxLength ; i > 0 ; i--) {
      try {
        value = data[i]! ;
        break;
      }catch(e){

      }
    }
    if(value >= 8.5)
      return "ممتاز" ;
    else if(value >= 7)
      return "جيد جدا" ;
    else if(value >= 6)
      return "جيد" ;
    else
      return "ضعيف" ;
  }
}
