// import 'package:experts_app/core/config/constants.dart';
// import 'package:experts_app/core/extensions/padding_ext.dart';
// import 'package:experts_app/features/homeAdmin/allPatientsAdmin/ReportChartWithAdmin/page/report_chart_with_admin.dart';
// import 'package:experts_app/features/homeAdmin/allPatientsAdmin/patientSessionViewWithAdmin/page/patient_session_view_with_admin.dart';
// import 'package:experts_app/features/homeAdmin/allPatientsAdmin/updateForm/page/update_form_admin_view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../homeAdvisor/viewQuestion/page/update_form.dart';
// import '../replace_advisor/page/replace_advisor_view.dart';
// import 'manager/cubit.dart';
// import 'manager/states.dart';
//
// class PatientDetailsAdminView extends StatefulWidget {
//   PatientDetailsAdminView({super.key, required this.pationt_data});
//   final dynamic pationt_data;
//
//   @override
//   State<PatientDetailsAdminView> createState() => _PatientDetailsAdminViewState();
// }
//
// class _PatientDetailsAdminViewState extends State<PatientDetailsAdminView> {
//   late PatientFormViewWithAdminCubit _patientFormViewCubit;
//
//   @override
//   void initState() {
//     super.initState();
//     _patientFormViewCubit = PatientFormViewWithAdminCubit();
//     _patientFormViewCubit.getPatientFormViewWithAdmin(widget.pationt_data.id);
//   }
//
//   @override
//   void dispose() {
//     _patientFormViewCubit.close(); // Close the cubit when done
//     super.dispose();
//   }
//
//   List<dynamic> filterQuestionsWithAnswer(List<dynamic> answers) {
//     return answers.where((answer) {
//       return answer['question_options'].any((option) {
//         if (option['answer'] is String) {
//           return option['answer'] == "1";
//         } else if (option['answer'] is int) {
//           return option['answer'] == 1;
//         }
//         return false;
//       });
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<PatientFormViewWithAdminCubit, PatientFormViewWithAdminStates>(
//       bloc: _patientFormViewCubit,
//       builder: (context, state) {
//         if (state is LoadingPatientFormViewWithAdminState) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is ErrorPatientFormViewWithAdminState) {
//           return Center(
//             child: Text(state.errorMessage),
//           );
//         } else if (state is SuccessPatientFormViewWithAdminState) {
//           var formData = state.response.data["form"];
//           var patient = state.response.data["form"]["pationt"];
//           var advicor = state.response.data["form"]["advicor"];
//           var answers = state.response.data["form"]["answers"];
//           var consultation = formData["consultationService"];
//
//           var filteredAnswers = filterQuestionsWithAnswer(answers);
//
//           return
//             Directionality(
//               textDirection: TextDirection.rtl,
//               child: Scaffold(
//                 body: Container(
//                   decoration: const BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage("assets/images/back.jpg"),
//                       fit: BoxFit.cover,
//                       opacity: 0.9,
//                     ),
//                   ),
//                   child: Column(
//                       children: [
//                         Container(
//                           height: Constants.mediaQuery.height * 0.2,
//                           width: double.infinity,
//                           decoration:  BoxDecoration(
//                             color: Constants.theme.primaryColor,
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//
//
//                               Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Container(
//                                         margin: EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             color: Colors.grey,
//                                             borderRadius: BorderRadius.circular(20)
//                                         ),
//                                         child: IconButton(
//                                             icon: Icon(Icons.edit,color: Colors.black),
//                                             onPressed: () {
//                                               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                                 return UpdateFormAdminView(pationt_data: widget.pationt_data);
//
//
//                                               },));
//                                             }
//                                         ),
//                                       ),
//                                       Container(
//                                         margin: EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             color: Colors.grey,
//                                             borderRadius: BorderRadius.circular(20)
//                                         ),
//                                         child: IconButton(
//                                             icon: Icon(CupertinoIcons.arrow_up_arrow_down_circle,color: Colors.black),
//                                             onPressed: () {
//                                               Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                                 return ReplaceAdvisorView(pationt_data: widget.pationt_data);
//
//
//                                               },));
//                                             }
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         color: Colors.grey,
//                                         borderRadius: BorderRadius.circular(20)
//                                     ),
//                                     child: IconButton(
//                                         icon: Icon(Icons.print,color: Colors.black),
//                                         onPressed: () {
//
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                             return UpdateForm(pationt_data: widget.pationt_data);
//
//
//                                           },));
//                                         }
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               // if (_currentAnimation == 1)
//                               Column(
//                                 children: [
//                                   Text(
//                                     "الحالة : ${patient["name"]}  ",
//                                     style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   // if (_currentAnimation == 2)
//                                   Text(
//                                     "الاستشاري : ${advicor["name"]}  ",
//                                     style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                   // if (_currentAnimation == 3)
//                                   Text(
//                                     "تاريخ الجلسة : ${formData["date"]}  ",
//                                     style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   Container(
//                                     margin: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         color: Colors.grey,
//                                         borderRadius: BorderRadius.circular(20)
//                                     ),
//                                     child: IconButton(
//                                         icon: Icon(Icons.list,color: Colors.black),
//                                         onPressed: () {
//                                           // print(AddSessionCubit().getPatientDetails(widget.pationt_data.nationalId));
//
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                             return PatientSessionViewWithAdmin(
//                                               pationt_data: widget.pationt_data,
//                                             );
//
//
//                                           },));
//                                         }
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         color: Colors.grey,
//                                         borderRadius: BorderRadius.circular(20)
//                                     ),
//                                     child: IconButton(
//                                         icon: Icon(Icons.thumb_up_alt_outlined,color: Colors.black),
//                                         onPressed: () {
//
//                                           Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                             return ReportChartViewWithAdmin(
//                                               pationt_data: widget.pationt_data,
//                                             );
//
//
//                                           },));
//                                         }
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//
//                         Expanded(
//                           child: Container(
//                             height: Constants.mediaQuery.height * 0.8,
//                             width: double.infinity,
//                             decoration:  BoxDecoration(
//                               color: Constants.theme.primaryColor.withOpacity(0.3),
//                               borderRadius: BorderRadius.all(Radius.circular(10)),
//                             ),
//                             child:
//                             ListView.builder(
//                               itemCount: filteredAnswers.length,
//                               itemBuilder: (context, index) {
//                                 var answer = filteredAnswers[index];
//                                 return Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     if (filteredAnswers.length != index + 1) ...[
//                                       if (answer["question_options"].any((option) => option['answer'] == "1" || option['answer'] == 1))
//                                         Center(
//                                           child: Text(
//                                               answer["title"],
//                                               style: Constants.theme.textTheme.titleLarge?.copyWith(
//                                                   fontWeight: FontWeight.bold
//                                               )
//                                           ),
//                                         ),
//                                       // Container(
//                                       //   width: double.infinity,
//                                       //   height:  answers[index]["question_options"].length > 1
//                                       // ? answers[index]["question_options"].length * 50 : 70,
//                                       //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                                       //   decoration: const BoxDecoration(
//                                       //     color: Colors.white,
//                                       //     borderRadius: BorderRadius.only(
//                                       //       topLeft: Radius.circular(20),
//                                       //       topRight: Radius.circular(20),
//                                       //     ),
//                                       //   ),
//                                       //   child:
//                                       //   Column(
//                                       //     children: answer["question_options"].map<Widget>((option) {
//                                       //       bool isAnswered = (option['answer'] is String && option['answer'] == "1") ||
//                                       //           (option['answer'] is int && option['answer'] == 1);
//                                       //       return
//                                       //         Row(
//                                       //           children: [
//                                       //             if (isAnswered)
//                                       //               Expanded(
//                                       //                 child: Text(
//                                       //                   option["title"].toString(),
//                                       //                   style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                       //                     color: Colors.black,
//                                       //                   ),
//                                       //                 ),
//                                       //               ),
//                                       //             if (option["type"] == 1 && isAnswered)
//                                       //               Expanded(
//                                       //                 child: Radio<bool>(
//                                       //                   value: true,
//                                       //                   groupValue: true,
//                                       //                   onChanged: (value) {},
//                                       //                 ),
//                                       //               ),
//                                       //             if (option["type"] == 2 && isAnswered)
//                                       //
//                                       //               Expanded(
//                                       //                 child: Checkbox(
//                                       //                   value: true,
//                                       //                   onChanged: (value) {},
//                                       //                 ),
//                                       //               ),
//                                       //             if (option["type"] == 3 && option["answer"] != null)
//                                       //
//                                       //               Expanded(
//                                       //                 child: Text(
//                                       //                   option["answer"].toString(),
//                                       //                   style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                       //                     color: Colors.black,
//                                       //                   ),
//                                       //                 ),
//                                       //               ),
//                                       //           ],
//                                       //         );
//                                       //     }).toList(),
//                                       //   ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                                       //
//                                       // ),
//                                       Container(
//                                         width: double.infinity,
//                                         height: answers[index]["question_options"].where((option) => option["answer"] == "1").length > 1?  Constants.mediaQuery.height * 0.18:Constants.mediaQuery.height * 0.09,
//
//
//                                         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//                                         decoration:  BoxDecoration(
//                                           color: Colors.grey.shade300,
//                                           borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(20),
//                                             topRight: Radius.circular(20),
//                                           ),
//                                         ),
//                                         child: ListView(
//                                           children: [
//                                             Column(
//                                               children: answer["question_options"].map<Widget>((option) {
//                                                 bool isAnswered = (option['answer'] is String && option['answer'] == "1") ||
//                                                     (option['answer'] is int && option['answer'] == 1);
//                                                 return
//                                                   Row(
//                                                     children: [
//                                                       if (isAnswered)
//                                                         Expanded(
//                                                           child: Text(
//                                                             option["title"].toString(),
//                                                             style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                               color: Colors.black,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       if (option["type"] == 1 && isAnswered)
//                                                         Expanded(
//                                                           child: Radio<bool>(
//                                                             value: true,
//                                                             groupValue: true,
//                                                             onChanged: (value) {},
//                                                           ),
//                                                         ),
//                                                       if (option["type"] == 2 && isAnswered)
//                                                         Expanded(
//                                                           child: Checkbox(
//                                                             value: true,
//                                                             onChanged: (value) {},
//                                                           ),
//                                                         ),
//                                                       if (option["type"] == 3 && option["answer"] != null)
//                                                         Expanded(
//                                                           child: Text(
//                                                             option["answer"].toString(),
//                                                             style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                               color: Colors.black,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                     ],
//                                                   );
//                                               }).toList(),
//                                             ),
//                                           ],
//                                         ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                                       ),
//
//                                       Divider(
//                                         thickness: 2,
//                                         height: 3,
//                                         indent: 20,
//                                         endIndent: 20,
//                                         color: Colors.grey.shade600,
//                                       ),
//                                       SizedBox(height: 10),
//                                     ] else ...[
//                                       Column(
//                                         children: [
//                                           Text(consultation["name"]),
//                                           SizedBox(height: 10),
//                                           Container(
//                                             height: Constants.mediaQuery.height * 0.15,
//                                             width: double.infinity,
//                                             decoration:  BoxDecoration(
//                                               color: Colors.grey.shade300,
//                                               borderRadius: BorderRadius.only(
//                                                 topLeft: Radius.circular(20),
//                                                 topRight: Radius.circular(20),
//                                               ),
//                                             ),
//                                             child: Text(
//                                               consultation["description"],
//                                               style: Constants.theme.textTheme.bodyMedium?.copyWith(
//                                                 color: Colors.black,
//                                               ),
//                                             ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//                                           ),
//                                         ],
//                                       ).setVerticalPadding(context, enableMediaQuery: false, 20),
//                                     ],
//                                   ],
//                                 );
//                               },
//                             ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//
//                           ).setHorizontalPadding(context,enableMediaQuery: false ,20),
//                         ),
//                       ]
//                   ),
//                 ),
//               ),
//             );
//         } else {
//           return Center(
//             child: Text("Something went wrong"),
//           );
//         }
//       },
//     );
//   }
// }
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html'as html;
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/ReportChartWithAdmin/page/report_chart_with_admin.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/patientSessionViewWithAdmin/page/patient_session_view_with_admin.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/updateForm/page/update_form_admin_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../homeAdvisor/viewQuestion/page/update_form.dart';
import '../replace_advisor/page/replace_advisor_view.dart';
import 'manager/cubit.dart';
import 'manager/states.dart';

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
    return answers.where((answer) {
      return answer['question_options'].any((option) {
        if (option['answer'] is String) {
          return option['answer'] == "1";
        } else if (option['answer'] is int) {
          return option['answer'] == 1;
        }
        return false;
      });
    }).toList();
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
            var consultation = formData["consultationService"];
            var filteredAnswers = filterQuestionsWithAnswer(answers);

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Scaffold(
                body: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/back.jpg"),
                      fit: BoxFit.cover,
                      opacity: 0.9,
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
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
                                        color: Colors.grey,
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
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.print, color: Colors.black),
                                    onPressed: () async {
                                      print('sssssssssssssssssssssssss');
                                      final pdf = pw.Document();

                                      final notoSans = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");

                                      final ttfSans = pw.Font.ttf(notoSans);

                                      pdf.addPage(
                                        pw.Page(
                                          build: (pw.Context context) {
                                            return pw.Center(
                                              child: pw.Column(
                                                mainAxisAlignment: pw.MainAxisAlignment.center,
                                                children: [

                                                  pw.Container(
                                                      margin: pw.EdgeInsets.all(5),
                                                      decoration: pw.BoxDecoration(
                                                          color: PdfColors.black,
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
                                                                style: pw.TextStyle(font: ttfSans, fontSize: 16, color: PdfColors.white),
                                                                textDirection: pw.TextDirection.rtl,
                                                              ),
                                                            ),

                                                            pw.Container(
                                                              alignment: pw.Alignment.centerRight,
                                                              child: pw.Text(
                                                                "اسم الحالة" ,
                                                                style: pw.TextStyle(font: ttfSans, fontSize: 16, color: PdfColors.white),
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
                                                          color: PdfColors.black,
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
                                                                style: pw.TextStyle(font: ttfSans, fontSize: 16, color: PdfColors.white),
                                                                textDirection: pw.TextDirection.rtl,
                                                              ),
                                                            ),
                                                            pw.Container(
                                                              alignment: pw.Alignment.centerRight,
                                                              child: pw.Text(
                                                                "الرقم القومي" ,
                                                                style: pw.TextStyle(font: ttfSans, fontSize: 16, color: PdfColors.white),
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
                                                          color: PdfColors.black,
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
                                                                "${advicor["name"]}" ,
                                                                style: pw.TextStyle(font: ttfSans, fontSize: 16, color: PdfColors.white),
                                                                textDirection: pw.TextDirection.rtl,
                                                              ),
                                                            ),

                                                            pw.Container(
                                                              alignment: pw.Alignment.centerRight,
                                                              child: pw.Text(
                                                                "اسم الاستشاري" ,
                                                                style: pw.TextStyle(font: ttfSans, fontSize: 16, color: PdfColors.white),
                                                                textDirection: pw.TextDirection.rtl,
                                                              ),
                                                            ),
                                                            pw.SizedBox(width: 20,),
                                                          ]
                                                      )
                                                  ),
                                                ],
                                              ),
                                            );

                                          },
                                        ),
                                      );

                                      List<List<dynamic>> answe = [] ;


                                      for(int count = 0 ; count < (filteredAnswers.length/6).ceil() ; count++){
                                        answe.add([]);
                                        for(int i = 0 ; i < 6 ; i++) {
                                          try{
                                            answe[count].add(filteredAnswers[count*6+i]);
                                          }catch(e){}
                                        }
                                      }

                                      for(int y = 0 ; y < answe.length ; y++) {
                                        pdf.addPage(
                                          pw.Page(
                                            build: (pw.Context context) {
                                              return pw.Center(
                                                child: pw.Column(
                                                  mainAxisAlignment: pw.MainAxisAlignment.start,
                                                  children: [
                                                    for(int i = 0 ; i < answe[y].length ; i++) ...[
                                                      pw.Container(
                                                          margin: pw.EdgeInsets.all(5),
                                                          decoration: pw.BoxDecoration(
                                                              border: pw.Border.all(
                                                                  color: PdfColors.black,
                                                                  width: 1
                                                              ),
                                                              borderRadius: pw.BorderRadius.circular(10)
                                                          ),
                                                          child: pw.Column(
                                                              children: [
                                                                pw.Container(
                                                                  decoration: pw.BoxDecoration(
                                                                      color: PdfColors.black ,
                                                                      borderRadius: pw.BorderRadius.circular(10)
                                                                  ),
                                                                  child: pw.Row(
                                                                      mainAxisAlignment: pw.MainAxisAlignment.end ,
                                                                      children: [
                                                                        pw.Text(
                                                                          "${answe[y][i]['title']}" ,
                                                                          style: pw.TextStyle(font: ttfSans, fontSize: 16, color: PdfColors.white),
                                                                          textDirection: pw.TextDirection.rtl,
                                                                        ),
                                                                        pw.SizedBox(width: 5)
                                                                      ]
                                                                  ),
                                                                ),
                                                                for(int x = 0; x < answe[y][i]["question_options"].length ; x++) ...[
                                                                  pw.Row(
                                                                      mainAxisAlignment: pw.MainAxisAlignment.end ,
                                                                      children: [
                                                                        if(answe[y][i]["question_options"][x]['answer'] == "1")...[
                                                                          pw.Text(
                                                                            "${answe[y][i]["question_options"][x]['title']}",
                                                                            style: pw.TextStyle(font: ttfSans, fontSize: 13),
                                                                            textDirection: pw.TextDirection.rtl,
                                                                          ),
                                                                          pw.SizedBox(width: 10),
                                                                          pw.Container(
                                                                              width: 8 ,
                                                                              height: 8 ,
                                                                              color: PdfColors.black
                                                                          ),
                                                                          pw.SizedBox(width: 20),
                                                                        ]
                                                                      ]
                                                                  )
                                                                ]
                                                              ]
                                                          )
                                                      )
                                                    ],
                                                  ],
                                                ),
                                              );

                                            },
                                          ),
                                        );
                                      }
                                      final pdfBytes = await pdf.save();

                                      final blob = html.Blob([pdfBytes], 'application/pdf');
                                      final url = html.Url.createObjectUrlFromBlob(blob);

                                      // Open the PDF in a new tab
                                      html.window.open(url, '_blank');

                                      // Release the blob URL
                                      html.Url.revokeObjectUrl(url);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "الحالة : ${patient["name"]}  ",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "الاستشاري : ${advicor["name"]}  ",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "تاريخ الجلسة : ${formData["date"]}  ",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: IconButton(
                                    icon: Icon(Icons.list, color: Colors.black),
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
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
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
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Expanded(
                      //   child: Container(
                      //     height: Constants.mediaQuery.height * 0.8,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       color: Constants.theme.primaryColor.withOpacity(0.3),
                      //       borderRadius: BorderRadius.all(Radius.circular(10)),
                      //     ),
                      //     child: ListView.builder(
                      //       itemCount: answers.length+1,
                      //       itemBuilder: (context, index) {
                      //         var answer = answers[index];
                      //
                      //         return Column(
                      //           crossAxisAlignment: CrossAxisAlignment.start,
                      //           children: [
                      //             if (answers.length != index ) ...[
                      //               Center(
                      //                 child: Text(
                      //                   answer["title"],
                      //                   style: Constants.theme.textTheme.titleLarge?.copyWith(
                      //                     fontWeight: FontWeight.bold,
                      //                   ),
                      //                 ),
                      //               ),
                      //               Container(
                      //                 width: double.infinity,
                      //                 height: answers[index]["question_options"].where((option) => option["answer"] == "1").length > 1 ? Constants.mediaQuery.height * 0.18 : Constants.mediaQuery.height * 0.09,
                      //                 margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      //                 decoration: BoxDecoration(
                      //                   color: Colors.grey.shade300,
                      //                   borderRadius: BorderRadius.only(
                      //                     topLeft: Radius.circular(20),
                      //                     topRight: Radius.circular(20),
                      //                   ),
                      //                 ),
                      //                 child: ListView(
                      //                   children: [
                      //                     Column(
                      //                       children: answer["question_options"].map<Widget>((option) {
                      //                         bool isAnswered = (option['answer'] is String && option['answer'] == "1") ||
                      //                             (option['answer'] is int && option['answer'] == 1);
                      //                         return Row(
                      //                           children: [
                      //                             if (isAnswered)
                      //                               Expanded(
                      //                                 child: Text(
                      //                                   option["title"].toString(),
                      //                                   style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      //                                     color: Colors.black,
                      //                                   ),
                      //                                 ),
                      //                               ),
                      //                             if (option["type"] == 1 && isAnswered)
                      //                               Expanded(
                      //                                 child: Radio<bool>(
                      //                                   value: true,
                      //                                   groupValue: true,
                      //                                   onChanged: (value) {},
                      //                                 ),
                      //                               ),
                      //                             if (option["type"] == 2 && isAnswered)
                      //                               Expanded(
                      //                                 child: Checkbox(
                      //                                   value: true,
                      //                                   onChanged: (value) {},
                      //                                 ),
                      //                               ),
                      //                             if (option["type"] == 3 && option["answer"] != null)
                      //                               Expanded(
                      //                                 child: Text(
                      //                                   option["answer"].toString(),
                      //                                   style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      //                                     color: Colors.black,
                      //                                   ),
                      //                                 ),
                      //                               ),
                      //                           ],
                      //                         );
                      //                       }).toList(),
                      //                     ),
                      //                   ],
                      //                 ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                      //               ),
                      //               Divider(
                      //                 thickness: 2,
                      //                 height: 3,
                      //                 indent: 20,
                      //                 endIndent: 20,
                      //                 color: Colors.grey.shade600,
                      //               ),
                      //               SizedBox(height: 10),
                      //             ] else ...[
                      //               Column(
                      //                 children: [
                      //                   Text(consultation["name"]),
                      //                   SizedBox(height: 10),
                      //                   Container(
                      //                     height: Constants.mediaQuery.height * 0.15,
                      //                     width: double.infinity,
                      //                     decoration: BoxDecoration(
                      //                       color: Colors.grey.shade300,
                      //                       borderRadius: BorderRadius.only(
                      //                         topLeft: Radius.circular(20),
                      //                         topRight: Radius.circular(20),
                      //                       ),
                      //                     ),
                      //                     child: Text(
                      //                       consultation["description"],
                      //                       style: Constants.theme.textTheme.bodyMedium?.copyWith(
                      //                         color: Colors.black,
                      //                       ),
                      //                     ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                      //                   ),
                      //                 ],
                      //               ).setVerticalPadding(context, enableMediaQuery: false, 20),
                      //             ],
                      //           ],
                      //         );
                      //       },
                      //     ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                      //   ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                      // ),
                      formData==null?Container():
                      Expanded(
                        child: Container(
                          height: Constants.mediaQuery.height * 0.8,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Constants.theme.primaryColor.withOpacity(0.4),
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
                                        style: Constants.theme.textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: answer["question_options"].where((option) => option["answer"] == "1").length > 1 ? Constants.mediaQuery.height * 0.18 : Constants.mediaQuery.height * 0.09,
                                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
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
                                                        style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                          color: Colors.black,
                                                        ),
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
                                      ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                    ),
                                    Divider(
                                      thickness: 2,
                                      height: 3,
                                      indent: 20,
                                      endIndent: 20,
                                      color: Colors.grey.shade600,
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                );
                              } else {
                                return Column(
                                  children: [
                                    Text(consultation["name"],style: Constants.theme.textTheme.bodyLarge,),
                                    SizedBox(height: 10),
                                    Container(
                                      height: Constants.mediaQuery.height * 0.15,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
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
                                    Text("ملاحظات الاستشاري",style: Constants.theme.textTheme.bodyLarge,),
                                    SizedBox(height: 10),
                                    Container(
                                      height: Constants.mediaQuery.height * 0.15,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                      ),
                                      child: Text(
                                        formData["comments"],
                                        style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                          color: Colors.black,
                                        ),
                                      ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                    ),
                                  ],
                                ).setVerticalPadding(context, enableMediaQuery: false, 20);
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
}