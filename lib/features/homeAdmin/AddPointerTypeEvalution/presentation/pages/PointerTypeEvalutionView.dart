import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/cubit/pointer_type_evalution_cubit.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/AssetsDialogInputOneInput.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/PointerTypeEvalutionTable.dart';
import 'package:experts_app/features/homeAdmin/AddPointerTypeEvalution/presentation/widgets/PointerTypeTableView.dart';
import 'package:experts_app/features/homeAdmin/PointerTypes/presentation/widgets/TextWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/OneSessionPointersEvaluations.dart';
import '../../data/models/SessionPointersEvaluations.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/SessionDestailViewAdmin/widget/reporst_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/config/constants.dart';
import '../../../../../core/widget/TextFieldPointers.dart';
import '../../../../../core/widget/tab_item_widget.dart';
import '../../../../../domain/entities/AllSessionModel.dart';
import '../../../../../domain/entities/QuestionModel.dart';
import 'package:intl/intl.dart'as date;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;

class PointerTypeEvalutionView extends StatefulWidget {
  Map<String,dynamic> data ;
  String patientName;
  String advisorName;
  final sessionDate;

  PointerTypeEvalutionView({
    super.key,
    required this.data ,
    required this.patientName ,
    required this.advisorName ,
    required this.sessionDate ,
  });

  @override
  State<PointerTypeEvalutionView> createState() => _PointerTypeEvalutionViewState();
}

