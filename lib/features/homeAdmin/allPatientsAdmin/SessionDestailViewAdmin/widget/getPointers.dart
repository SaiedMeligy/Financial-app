// import 'package:dio/dio.dart';
// import 'package:experts_app/core/extensions/padding_ext.dart';
// import 'package:experts_app/features/homeAdmin/allPatientsAdmin/SessionDestailViewAdmin/manager/cubit.dart';
// import 'package:experts_app/features/homeAdmin/allPatientsAdmin/SessionDestailViewAdmin/manager/states.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../../../core/Services/snack_bar_service.dart';
// import '../../../../../core/config/cash_helper.dart';
// import '../../../../../core/config/constants.dart';
// import '../../../../../core/widget/border_rounded_button.dart';
// import '../../../../../core/widget/check_box_question.dart';
// import '../../../../../core/widget/custom_text_field.dart';
// import '../../../../../core/widget/tab_item_widget.dart';
// import '../../../../../domain/entities/AdviceMode.dart';
// import '../../../../../domain/entities/QuestionModel.dart';
// import '../../../../../domain/entities/SessionUpdateModel.dart';
// import '../../../../homeAdvisor/addSessionWithAdvisor/manager/cubit.dart';
// import '../../../../homeAdvisor/addSessionWithAdvisor/manager/states.dart';
// import 'drop_down_with_admin.dart';
//
// class GetPointers extends StatefulWidget {
//   final String? nationalId;
//   final int id;
//   const GetPointers({Key? key, this.nationalId, required this.id}) : super(key: key);
//
//   @override
//   State<GetPointers> createState() => _GetPointersState();
// }
//
// class _GetPointersState extends State<GetPointers> {
//   List<Pointers> pointers1 = [];
//   List<Pointers> pointers2 = [];
//   List<Pointers> pointers3 = [];
//   List<Advices> advicesList = [];
//   List<Advices> addAdvicesList = [];
//   List<List<int>> selectedPointers1 = [];
//   List<List<int>> selectedPointers2 = [];
//   List<List<int>> selectedPointers3 = [];
//   List<List<int>> selectedAdvices = [];
//   List<List<int>> selectedQuestions = [];
//   var addSessionCubit = SessionCubit();
//   @override
//   void initState() {
//     addSessionCubit.getPatientDetails(widget.nationalId.toString());
//     fetchPointers();
//     fetchAdvices();
//
//   }
//   Widget build(BuildContext context) {
//     return  BlocBuilder<SessionCubit,States>(
//       bloc: addSessionCubit,
//       builder: (context, state) {
//         if (state is LoadingSessionState) {
//           return Center(child: CircularProgressIndicator());
//         } else if (state is ErrorSessionState) {
//           return Center(child: Text(state.errorMessage));
//         } else if (state is SuccessSessionState) {
//           var session = state.result.data["session"];
//           if (session == null) {
//             return Center(
//                 child: Text("No session data available."));
//           }
//           var patientName = session["pationt"]["name"] ?? "";
//           var advisorName = session["advicor"]["name"] ?? "";
//           var nationalId = session["pationt"]["national_id"] ?? "";
//           var caseManager = session["case_manager"] ?? "";
//           var phoneNumber = session["phone_number"] ?? "";
//           var otherPhoneNumber = session["other_phone_number"] ?? "";
//
//           if(phoneNumber.toString().contains('+')){
//             phoneNumber = phoneNumber.toString().replaceAll('+', '');
//             phoneNumber = '$phoneNumber+';
//           }
//           if(otherPhoneNumber.toString().contains('+')){
//             otherPhoneNumber = otherPhoneNumber.toString().replaceAll('+', '');
//             otherPhoneNumber = '$otherPhoneNumber+';
//           }
//
//           var isAttended = session["is_attended"] == 1;
//           var needOtherSession = session["need_other_session"] == 1;
//           var isSuccessStory = session["is_success_story"] == 1;
//           var serviceName = session["consultation_service"] !=
//               null
//               ? session["consultation_service"]["name"]
//               : "";
//           var serviceDescription = session["consultation_service"] !=
//               null
//               ? session["consultation_service"]["description"]
//               : "";
//           var advisorComments = session["advicor_comments"] ?? "";
//           // bool needSession = needOtherSession ? true : false;
//
//
//           var sessionDate = session["date"] ?? "";
//           int needSession = needOtherSession ? 1 : 0;
//           int successStory = isSuccessStory ? 1 : 0;
//           int attendSession = isAttended ? 1 : 0;
//
//           TextEditingController commentController = TextEditingController(text: advisorComments);
//           TextEditingController phoneController = TextEditingController(text:phoneNumber );
//           TextEditingController otherPhoneController = TextEditingController(text:otherPhoneNumber );
//           TextEditingController caseManagerController = TextEditingController(text:caseManager );
//
//
//           return
//             LayoutBuilder(
//               builder:(context, constraints) {
//                 bool isMobile = constraints.maxWidth < 600;
//
//                 return Directionality(
//                     textDirection: TextDirection.rtl,
//                     child:
//                     Container(
//                       decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage("assets/images/back.jpg"),
//                             fit: BoxFit.cover,
//                             opacity: 0.2,
//                           )
//                       ),
//                       // todo change
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           // Container(
//                           //   height: 50,
//                           //   width: 50,
//                           //   margin: EdgeInsets.all(10),
//                           //   decoration: BoxDecoration(
//                           //     color: Colors.white54,
//                           //     borderRadius: BorderRadius.circular(20),
//                           //   ),
//                           //   child: Center(
//                           //     child: IconButton(
//                           //       icon: Icon(Icons.print, color: Colors.black,size: 40,),
//                           //       onPressed: () async {
//                           //         print('sssssssssssssssssssssssss');
//                           //         final pdf = pw.Document();
//                           //         // final notoSans = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
//                           //         // final ttf = pw.Font.ttf(notoSans);
//                           //         final fontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
//                           //         final ttf = pw.Font.ttf(fontData);
//                           //
//                           //         // final image = pw.MemoryImage(
//                           //         //   (await rootBundle.load('assets/images/back.jpg')).buffer.asUint8List(),
//                           //         // );
//                           //         await Future.delayed(Duration(seconds: 1));
//                           //         pdf.addPage(
//                           //           pw.Page(
//                           //             build: (pw.Context context) {
//                           //               return
//                           //                 pw.Column(
//                           //                     crossAxisAlignment: pw.CrossAxisAlignment.end,
//                           //                     children: [
//                           //                       pw.Text(
//                           //                         "اسم الحالة :${patientName}" ,
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text(
//                           //                         "اسم الاستشارى :${advisorName}",
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text(
//                           //                         "رقم الهوية :${nationalId}",
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text(
//                           //                         "رقم الهاتف :${phoneNumber}",
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text(
//                           //                         "رقم بديل للهاتف :${otherPhoneNumber}",
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text(
//                           //                         "مدير الحالة : ${caseManager}",
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text(
//                           //                         isAttended
//                           //                             ? "الحالة حضرت الجلسة"
//                           //                             : "الحالة لم تحضر الجلسة",
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text(
//                           //                         needOtherSession
//                           //                             ? "الحالة بحاجه الى جلسة اخرى"
//                           //                             : "الحالة ليست بحاجه الى جلسة اخرى",
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text(
//                           //                         isSuccessStory
//                           //                             ? "الحالة قصة نجاح"
//                           //                             : "الحالة ليست قصة نجاح",
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text("الخدمة الاستشارية : ${serviceName}",
//                           //
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Text(
//                           //                         "وصف الخدمة الاستشارية : ${serviceDescription}",
//                           //                         style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
//                           //                         textDirection: pw.TextDirection.rtl,
//                           //                       ),
//                           //                       pw.Directionality(
//                           //                           textDirection: pw.TextDirection.rtl,
//                           //                           child:pw.Table(
//                           //                             border: pw.TableBorder.all(
//                           //                               color: PdfColors.black,
//                           //                               width: 1,
//                           //                             ),
//                           //                             children: [
//                           //                               pw.TableRow(
//                           //                                 children: [
//                           //                                   pw.Padding(
//                           //                                     padding: const pw.EdgeInsets.all(8.0),
//                           //                                     child: pw.Center(child:pw.Text(
//                           //                                       "الملاحظة",
//                           //                                       style: pw.TextStyle(font: ttf, fontSize: 14),
//                           //                                       textDirection: pw.TextDirection.rtl,
//                           //                                     ),
//                           //                                     ),
//                           //                                   ),
//                           //                                   pw.Padding(
//                           //                                       padding: const pw.EdgeInsets.all(8.0),
//                           //                                       child: pw.Container(
//                           //                                         width:400,
//                           //                                         child:pw.Center(child:pw.Text(
//                           //                                           "تاريخ الجلسة",
//                           //                                           style: pw.TextStyle(font: ttf, fontSize: 14),
//                           //                                           textDirection: pw.TextDirection.rtl,
//                           //                                         ),
//                           //                                         ),
//                           //                                       )
//                           //                                   )
//                           //                                 ],
//                           //                               ),
//                           //                               //  more rows as needed
//                           //                               pw.TableRow(
//                           //                                 children: [
//                           //                                   pw.Padding(
//                           //                                     padding: const pw.EdgeInsets.all(8.0),
//                           //                                     child:pw.Text(
//                           //                                       advisorComments,
//                           //                                       style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
//                           //                                       textDirection: pw.TextDirection.rtl,
//                           //                                     ),
//                           //                                   ),
//                           //                                   pw.Expanded( // Expands this column to take up more space
//                           //                                     child: pw.Center(child:pw.Text(
//                           //                                       sessionDate,
//                           //                                       style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
//                           //                                       textDirection: pw.TextDirection.rtl,
//                           //                                     ),
//                           //                                     ),
//                           //                                   )
//                           //                                 ],
//                           //                               ),
//                           //                             ],
//                           //                           )
//                           //
//                           //                       )
//                           //                     ]
//                           //                 );
//                           //             },
//                           //           ),
//                           //         );
//                           //
//                           //         try {
//                           //           final pdfBytes = await pdf.save();
//                           //           final blob = html.Blob([pdfBytes], 'application/pdf');
//                           //           final url = html.Url.createObjectUrlFromBlob(blob);
//                           //           html.window.open(url, '_blank');
//                           //           html.Url.revokeObjectUrl(url);
//                           //
//                           //           // Use the printing package to handle printing
//                           //           await Printing.layoutPdf(
//                           //             onLayout: (PdfPageFormat format) async => pdf.save(),
//                           //           );
//                           //
//                           //         } catch (e) {
//                           //           print('Error: $e');
//                           //         }
//                           //       },
//                           //     ),
//                           //   ),
//                           // ),
//                           Text(
//                             "اسم الحالة : $patientName",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             "اسم الاستشاري : $advisorName",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             "رقم الهوية : $nationalId",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: Text(
//                               "رقم الهاتف : $phoneNumber",
//                               style: isMobile ? Constants.theme
//                                   .textTheme.bodyMedium?.copyWith(
//                                 color: Colors.black,) : Constants.theme
//                                   .textTheme.bodyLarge?.copyWith(
//                                   color: Colors.black),
//                             ),
//                           ),
//                           Text(
//                             "رقم بديل للهاتف : $otherPhoneNumber",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             "مدير الحالة : $caseManager",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             isAttended
//                                 ? "الحالة حضرت الجلسة"
//                                 : "الحالة لم تحضر الجلسة",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             needOtherSession
//                                 ? "الحالة بحاجه الى جلسة اخرى"
//                                 : "الحالة ليست بحاجه الى جلسة اخرى",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             isSuccessStory
//                                 ? "الحالة قصة نجاح"
//                                 : "الحالة ليست قصة نجاح",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             "الخدمة الاستشارية : $serviceName",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           Text(
//                             "وصف الخدمة الاستشارية : $serviceDescription",
//                             style: isMobile ? Constants.theme
//                                 .textTheme.bodyMedium?.copyWith(
//                               color: Colors.black,) : Constants.theme
//                                 .textTheme.bodyLarge?.copyWith(
//                                 color: Colors.black),
//                           ),
//                           SizedBox(height: 20),
//                           Table(
//                             columnWidths: {
//                               0: FlexColumnWidth(4),
//                               1: isMobile
//                                   ? FlexColumnWidth(2)
//                                   : FlexColumnWidth(1),
//                             },
//                             children: [
//                               TableRow(
//                                 decoration: BoxDecoration(
//                                     color: Colors.black),
//                                 children: [
//                                   TableCell(
//                                     child: SizedBox(
//                                       height: 50,
//                                       child: Center(
//                                         child: Text(
//                                           "الملاحظة",
//                                           textAlign: TextAlign.center,
//                                           style: isMobile
//                                               ? Constants.theme
//                                               .textTheme.bodyMedium
//                                               ?.copyWith(
//                                             color: Colors.white,)
//                                               : Theme
//                                               .of(context)
//                                               .textTheme
//                                               .titleLarge
//                                               ?.copyWith(fontSize: 20,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   TableCell(
//                                     child: SizedBox(
//                                       height: 50,
//                                       width: 100,
//                                       child: Center(
//                                         child: Text(
//                                           "تاريخ الجلسة",
//                                           textAlign: TextAlign.center,
//                                           style: isMobile
//                                               ? Constants.theme
//                                               .textTheme.bodyMedium
//                                               ?.copyWith(
//                                             color: Colors.white,)
//                                               : Theme
//                                               .of(context)
//                                               .textTheme
//                                               .titleLarge
//                                               ?.copyWith(fontSize: 20,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               TableRow(
//                                 decoration: BoxDecoration(
//                                     color: Colors.black54),
//                                 children: [
//                                   TableCell(
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10.0),
//                                       child: Container(
//                                         alignment: Alignment.center,
//                                         child: SingleChildScrollView(
//                                           child: Column(
//                                             mainAxisAlignment: MainAxisAlignment
//                                                 .center,
//                                             children: [
//                                               Text(
//                                                 advisorComments,
//                                                 style: isMobile
//                                                     ? Constants.theme
//                                                     .textTheme
//                                                     .bodyMedium
//                                                     ?.copyWith(
//                                                   color: Colors
//                                                       .white,)
//                                                     : Theme
//                                                     .of(context)
//                                                     .textTheme
//                                                     .bodyLarge
//                                                     ?.copyWith(
//                                                     color: Colors
//                                                         .white),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   TableCell(
//                                     child: Container(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         sessionDate,
//                                         style: isMobile
//                                             ? Constants.theme
//                                             .textTheme.bodyMedium
//                                             ?.copyWith(
//                                           color: Colors.white,)
//                                             : Theme
//                                             .of(context)
//                                             .textTheme
//                                             .bodyLarge
//                                             ?.copyWith(
//                                             color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           BorderRoundedButton(
//                             title: "تعديل",
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (context) {
//                                   return Directionality(
//                                     textDirection: TextDirection.rtl,
//                                     child: AlertDialog(
//                                       backgroundColor: Constants.theme
//                                           .primaryColor.withOpacity(0.9),
//                                       content: Form(
//                                         key: formKey,
//                                         child: SizedBox(
//                                           height: Constants.mediaQuery
//                                               .height * 0.85,
//                                           width: Constants.mediaQuery
//                                               .width * 0.45,
//                                           child: ListView(
//                                               children: [
//                                                 Column(
//                                                   mainAxisAlignment: MainAxisAlignment
//                                                       .start,
//                                                   mainAxisSize: MainAxisSize
//                                                       .max,
//                                                   children: [
//                                                     CustomTextField(
//                                                       controller: phoneController,
//                                                       onValidate: (value) {
//                                                         if (value == null ||
//                                                             value
//                                                                 .trim()
//                                                                 .isEmpty) {
//                                                           return "Please enter phoneNumber";
//                                                         }
//                                                         return null;
//                                                       },
//                                                     ),
//                                                     const SizedBox(height: 10,),
//                                                     CustomTextField(
//                                                       controller: otherPhoneController,
//                                                       onValidate: (value) {
//                                                         if (value == null ||
//                                                             value
//                                                                 .trim()
//                                                                 .isEmpty) {
//                                                           return "Please enter otherPhoneNumber";
//                                                         }
//                                                         return null;
//                                                       },
//                                                     ),
//                                                     SizedBox(height: 10,),
//                                                     CustomTextField(
//                                                       controller: caseManagerController,
//                                                       onValidate: (value) {
//                                                         if (value == null ||
//                                                             value
//                                                                 .trim()
//                                                                 .isEmpty) {
//                                                           return "Please enter caseManager";
//                                                         }
//                                                         return null;
//                                                       },
//                                                     ),
//                                                     const SizedBox(height: 10,),
//                                                     StatefulBuilder(
//                                                       builder: (context,
//                                                           setState) {
//                                                         return Column(
//                                                           children: [
//                                                             Row(
//                                                               children: [
//                                                                 Radio<int>(
//                                                                   value: 1,
//                                                                   groupValue: attendSession,
//                                                                   onChanged: (
//                                                                       value) {
//                                                                     setState(() {
//                                                                       attendSession =
//                                                                       value!;
//                                                                       isAttended =
//                                                                           attendSession ==
//                                                                               1;
//                                                                     });
//                                                                   },
//                                                                 ),
//                                                                 Text(
//                                                                   "الحالة حضرت الجلسة",
//                                                                   style: Constants
//                                                                       .theme
//                                                                       .textTheme
//                                                                       .bodyMedium
//                                                                       ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),),
//                                                               ],
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 Radio<int>(
//                                                                   value: 0,
//                                                                   groupValue: attendSession,
//                                                                   onChanged: (
//                                                                       value) {
//                                                                     setState(() {
//                                                                       attendSession =
//                                                                       value!;
//                                                                       isAttended =
//                                                                           attendSession ==
//                                                                               1;
//                                                                     });
//                                                                   },
//                                                                 ),
//                                                                 Text(
//                                                                   "الحالة لم تحضر الجلسة",
//                                                                   style: Constants
//                                                                       .theme
//                                                                       .textTheme
//                                                                       .bodyMedium
//                                                                       ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),),
//                                                               ],
//                                                             ),
//                                                             Divider(
//                                                               color: Colors
//                                                                   .black54,
//                                                               indent: 10,
//                                                               endIndent: 25,
//                                                               thickness: 2,),
//                                                             Row(
//                                                               children: [
//                                                                 Radio<int>(
//                                                                   value: 1,
//                                                                   // Needing another session
//                                                                   groupValue: needSession,
//                                                                   onChanged: (
//                                                                       value) {
//                                                                     setState(() {
//                                                                       needSession =
//                                                                       value!;
//                                                                       needOtherSession =
//                                                                           needSession ==
//                                                                               1;
//                                                                     });
//                                                                   },
//                                                                 ),
//                                                                 Text(
//                                                                   "الحالة بحاجه إلى جلسة اخرى",
//                                                                   style: Constants
//                                                                       .theme
//                                                                       .textTheme
//                                                                       .bodyMedium
//                                                                       ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),),
//                                                               ],
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 Radio<int>(
//                                                                   value: 0,
//                                                                   // Not needing another session
//                                                                   groupValue: needSession,
//                                                                   onChanged: (
//                                                                       value) {
//                                                                     setState(() {
//                                                                       needSession =
//                                                                       value!;
//                                                                       needOtherSession =
//                                                                           needSession ==
//                                                                               1;
//                                                                     });
//                                                                   },
//                                                                 ),
//                                                                 Text(
//                                                                   "الحالة ليست بحاجه إلى جلسة اخرى",
//                                                                   style: Constants
//                                                                       .theme
//                                                                       .textTheme
//                                                                       .bodyMedium
//                                                                       ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),),
//                                                               ],
//                                                             ),
//                                                             Divider(
//                                                               color: Colors
//                                                                   .black54,
//                                                               indent: 10,
//                                                               endIndent: 25,
//                                                               thickness: 2,),
//                                                             Row(
//                                                               children: [
//                                                                 Radio<int>(
//                                                                   value: 1,
//                                                                   // Needing another session
//                                                                   groupValue: successStory,
//                                                                   onChanged: (
//                                                                       value) {
//                                                                     setState(() {
//                                                                       successStory =
//                                                                       value!;
//                                                                       isSuccessStory =
//                                                                           successStory ==
//                                                                               1;
//                                                                     });
//                                                                   },
//                                                                 ),
//                                                                 Text(
//                                                                   "الحالة قصة نجاح",
//                                                                   style: Constants
//                                                                       .theme
//                                                                       .textTheme
//                                                                       .bodyMedium
//                                                                       ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),),
//                                                               ],
//                                                             ),
//                                                             Row(
//                                                               children: [
//                                                                 Radio<int>(
//                                                                   value: 0,
//                                                                   // Not needing another session
//                                                                   groupValue: successStory,
//                                                                   onChanged: (
//                                                                       value) {
//                                                                     setState(() {
//                                                                       successStory =
//                                                                       value!;
//                                                                       isSuccessStory =
//                                                                           successStory ==
//                                                                               1;
//                                                                     });
//                                                                   },
//                                                                 ),
//                                                                 Text(
//                                                                   "الحالة ليست قصة نجاح",
//                                                                   style: Constants
//                                                                       .theme
//                                                                       .textTheme
//                                                                       .bodyMedium
//                                                                       ?.copyWith(
//                                                                       color: Colors
//                                                                           .black),),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         );
//                                                       },
//                                                     ),
//                                                     SizedBox(height: 10,),
//                                                     Row(
//                                                       mainAxisAlignment: MainAxisAlignment
//                                                           .start,
//                                                       children: [
//                                                         DropDownWithAdmin(
//                                                           onChange: (value) {
//                                                             setState(() {
//                                                               selected_consultation_service =
//                                                                   value;
//                                                             });
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                     SizedBox(height: 10,),
//                                                     CustomTextField(
//                                                       controller: commentController,
//                                                       onValidate: (value) {
//                                                         if (value == null ||
//                                                             value
//                                                                 .trim()
//                                                                 .isEmpty) {
//                                                           return "Please enter the service name";
//                                                         }
//                                                         return null;
//                                                       },
//                                                     ),
//                                                     const SizedBox(height: 10,),
//                                                     // Using StatefulBuilder for dialog refresh
//
//
//                                                   ],
//                                                 ).setHorizontalPadding(context,
//                                                     enableMediaQuery: false,
//                                                     20),
//                                               ]),
//                                         ),
//                                       ),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () {
//                                             if (formKey.currentState!
//                                                 .validate()) {
//                                               var data = SessionsUpdateModel(
//                                                 sessionId: widget.sessionId,
//                                                 comments: commentController
//                                                     .text,
//                                                 consultationId: selected_consultation_service,
//                                                 needOtherSession: needSession,
//                                                 isSuccessStory: successStory,
//                                                 isAttend: attendSession,
//                                                 phoneNumber: phoneController
//                                                     .text,
//                                                 otherPhoneNumber: otherPhoneController
//                                                     .text,
//                                                 caseManager: caseManagerController
//                                                     .text,
//                                               );
//                                               updateSessionCubit
//                                                   .updateSessionWithAdmin(data)
//                                                   .then((_) {
//                                                 Navigator.pop(context);
//                                                 _patientSessionCubit
//                                                     .onRefreshSession(
//                                                     controller, context);
//                                                 _patientSessionCubit
//                                                     .showSessionWithAdmin(
//                                                     widget.sessionId);
//                                               });
//                                             }
//                                           },
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius
//                                                   .circular(10),
//                                               border: Border.all(
//                                                 color: Colors.black87,
//                                                 width: 2.5,
//                                               ),
//                                             ),
//                                             child: Text(
//                                               "موافق",
//                                               style: Constants.theme.textTheme
//                                                   .bodyMedium?.copyWith(
//                                                   color: Colors.black),
//                                             ).setHorizontalPadding(context,
//                                                 enableMediaQuery: false, 20),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//
//                           ).setVerticalPadding(
//                               context, enableMediaQuery: false, 20),
//
//                         ],
//                       )
//                           .setHorizontalPadding(
//                           context, enableMediaQuery: false, 20)
//                           .setHorizontalPadding(
//                           context, enableMediaQuery: false, 10),
//                     )
//                 );
//               }
//             );
//         }
//
//         return Container();
//       },
//     );
//     //   BlocBuilder<SessionCubit, States>(
//     //   bloc:addSessionCubit,
//     //   builder: (context, state) {
//     //     if (state is LoadingSessionState) {
//     //       return const Center(child: CircularProgressIndicator());
//     //     }
//     //     else if (state is ErrorSessionState) {
//     //       return Center(child: Text(state.errorMessage));
//     //     }
//     //     else if (state is SuccessNationalIdState) {
//     //
//     //       var pointers = state.result.data["pationt"]["pointers"] ?? [];
//     //       var patient = state.result.data["pationt"] ?? [];
//     //       var advices = state.result.data["pationt"]["advices"] ?? [];
//     //
//     //       List<dynamic> pointers1Temp = [];
//     //       List<dynamic> pointers2Temp = [];
//     //       List<dynamic> pointers3Temp = [];
//     //
//     //       for (var pointer in pointers) {
//     //         if (pointer["id"] == 1) {
//     //           pointers1Temp.add(pointer);
//     //         } else if (pointer["id"] == 2) {
//     //           pointers2Temp.add(pointer);
//     //         } else if (pointer["id"] == 3) {
//     //           pointers3Temp.add(pointer);
//     //         }
//     //       }
//     //       // Expanded(
//     //       //   child: TabItemWidget(
//     //       //     item1: "السيناريوالأول(الحالات المتوازنة نسبيا)",
//     //       //     item2: "السيناريوالثاني(للحالات الغير متوازنة في الصرف)",
//     //       //     item3: "السيناريوالثالث(للحالات المتعثرة ماليا)",
//     //       //     firstWidget: Container(
//     //       //       color: Constants.theme.primaryColor.withOpacity(0.4),
//     //       //       child: ListView.builder(
//     //       //         itemCount: pointers1Temp.length,
//     //       //         itemBuilder: (context, index) {
//     //       //           var pationtPointers = pointers1Temp[index]["pationt_pointers"] ?? [];
//     //       //           return Column(
//     //       //             crossAxisAlignment: CrossAxisAlignment.start,
//     //       //             children: [
//     //       //               for (var pointer in pationtPointers)
//     //       //                 Row(
//     //       //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //       //                   children: [
//     //       //                     Expanded(
//     //       //                       child: Text(
//     //       //                         pointer["text"],
//     //       //                         style: TextStyle(
//     //       //                           fontSize: isMobile?14:20,
//     //       //                           fontWeight: FontWeight.bold,
//     //       //                           color: Colors.black,
//     //       //                         ),
//     //       //                       ),
//     //       //                     ),
//     //       //                     IconButton(onPressed: (){
//     //       //                       deletePointers(patient["id"], pointer["id"]);
//     //       //                       addSessionCubit.setRefresh(widget.pationt_data.nationalId);
//     //       //                     }, icon: Icon(Icons.delete))
//     //       //                   ],
//     //       //                 ),
//     //       //             ],
//     //       //           ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//     //       //         },
//     //       //       ),
//     //       //     ),
//     //       //     secondWidget: Container(
//     //       //       color: Constants.theme.primaryColor.withOpacity(0.4),
//     //       //       child: ListView.builder(
//     //       //         itemCount: pointers2Temp.length,
//     //       //         itemBuilder: (context, index) {
//     //       //           var pationtPointers = pointers2Temp[index]["pationt_pointers"] ?? [];
//     //       //           return Column(
//     //       //             crossAxisAlignment: CrossAxisAlignment.start,
//     //       //             children: [
//     //       //               for (var pointer in pationtPointers)
//     //       //                 Row(
//     //       //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //       //                   children: [
//     //       //                     Expanded(
//     //       //                       child: Text(
//     //       //                         pointer["text"],
//     //       //                         style: TextStyle(
//     //       //                           fontSize: isMobile?14:20,
//     //       //                           fontWeight: FontWeight.bold,
//     //       //                           color: Colors.black,
//     //       //                         ),
//     //       //                       ),
//     //       //                     ),
//     //       //                     IconButton(onPressed: (){
//     //       //                       deletePointers(patient["id"], pointer["id"]);
//     //       //                       addSessionCubit.setRefresh(widget.pationt_data.nationalId);
//     //       //
//     //       //
//     //       //                     }, icon: Icon(Icons.delete))
//     //       //                   ],
//     //       //                 ),
//     //       //             ],
//     //       //           ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//     //       //         },
//     //       //       ),
//     //       //     ),
//     //       //     thirdWidget: Container(
//     //       //       color: Constants.theme.primaryColor.withOpacity(0.4),
//     //       //       child: ListView.builder(
//     //       //         itemCount: pointers3Temp.length,
//     //       //         itemBuilder: (context, index) {
//     //       //           var pationtPointers = pointers3Temp[index]["pationt_pointers"] ?? [];
//     //       //           return Column(
//     //       //             crossAxisAlignment: CrossAxisAlignment.start,
//     //       //             children: [
//     //       //               for (var pointer in pationtPointers)
//     //       //                 Row(
//     //       //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //       //                   children: [
//     //       //                     Expanded(
//     //       //                       child: Text(
//     //       //                         pointer["text"],
//     //       //                         style: TextStyle(
//     //       //                           fontSize: isMobile?14:20,
//     //       //                           fontWeight: FontWeight.bold,
//     //       //                           color: Colors.black,
//     //       //                         ),
//     //       //                       ),
//     //       //                     ),
//     //       //                     IconButton(onPressed: (){
//     //       //                       deletePointers(patient["id"], pointer["id"]);
//     //       //                       addSessionCubit.setRefresh(widget.pationt_data.nationalId);
//     //       //                     }, icon: Icon(Icons.delete))
//     //       //                   ],
//     //       //                 ),
//     //       //
//     //       //             ],
//     //       //           ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//     //       //         },
//     //       //       ),
//     //       //     ),
//     //       //   ),
//     //       // ), //todo
//     //       IconButton(
//     //         onPressed: () {
//     //           selectedPointers1.clear();
//     //           selectedPointers2.clear();
//     //           selectedPointers3.clear();
//     //           showDialog(
//     //             context: context,
//     //             builder: (context) {
//     //               return AlertDialog(
//     //
//     //                 backgroundColor: Colors.black,
//     //                 title: Container(
//     //                   alignment: Alignment.center,
//     //                   decoration: BoxDecoration(
//     //                     borderRadius: BorderRadius.circular(10),
//     //                     border: Border.all(
//     //                       color: Constants.theme.primaryColor,
//     //                       width: 2.5,
//     //                     ),
//     //                   ),
//     //                   child: Text(
//     //                     "اختر من المؤشرات",
//     //                     style:Constants.theme.textTheme.titleLarge,
//     //                   ),
//     //                 ),
//     //                 content: SizedBox(
//     //                   height: Constants.mediaQuery.height * 0.6,
//     //                   width: Constants.mediaQuery.width * 0.45,
//     //                   child: TabItemWidget(
//     //                     item1: "السيناريو الاول",
//     //                     item2: "السيناريو التاني",
//     //                     item3: "السيناريو التالت",
//     //                     firstWidget: CheckBoxQuestion(
//     //                       items: pointers1,
//     //                       previous: selectedPointers1.isNotEmpty ? selectedPointers1[0] : [],
//     //                       onChanged: (value) {
//     //                         setState(() {
//     //                           if (selectedPointers1.isEmpty) {
//     //                             selectedPointers1.add(value!);
//     //                           } else {
//     //                             selectedPointers1[0] = value!;
//     //                           }
//     //                         });
//     //                       },
//     //                     ),
//     //                     secondWidget: CheckBoxQuestion(
//     //                       previous: selectedPointers2.isNotEmpty ? selectedPointers2[0] : [],
//     //                       items: pointers2,
//     //                       onChanged: (value) {
//     //                         setState(() {
//     //                           if (selectedPointers2.isEmpty) {
//     //                             selectedPointers2.add(value!);
//     //                           } else {
//     //                             selectedPointers2[0] = value!;
//     //                           }
//     //                         });
//     //                       },
//     //                     ),
//     //                     thirdWidget: CheckBoxQuestion(
//     //                       previous: selectedPointers3.isNotEmpty ? selectedPointers3[0] : [],
//     //                       items: pointers3,
//     //                       onChanged: (value) {
//     //                         setState(() {
//     //                           if (selectedPointers3.isEmpty) {
//     //                             selectedPointers3.add(value!);
//     //                           } else {
//     //                             selectedPointers3[0] = value!;
//     //                           }
//     //                         });
//     //                       },
//     //                     ),
//     //                   ),
//     //                 ),
//     //                 actions: [
//     //                   TextButton(
//     //                     onPressed: () async {
//     //                       List<int> selectedPointersIds = [];
//     //                       if (selectedPointers1.isNotEmpty) {
//     //                         selectedPointersIds.addAll(selectedPointers1.expand((x) => x));
//     //                       }
//     //                       if (selectedPointers2.isNotEmpty) {
//     //                         selectedPointersIds.addAll(selectedPointers2.expand((x) => x));
//     //                       }
//     //                       if (selectedPointers3.isNotEmpty) {
//     //                         selectedPointersIds.addAll(selectedPointers3.expand((x) => x));
//     //                       }
//     //
//     //                       if (selectedPointersIds.isNotEmpty) {
//     //                         for (var pointerId in selectedPointersIds) {
//     //                           try {
//     //                             await addPointers(pointerId,widget.id);
//     //                           } catch (e) {
//     //                             print('Error adding pointerId $pointerId: $e');
//     //                           }
//     //                         }
//     //                         addSessionCubit.setRefresh(widget.nationalId.toString());
//     //                       }
//     //                       Navigator.of(context).pop();
//     //                     },
//     //                     child: Container(
//     //                       decoration: BoxDecoration(
//     //                         borderRadius: BorderRadius.circular(10),
//     //                         border: Border.all(
//     //                           color: Constants.theme.primaryColor,
//     //                           width: 2.5,
//     //                         ),
//     //                       ),
//     //                       child: Text(
//     //                         "موافق",
//     //                         style: Constants.theme.textTheme.bodyMedium,
//     //                       ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//     //                     ),
//     //                   ),
//     //                 ],
//     //               );
//     //             },
//     //           );
//     //         },
//     //         icon: Icon(Icons.add_circle_rounded),
//     //       );
//     //       // Expanded(
//     //       //   child: Container(
//     //       //     color: Constants.theme.primaryColor.withOpacity(0.4),
//     //       //     child: ListView.builder(
//     //       //       itemCount: advices.length,
//     //       //       itemBuilder: (context, index) {
//     //       //         return Column(
//     //       //           crossAxisAlignment: CrossAxisAlignment.start,
//     //       //           children: [
//     //       //             Row(
//     //       //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //       //               children: [
//     //       //                 Expanded(
//     //       //                   child: Text(
//     //       //                     advices[index]["text"],
//     //       //                     style: Constants.theme.textTheme.bodyLarge?.copyWith(
//     //       //                         color: Colors.black,
//     //       //                         fontSize: isMobile?14:20
//     //       //                     ),
//     //       //                   ),
//     //       //                 ),
//     //       //                 IconButton(onPressed: ()async{
//     //       //                   await deleteAdvices(patient["id"], advices[index]["id"]);
//     //       //                   addSessionCubit.setRefresh(widget.pationt_data.nationalId);
//     //       //                 }, icon: Icon(Icons.delete))
//     //       //               ],
//     //       //             ).setHorizontalPadding(context,enableMediaQuery: false,10 ),
//     //       //           ],
//     //       //         );
//     //       //       },
//     //       //     ),
//     //       //   ),
//     //       // ),
//     //
//     //
//     //       if (pointers.isEmpty && advices.isEmpty) {
//     //         return const Center(child: Text("No data available"));
//     //       }
//     //
//     //       // Handle and display pointers/advices...
//     //       Container(
//     //         height: Constants.mediaQuery.height*0.4,
//     //         decoration: BoxDecoration(
//     //           border: Border.all(
//     //             width: 2,
//     //             color: Colors.black,
//     //           ),
//     //         ),
//     //         child: Column(
//     //           children: [
//     //             Row(
//     //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //               children: [
//     //
//     //                 Spacer(),
//     //                 Text(
//     //                   "المؤشرات",
//     //                   textAlign: TextAlign.center,
//     //                   style: Constants.theme.textTheme.titleLarge?.copyWith(
//     //                     color: Colors.black,
//     //                   ),
//     //                 ),
//     //                 Spacer(),
//     //                 IconButton(
//     //                   onPressed: () {
//     //                     selectedPointers1.clear();
//     //                     selectedPointers2.clear();
//     //                     selectedPointers3.clear();
//     //                     showDialog(
//     //                       context: context,
//     //                       builder: (context) {
//     //                         return AlertDialog(
//     //
//     //                           backgroundColor: Colors.black,
//     //                           title: Container(
//     //                             alignment: Alignment.center,
//     //                             decoration: BoxDecoration(
//     //                               borderRadius: BorderRadius.circular(10),
//     //                               border: Border.all(
//     //                                 color: Constants.theme.primaryColor,
//     //                                 width: 2.5,
//     //                               ),
//     //                             ),
//     //                             child: Text(
//     //                               "اختر من المؤشرات",
//     //                               style: Constants.theme.textTheme.titleLarge,
//     //                             ),
//     //                           ),
//     //                           content: SizedBox(
//     //                             height: Constants.mediaQuery.height * 0.6,
//     //                             width: Constants.mediaQuery.width * 0.45,
//     //                             child: TabItemWidget(
//     //                               item1: "السيناريو الاول",
//     //                               item2: "السيناريو التاني",
//     //                               item3: "السيناريو التالت",
//     //                               firstWidget: CheckBoxQuestion(
//     //                                 items: pointers1,
//     //                                 previous: selectedPointers1.isNotEmpty ? selectedPointers1[0] : [],
//     //                                 onChanged: (value) {
//     //                                   setState(() {
//     //                                     if (selectedPointers1.isEmpty) {
//     //                                       selectedPointers1.add(value!);
//     //                                     } else {
//     //                                       selectedPointers1[0] = value!;
//     //                                     }
//     //                                   });
//     //                                 },
//     //                               ),
//     //                               secondWidget: CheckBoxQuestion(
//     //                                 previous: selectedPointers2.isNotEmpty ? selectedPointers2[0] : [],
//     //                                 items: pointers2,
//     //                                 onChanged: (value) {
//     //                                   setState(() {
//     //                                     if (selectedPointers2.isEmpty) {
//     //                                       selectedPointers2.add(value!);
//     //                                     } else {
//     //                                       selectedPointers2[0] = value!;
//     //                                     }
//     //                                   });
//     //                                 },
//     //                               ),
//     //                               thirdWidget: CheckBoxQuestion(
//     //                                 previous: selectedPointers3.isNotEmpty ? selectedPointers3[0] : [],
//     //                                 items: pointers3,
//     //                                 onChanged: (value) {
//     //                                   setState(() {
//     //                                     if (selectedPointers3.isEmpty) {
//     //                                       selectedPointers3.add(value!);
//     //                                     } else {
//     //                                       selectedPointers3[0] = value!;
//     //                                     }
//     //                                   });
//     //                                 },
//     //                               ),
//     //                             ),
//     //                           ),
//     //                           actions: [
//     //                             TextButton(
//     //                               onPressed: () async {
//     //                                 List<int> selectedPointersIds = [];
//     //                                 if (selectedPointers1.isNotEmpty) {
//     //                                   selectedPointersIds.addAll(selectedPointers1.expand((x) => x));
//     //                                 }
//     //                                 if (selectedPointers2.isNotEmpty) {
//     //                                   selectedPointersIds.addAll(selectedPointers2.expand((x) => x));
//     //                                 }
//     //                                 if (selectedPointers3.isNotEmpty) {
//     //                                   selectedPointersIds.addAll(selectedPointers3.expand((x) => x));
//     //                                 }
//     //
//     //                                 if (selectedPointersIds.isNotEmpty) {
//     //                                   for (var pointerId in selectedPointersIds) {
//     //                                     try {
//     //                                       await addPointers(pointerId, patient["id"]);
//     //                                     } catch (e) {
//     //                                       print('Error adding pointerId $pointerId: $e');
//     //                                     }
//     //                                   }
//     //                                   addSessionCubit.setRefresh(patient['national_id']);
//     //                                 }
//     //                                 Navigator.of(context).pop();
//     //                               },
//     //                               child: Container(
//     //                                 decoration: BoxDecoration(
//     //                                   borderRadius: BorderRadius.circular(10),
//     //                                   border: Border.all(
//     //                                     color: Constants.theme.primaryColor,
//     //                                     width: 2.5,
//     //                                   ),
//     //                                 ),
//     //                                 child: Text(
//     //                                   "موافق",
//     //                                   style: Constants.theme.textTheme.bodyMedium,
//     //                                 ).setHorizontalPadding(context, enableMediaQuery: false, 20),
//     //                               ),
//     //                             ),
//     //                           ],
//     //                         );
//     //                       },
//     //                     );
//     //                   },
//     //                   icon: Icon(Icons.add_circle_rounded),
//     //                 ),
//     //               ],
//     //             ).setVerticalPadding(context,enableMediaQuery: false, 3),
//     //             Expanded(
//     //               child: TabItemWidget(
//     //                 item1: "السيناريوالأول(الحالات المتوازنة نسبيا)",
//     //                 item2: "السيناريوالثاني(للحالات الغير متوازنة في الصرف)",
//     //                 item3: "السيناريوالثالث(للحالات المتعثرة ماليا)",
//     //                 firstWidget: Container(
//     //                   color: Constants.theme.primaryColor.withOpacity(0.4),
//     //                   child: ListView.builder(
//     //                     itemCount: pointers1Temp.length,
//     //                     itemBuilder: (context, index) {
//     //                       var pationtPointers = pointers1Temp[index]["pationt_pointers"] ?? [];
//     //                       return Column(
//     //                         crossAxisAlignment: CrossAxisAlignment.start,
//     //                         children: [
//     //                           for (var pointer in pationtPointers)
//     //                             Row(
//     //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                               children: [
//     //                                 Expanded(
//     //                                   child: Text(
//     //                                     pointer["text"],
//     //                                     style: TextStyle(
//     //                                       fontSize: 20,
//     //                                       fontWeight: FontWeight.bold,
//     //                                       color: Colors.black,
//     //                                     ),
//     //                                   ),
//     //                                 ),
//     //                                 IconButton(onPressed: (){
//     //                                   deletePointers(patient["id"], pointer["id"]);
//     //                                   addSessionCubit.setRefresh(patient['national_id']);
//     //                                 }, icon: Icon(Icons.delete))
//     //                               ],
//     //                             ),
//     //                         ],
//     //                       ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//     //                     },
//     //                   ),
//     //                 ),
//     //                 secondWidget: Container(
//     //                   color: Constants.theme.primaryColor.withOpacity(0.4),
//     //                   child: ListView.builder(
//     //                     itemCount: pointers2Temp.length,
//     //                     itemBuilder: (context, index) {
//     //                       var pationtPointers = pointers2Temp[index]["pationt_pointers"] ?? [];
//     //                       return Column(
//     //                         crossAxisAlignment: CrossAxisAlignment.start,
//     //                         children: [
//     //                           for (var pointer in pationtPointers)
//     //                             Row(
//     //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                               children: [
//     //                                 Expanded(
//     //                                   child: Text(
//     //                                     pointer["text"],
//     //                                     style: TextStyle(
//     //                                       fontSize: 20,
//     //                                       fontWeight: FontWeight.bold,
//     //                                       color: Colors.black,
//     //                                     ),
//     //                                   ),
//     //                                 ),
//     //                                 IconButton(onPressed: (){
//     //                                   deletePointers(patient["id"], pointer["id"]);
//     //                                   addSessionCubit.setRefresh(patient['national_id']);
//     //
//     //
//     //                                 }, icon: Icon(Icons.delete))
//     //                               ],
//     //                             ),
//     //                         ],
//     //                       ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//     //                     },
//     //                   ),
//     //                 ),
//     //                 thirdWidget: Container(
//     //                   color: Constants.theme.primaryColor.withOpacity(0.4),
//     //                   child: ListView.builder(
//     //                     itemCount: pointers3Temp.length,
//     //                     itemBuilder: (context, index) {
//     //                       var pationtPointers = pointers3Temp[index]["pationt_pointers"] ?? [];
//     //                       return Column(
//     //                         crossAxisAlignment: CrossAxisAlignment.start,
//     //                         children: [
//     //                           for (var pointer in pationtPointers)
//     //                             Row(
//     //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //                               children: [
//     //                                 Expanded(
//     //                                   child: Text(
//     //                                     pointer["text"],
//     //                                     style: TextStyle(
//     //                                       fontSize: 20,
//     //                                       fontWeight: FontWeight.bold,
//     //                                       color: Colors.black,
//     //                                     ),
//     //                                   ),
//     //                                 ),
//     //                                 IconButton(onPressed: (){
//     //                                   deletePointers(patient["id"], pointer["id"]);
//     //                                   addSessionCubit.setRefresh(patient['national_id']);
//     //                                 }, icon: Icon(Icons.delete))
//     //                               ],
//     //                             ),
//     //
//     //                         ],
//     //                       ).setHorizontalPadding(context,enableMediaQuery: false,10 );
//     //                     },
//     //                   ),
//     //                 ),
//     //               ),
//     //             ),
//     //           ],
//     //         ),
//     //       );
//     //     }
//     //
//     //     return const Center(child: Text("Something went wrong"));
//     //   },
//     // );
//   }
//   Future<void> fetchPointers() async {
//     final dio = Dio();
//     try {
//       final response = await dio.get(
//         '${Constants.baseUrl}/api/pointer',
//         options: Options(headers: {
//           "api-password": Constants.apiPassword,
//           "token": CacheHelper.getData(key: "token")
//         }),
//       );
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data["pointers"];
//         List<Pointers> pointers = [];
//         List<Pointers> pointers1Temp = [];
//         List<Pointers> pointers2Temp = [];
//         List<Pointers> pointers3Temp = [];
//
//         pointers = data.map((json) => Pointers.fromJson(json)).toList();
//         pointers.forEach(
//               (pointer) {
//             if (pointer.senarioId == 1) {
//               pointers1Temp.add(pointer);
//             } else if (pointer.senarioId == 2) {
//               pointers2Temp.add(pointer);
//             } else if (pointer.senarioId == 3) {
//               pointers3Temp.add(pointer);
//             }
//           },
//         );
//         setState(() {
//           pointers1 = pointers1Temp;
//           pointers2 = pointers2Temp;
//           pointers3 = pointers3Temp;
//         });
//       } else {
//         print('Failed to load users. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//   }
//   Future<void> addPointers(int pointerId, int patientId) async {
//     final dio = Dio();
//     try {
//       final response = await dio.post(
//           '${Constants.baseUrl}/api/pationt/add-patient-pointer',
//           options: Options(headers: {
//             "api-password": Constants.apiPassword,
//             "token": CacheHelper.getData(key: "token")
//           }),
//           data: {
//             "patient_id": patientId,
//             "pointer_id": pointerId,
//           }
//       );
//       if (response.statusCode == 200) {
//         print('Success: ${response.data["message"]}');
//         SnackBarService.showSuccessMessage(response.data["message"]);
//
//       } else {
//         print('Failed to add pointer. Status code: ${response.statusCode}');
//         SnackBarService.showErrorMessage(response.data["message"]);
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//       SnackBarService.showErrorMessage(e.toString());
//     }
//   }
//   Future<void> deletePointers(int patientId, int pointerId) async {
//     final dio = Dio();
//     try {
//       final response = await dio.post(
//           '${Constants.baseUrl}/api/pationt/delete-patient-pointer',
//           options: Options(headers: {
//             "api-password": Constants.apiPassword,
//             "token": CacheHelper.getData(key: "token")
//           }),
//           data: {
//             "patient_id": patientId,
//             "pointer_id": pointerId,
//           }
//       );
//       if (response.statusCode == 200) {
//         print('------------------>>>${response.data["message"]}');
//         SnackBarService.showSuccessMessage(response.data["message"]);
//
//       } else {
//         print('Failed to load users. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//       SnackBarService.showErrorMessage(e.toString());
//
//     }
//   }
//   Future<void> fetchAdvices() async {
//     final dio = Dio();
//     try {
//       final response = await dio.get(
//         '${Constants.baseUrl}/api/advice',
//         options: Options(headers: {
//           "api-password": Constants.apiPassword,
//           "token": CacheHelper.getData(key: "token")
//         }),
//       );
//       if (response.statusCode == 200) {
//         final List<dynamic> data = response.data["advices"];
//         print(data);
//         List<Advices> advicesdata = [];
//         advicesdata = data.map((json) => Advices.fromJson(json)).toList();
//         setState(() {
//           advicesList = advicesdata;
//         });
//       } else {
//         print('Failed to load users. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//     }
//   }
//   Future<void> addAdvices(int adviceId, int patientId) async {
//     final dio = Dio();
//     try {
//       final response = await dio.post(
//         '${Constants.baseUrl}/api/pationt/add-patient-advice',
//         options: Options(headers: {
//           "api-password": Constants.apiPassword,
//           "token": CacheHelper.getData(key: "token"),
//         }),
//         data: {
//           "patient_id": patientId,
//           "advice_id": adviceId,
//         },
//       );
//       if (response.statusCode == 200) {
//         if (response.data["status"] == true) {
//           print('${response.data["message"]}');
//           SnackBarService.showSuccessMessage(response.data["message"]);
//
//
//         } else {
//           print('Error: ${response.data["message"]}');
//           SnackBarService.showErrorMessage(response.data["message"]);
//         }
//       } else {
//         print('Failed to load advices. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//       SnackBarService.showErrorMessage(e.toString());
//
//     }
//   }
//   Future<void> deleteAdvices(int patientId, int adviceId) async {
//     final dio = Dio();
//     try {
//       final response = await dio.post(
//           '${Constants.baseUrl}/api/pationt/delete-patient-advice',
//           options: Options(headers: {
//             "api-password": Constants.apiPassword,
//             "token": CacheHelper.getData(key: "token")
//           }),
//           data: {
//             "patient_id": patientId,
//             "advice_id": adviceId,
//           }
//       );
//       if (response.statusCode == 200) {
//         print('mmmmmmmmmmmmm${response.data["message"]}');
//         SnackBarService.showSuccessMessage(response.data["message"]);
//       } else {
//         print('Failed to load users. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error occurred: $e');
//       SnackBarService.showErrorMessage(e.toString());
//     }
//   }
// }
