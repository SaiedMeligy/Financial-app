import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/DescImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/PointerImprovement.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:html' as html;

class PrinterDescTableWidget extends pw.StatelessWidget {
  pw.Font ttf ;
  List<DescImprovement> allDescImprovement = [] ;
  dynamic logo ;
  dynamic secondLogo ;
  int maxLength = 0 ;

  PrinterDescTableWidget({
    required this.ttf ,
    required this.allDescImprovement ,
    required this.logo ,
    required this.secondLogo ,
  });

  @override
  pw.Widget build(pw.Context context) {
    allDescImprovement.forEach((element) {
      if(element.sessionAverages.length > maxLength)
        maxLength = element.sessionAverages.length ;
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
                    "تحسن تصنيف مؤشرات الحاله" ,
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
                  ...allDescImprovement.map((descImprovement) {
                    return pw.TableRow(
                        children: [
                          pw.Text(
                              getEhanceState(descImprovement.sessionAverages),
                              style: pw.TextStyle(font: ttf, fontSize: 12),
                              textDirection: pw.TextDirection.rtl,
                              textAlign: pw.TextAlign.center
                          ),
                          for(int i = maxLength ; i > 0 ; i--)...[
                            pw.Text(
                                descImprovement.sessionAverages[i] == null ? "" : descImprovement.sessionAverages[i].toString() ,
                                style: pw.TextStyle(font: ttf, fontSize: 12),
                                textDirection: pw.TextDirection.rtl,
                                textAlign: pw.TextAlign.center
                            ),
                          ],
                          pw.Text(
                            descImprovement.desc.toString() ,
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
