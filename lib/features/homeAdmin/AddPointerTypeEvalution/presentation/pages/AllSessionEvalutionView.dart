import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/PrinterDescTableWidget.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/PrinterTableOfEhancePercentage.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/PrinterTableOfPointerEvalution.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:html' as html;
import 'package:experts_app/core/Services/snack_bar_service.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/AllSessionPointersTypeEvaluation.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/data/models/SessionPointersEvaluations.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/AllDescTableWidget.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/AllPointerTypeTableWidget.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/EhancePercentageChart.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/HeaderWidget.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/TotalPointerEvalutionTable.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/pointer_type_evalution_cubit.dart';


class AllSessionEvalutionView extends StatefulWidget {
  int patientId ;
  AllSessionEvalutionView({super.key , required this.patientId});

  @override
  State<AllSessionEvalutionView> createState() => _AllSessionEvalutionViewState();
}

class _AllSessionEvalutionViewState extends State<AllSessionEvalutionView> {
  PointerTypeEvalutionCubit pointerTypeEvalutionCubit = PointerTypeEvalutionCubit();
  double ehancePercentage = 0 ;
  @override
  void initState() {
    pointerTypeEvalutionCubit.fetchAllSessionAllPointer({"patientId" : widget.patientId});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: pointerTypeEvalutionCubit ,
      builder: (context, state) {
        if (state is PointerTypeEvalutionAllSessionLoading) {
          return Center(child: CircularProgressIndicator());
        }
        else if (state is PointerTypeEvalutionAllSessionEmpty) {
          Navigator.of(context).pop();
          SnackBarService.showErrorMessage("لم يتم تقييم اي جلسه");
          return Center(
            child: TextWidget(
              text: "state.message"
            )
          );
        }
        else if (state is PointerTypeEvalutionAllSessionLoaded) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.2
                  ),
                ),
                child: Container(
                  width: MediaQuery.sizeOf(context).width ,
                  margin: EdgeInsets.all(10),
                  child: ListView(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Constants.theme.primaryColor ,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: Icon(Icons.print, color: Colors.black, size: 40),
                              onPressed: () async {
                                print('Generating PDF...');
                                final pdf = pw.Document();
                                final fontData = await rootBundle.load('assets/fonts/Amiri-Bold.ttf');
                                final ttf = pw.Font.ttf(fontData);
                                final logo = pw.MemoryImage(
                                  (await rootBundle.load('assets/images/AEI Logo.png')).buffer.asUint8List(),
                                );
                                final secondLogo = pw.MemoryImage(
                                  (await rootBundle.load('assets/images/لوجو الهيئة.png')).buffer.asUint8List(),
                                );

                                await Future.delayed(Duration(seconds: 3));

                                for(int i = 0 ; i < state.allSessionPointersTypeEvaluation.length ; i++)
                                  pdf.addPage(
                                    pw.Page(
                                      build: (pw.Context context) {
                                        return PrinterTableOfPointerEvalution(
                                          index: i ,
                                          name: state.patientName ,
                                          lastSessionEvalution: i != 0 ? 0 : calculatePersentage(state.allSessionPointersTypeEvaluation.last.sessionPointersEvaluations!),
                                          ttf: ttf,
                                          logo: logo,
                                          secondLogo: secondLogo,
                                          sessionPointersEvaluations: state.allSessionPointersTypeEvaluation[i].sessionPointersEvaluations!,
                                          number: numbers[state.allSessionPointersTypeEvaluation[i].sessionNumber]!
                                        );
                                      },
                                    ),
                                  );

                                pdf.addPage(
                                  pw.Page(
                                    build: (pw.Context context) {
                                      return PrinterTableOfEhancePercentage(
                                        ttf: ttf,
                                        logo: logo,
                                        secondLogo: secondLogo,
                                        allPointerImprovement: state.allPointerImprovement
                                      );
                                    },
                                  ),
                                );

                                pdf.addPage(
                                  pw.Page(
                                    build: (pw.Context context) {
                                      return PrinterDescTableWidget(
                                        ttf: ttf,
                                        logo: logo,
                                        secondLogo: secondLogo,
                                        allDescImprovement: state.allDescImprovement
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text: state.patientName.toString() ,
                                  fontSize: 16 ,
                                ),
                                TextWidget(
                                  text: " - ${getStatues(calculatePersentage(state.allSessionPointersTypeEvaluation.last.sessionPointersEvaluations!))}" ,
                                  fontSize: 16 ,
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.arrow_forward
                              )
                            )
                          ],
                        ),
                      ),
                      Wrap(
                        children: [
                          ...state.allSessionPointersTypeEvaluation.map((e) {
                            return TotalPointerEvalutionTable(
                              sessionPointersEvaluations: e.sessionPointersEvaluations!,
                              number: numbers[e.sessionNumber]!
                            );
                          }).toList(),
                        ],
                      ),
                      Headerwidget(
                        text: "رسم بياني لتوضيح نسب التحسن للجلسات"
                      ),
                      Container(
                        width: 300,
                        height: 300,
                        child: EhancePercentageChart(
                          data: state.ehanceData ,
                        ),
                      ),
                      Headerwidget(
                        text: "نسب التحسن بالنسبة للمؤشرات"
                      ),
                      AllPointerTypeTableWidget(
                        allPointerImprovement: state.allPointerImprovement,
                      ),
                      Headerwidget(
                        text: "نسب التحسن بالنسبة لتصنيف المؤشرات" ,
                      ),
                      AllDescTableWidget(
                        allDescImprovement: state.allDescImprovement
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        else if (state is PointerTypeEvalutionAllSessionError) {
          return Center(
            child: TextWidget(
              text: state.message
            )
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Map<int , String> numbers = {
    1 : "الاولى", 2 : "الثانيه", 3 : "الثالثه", 4 : "الرابعه", 5 : "الخامسه",
    6 : "السادسه", 7 : "السابعه", 8 : "الثامنه", 9 : "التاسعه", 10 : "العاشره",
  };

  getStatues(double value){
    if(value >= 80){
      return "قصة نجاح";
    }
    else if(value >= 70){
      return "جيد جدا";
    }
    else if(value >= 60){
      return "جيد";
    }
    else if(value >= 50){
      return "مقبول";
    }else{
      return "ضعيف";
    }
  }

  double calculatePersentage(List<SessionPointersEvaluations> sessionPointersEvaluations){
    double percentage = 0 ;
    sessionPointersEvaluations.forEach((element) {
      percentage += element.evaluation! ;
    });
    percentage = (percentage / sessionPointersEvaluations.length) * 10 ;
    return percentage ;
  }
}