class _PointerTypeEvalutionViewState extends State<PointerTypeEvalutionView> {
  PointerTypeEvalutionCubit pointerTypeEvalutionCubit = PointerTypeEvalutionCubit();
  var formatDate = date.DateFormat('yyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    pointerTypeEvalutionCubit.fetchSessionAllPointer(widget.data);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointerTypeEvalutionCubit, PointerTypeEvalutionState>(
      bloc: pointerTypeEvalutionCubit ,
      builder: (context, state) {
        if (state is PointerTypeEvalutionOneSessionLoading) {
          return Center(child: CircularProgressIndicator());
        }
        else if (state is PointerTypeEvalutionOneSessionLoaded) {
          return Scaffold(
            backgroundColor: Colors.black.withOpacity(0.08),
            appBar: AppBar(
              title: TextWidget(
                text: "تقييم مؤشرات الجلسة",
                color: Colors.white,
                fontSize: 18,
              ),
              centerTitle: true,
              titleTextStyle: Constants.theme.textTheme.titleLarge,
              backgroundColor: Constants.theme.primaryColor,
              elevation: 0.0,
              automaticallyImplyLeading: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.print),
                  onPressed: (){
                    _generatePdf(state.oneSessionPointersEvaluations);
                  },
                ),
              ],
            ),
            body: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg") ,
                    fit: BoxFit.cover ,
                    opacity: 0.2
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                          border: Border.all(color: Colors.black)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(),
                            TextWidget(
                              text: "التقييم الاجمالي : ${state.oneSessionPointersEvaluations.totalEvaluation!.toStringAsFixed(2)} / 10",
                              fontSize: 18,
                            ),
                            IconButton(
                              onPressed: () => _addPointerEvalutionDialog() ,
                              icon: Icon(
                                Icons.add_circle
                              )
                            )
                          ],
                        ),
                      ),
                      PointerTypeEvalutionTable(
                        edit: (sessionPointersEvaluations) => _editDialog(sessionPointersEvaluations),
                        delete: (sessionPointersEvaluations) => _deleteDialog(sessionPointersEvaluations),
                        allPointersEvaluations: state.oneSessionPointersEvaluations.sessionPointersEvaluations!
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        else if (state is PointerTypeEvalutionOneSessionError) {
          return Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/back.jpg") ,
                fit: BoxFit.cover ,
                opacity: 0.2
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: "لم يتم اضافة تقيمات للجلسه"
                ),
                IconButton(
                  onPressed: () => _addPointerEvalutionDialog() ,
                  icon: Icon(
                      Icons.add_circle
                  )
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  _addPointerEvalutionDialog(){
    showDialog(
      context: context,
      builder: (dialogContext) {
        return PointerTypesTableViewWidget(
          save: (evalutions) {
            Map<String,dynamic> data = {
              "pointersEvaluation" : evalutions.entries.map((e) => {"pointerId": e.key, "evaluation": e.value}).toList() ,
            };
            data.addAll(widget.data);
            pointerTypeEvalutionCubit.addPointerTypeEvalution(data);
          },
        );
      },
    );
  }
  _deleteDialog(SessionPointersEvaluations sessionPointersEvaluations){
    showDialog(
      context: context,
      builder: (context) {
        return AssetsDialogInputOneInput(
          headerText: 'حذف التقييم',
          isInput: false,
          imagePath: 'assets/images/clinic logo.jpg',
          okButtoneText: "حذف",
          sessionPointersEvaluations: sessionPointersEvaluations,
          onOkPressed: (sessionPointersEvaluations) {
            pointerTypeEvalutionCubit.deletePointerTypeEvalution(sessionPointersEvaluations.id!, widget.data);
            Navigator.of(context).pop();
          },
          onCancelPressed: () {
            Navigator.of(context).pop();
          },
        );
      }
    );
  }
  _editDialog(SessionPointersEvaluations sessionPointersEvaluations) {
    showDialog(
      context: context,
      builder: (context) {
        return AssetsDialogInputOneInput(
          headerText: 'تعديل التقييم',
          isInput: true,
          imagePath: 'assets/images/clinic logo.jpg',
          okButtoneText: "تعديل",
          sessionPointersEvaluations: sessionPointersEvaluations,
          onOkPressed: (sessionPointersEvaluations) {
            pointerTypeEvalutionCubit.updatePointerTypeEvalution(sessionPointersEvaluations, widget.data);
            Navigator.of(context).pop();
          },
          onCancelPressed: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<void> _generatePdf(OneSessionPointersEvaluations oneSessionPointersEvaluations) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/fonts/Amiri-Bold.ttf');
    final ttf = pw.Font.ttf(fontData);
    final logo = pw.MemoryImage(
      (await rootBundle.load('assets/images/AEI Logo.png')).buffer.asUint8List(),
    );
    final secondLogo = pw.MemoryImage(
      (await rootBundle.load('assets/images/لوجو الهيئة.png')).buffer.asUint8List(),
    );

    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) {
          return [
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
            pw.Align(
              alignment: pw.Alignment.center,
              child: pw.Container(
                width: double.infinity,
                padding: pw.EdgeInsets.all(5),
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    width: 2
                  ),
                  borderRadius: pw.BorderRadius.circular(20),
                ),
                child:pw.Text('تقييم مؤشرات الجلسة',
                  style: pw.TextStyle(font: ttf, fontSize: 18, fontWeight: pw.FontWeight.bold),
                  textDirection: pw.TextDirection.rtl,
                ),
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  width: 2
                ),
                borderRadius: pw.BorderRadius.circular(20),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    "الاستشارى : " + widget.advisorName,
                    style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                    textDirection: pw.TextDirection.rtl,
                  ),
                  pw.SizedBox(width: 20,),
                  pw.Text(
                    "الحالة : " + widget.patientName,
                    style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 10),
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.all(5),
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  width: 2
                ),
                borderRadius: pw.BorderRadius.circular(20),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text('تاريخ الطباعة: ${formatDate}',
                      style: pw.TextStyle(font: ttf, fontSize: 16),
                      textDirection: pw.TextDirection.rtl,
                    ),
                  ),
                  pw.SizedBox(width: 20),
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text('تاريخ الجلسة: ${widget.sessionDate}',
                      style: pw.TextStyle(font: ttf, fontSize: 16),
                      textDirection: pw.TextDirection.rtl,
                    ),
                  ),
                ]
              ),
            ),
            pw.SizedBox(height: 20),


            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text("التقييم الإجمالي: ${oneSessionPointersEvaluations.totalEvaluation?.toStringAsFixed(2)}/10",
                style: pw.TextStyle(font: ttf, fontSize: 16),
                textDirection: pw.TextDirection.rtl,
              ),
            ),
            pw.SizedBox(height: 10),
            for (final pointer in oneSessionPointersEvaluations.sessionPointersEvaluations!)
              pw.Padding(
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
              ),
          ];
        },
      ),
    );

    try {
      final pdfBytes = await pdf.save();
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      html.window.open(url, '_blank');
      html.Url.revokeObjectUrl(url);

      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    } catch (e) {
      print('Error: $e');
    }
  }
}