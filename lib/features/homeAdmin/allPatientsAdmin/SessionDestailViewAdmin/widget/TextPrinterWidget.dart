import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TextPrinterWidget extends pw.StatelessWidget {
  String text ;
  pw.Font ttf ;

  TextPrinterWidget({required this.text , required this.ttf});

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      children: [
        pw.SizedBox(height: 5),
        pw.Container(
          padding: pw.EdgeInsets.all(2),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.black,
              width: 1,
            ),
            borderRadius: pw.BorderRadius.circular(10),
          ),
          child: pw.Center(
              child: pw.Center(
                child: pw.Text(
                  text ,
                  style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                  textDirection: pw.TextDirection.rtl,
                ),
              )
          ),
        )
      ]
    );
  }
}
