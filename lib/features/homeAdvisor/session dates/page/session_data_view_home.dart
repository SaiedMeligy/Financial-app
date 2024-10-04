import 'package:animate_do/animate_do.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/sessions/manager/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../../../core/widget/border_rounded_button.dart';
import '../../sessions/manager/states.dart';
import '../../viewQuestion/widget/drop_down.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;


// ignore: must_be_immutable
class SessionDetailsViewHome extends StatefulWidget {
  final dynamic pationt_data;
  final int sessionId;
  final int isFinished;
  final int? isAttend;
  String? sessionCaseManager;
  String? sessionComment;
  String? sessionDate;
  dynamic consultationService;


  SessionDetailsViewHome({super.key, required this.pationt_data,required this.sessionId,required this.isFinished,required this.sessionCaseManager,required this.isAttend, required this.sessionComment,required this.sessionDate,required this.consultationService});

  @override
  State<SessionDetailsViewHome> createState() => _SessionDetailsViewHomeState();
}

class _SessionDetailsViewHomeState extends State<SessionDetailsViewHome> {
  int needOtherSession = 0;
  int isAttendSelected = 0;
  int isSuccessStorySelected = 0;
  int selected_consultation_service = 0;
  TextEditingController advisorComment = TextEditingController();
  late AddSessionCubit _patientSessionCubit;
  late UpdateSessionCubit updateSessionCubit;
  var formKey = GlobalKey<FormState>();
  late var caseManager;
  late var session;
  bool isMobile = false;

  @override
  void initState() {
    super.initState();
    _patientSessionCubit = AddSessionCubit();
    // _patientSessionCubit.getSessionDetails(widget.pationt_data.nationalId);
    _patientSessionCubit.showSession(widget.sessionId);
    updateSessionCubit = UpdateSessionCubit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "استمارة برنامج الارشاد المالي",
        ),
        centerTitle: true,
        titleTextStyle: Constants.theme.textTheme.titleLarge,
        backgroundColor: Constants.theme.primaryColor ,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
            opacity: 0.4
          )
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            isMobile = constraints.maxWidth < 600;
            return Directionality(
              textDirection: TextDirection.rtl,
              child:
              BlocBuilder<UpdateSessionCubit, UpdateSessionStates>(
                  bloc: updateSessionCubit,
                  builder: (context, state) {
                    return widget.isFinished == 0 ?
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 300),
                            child: Text(
                              "ملاحظات الاستشاري",
                              style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.titleLarge
                                  ?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          FadeInRight(
                            duration: Duration(milliseconds: 500),
                            child: CustomTextField(
                              maxLines: 4,
                              hint: "ملاحظات الاستشاري",
                              controller: advisorComment,
                            ),
                          ),
                          SizedBox(height: 10),
                          FadeInRight(
                            duration: Duration(milliseconds: 700),
                            child: isMobile?Column(
                              children: [
                                Text(
                                  "الخدمة الاستشارية",
                                  style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.titleLarge
                                      ?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DropDown(
                                  onChange: (value) {
                                    setState(() {
                                      selected_consultation_service = value;
                                    });
                                  },
                                ),
                              ],
                            ):
                            Row(
                              children: [
                                Text(
                                  "الخدمة الاستشارية",
                                  style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.titleLarge
                                      ?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                DropDown(
                                  onChange: (value) {
                                    setState(() {
                                      selected_consultation_service = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          FadeInRight(
                            duration: Duration(milliseconds: 900),
                            child: Row(
                              children: [
                                Text(
                                  " هل يحتاج الي جلسة اخري",
                                  style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.titleLarge
                                      ?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Checkbox(
                                  value: (needOtherSession == 1),
                                  onChanged: (value) {
                                    setState(() {
                                      needOtherSession = (value!) ? 1 : 0;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          FadeInRight(
                            duration: Duration(milliseconds: 1100),
                            child: Row(
                              children: [
                                Text(
                                  "الحالة حضرت الجلسة",
                                  style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.titleLarge
                                      ?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Checkbox(
                                  value: (isAttendSelected == 1),
                                  onChanged: (value) {
                                    setState(() {
                                      isAttendSelected = (value!) ? 1 : 0;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          FadeInRight(
                            duration: Duration(milliseconds: 1300),
                            child: Row(
                              children: [
                                Text(
                                  " هل الحالة قصة نجاح",
                                  style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.titleLarge
                                      ?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                Checkbox(
                                  value: (isSuccessStorySelected == 1),
                                  onChanged: (value) {
                                    setState(() {
                                      isSuccessStorySelected = (value!) ? 1 : 0;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          FadeInRight(
                            duration: Duration(milliseconds: 1500),
                            child: BorderRoundedButton(
                                title: "انهاء",
                                onPressed: () {
                                  // for (var session in sessions) {
                                  var data = SessionsUpdateModel(
                                    sessionId: widget.sessionId,
                                    comments: advisorComment.text,
                                    consultationId: selected_consultation_service,
                                    needOtherSession: needOtherSession,
                                    isAttend: isAttendSelected,
                                    isSuccessStory: isSuccessStorySelected,
                                    isFinished: 1,
                                  );
                                  // print("---------->" + data.toString());
                                  updateSessionCubit.updateSession(data).then((
                                      response) {
                                    if (response.data["status"] == true) {

                                      setState(() {
                                        advisorComment.clear();
                                        needOtherSession = 0;
                                        isAttendSelected = 0;
                                        isSuccessStorySelected = 0;
                                        selected_consultation_service = 0;
                                      });
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: AlertDialog(
                                              title: Text(
                                                "تم إنهاء الجلسة",
                                                style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme
                                                    .bodyMedium?.copyWith(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    _patientSessionCubit
                                                        .setRefreshSession(
                                                        widget.sessionId);
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(10),
                                                      border: Border.all(
                                                        color: Constants.theme
                                                            .primaryColor,
                                                        width: 2.5,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "اغلاق",
                                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                        color: Colors.black,
                                                      ),
                                                    ).setHorizontalPadding(
                                                        context,
                                                        enableMediaQuery: false,
                                                        20),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                  });
                                }
                              // },
                            ).setHorizontalPadding(
                                context, enableMediaQuery: false, 10),
                          ),
                        ],
                      ).setHorizontalPadding(context,enableMediaQuery: false, 20),
                    )
                        :
                    BlocBuilder<AddSessionCubit, AddSessionStates>(
                      bloc: _patientSessionCubit,
                      builder: (context, state) {
                        if (state is LoadingAddSessionState) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is ErrorAddSessionState) {
                          return Center(child: Text(state.errorMessage));
                        } else if (state is SuccessShowSession) {
                          var session = state.result.data["session"];
                          if (session == null) {
                            return Center(
                                child: Text("No session data available."));
                          }
                          var patientName = session["pationt"]["name"] ?? "";
                          var advisorName = session["advicor"]["name"] ?? "";
                          var nationalId = session["pationt"]["national_id"] ?? "";
                          var phoneNumber = session["phone_number"] ??"" ?? "";
                          var otherPhoneNumber = session["other_phone_number"] ?? "";

                          if(phoneNumber.toString().contains('+')){
                            phoneNumber = phoneNumber.toString().replaceAll('+', '');
                            phoneNumber = '$phoneNumber+';
                          }
                          if(otherPhoneNumber.toString().contains('+')){
                            otherPhoneNumber = otherPhoneNumber.toString().replaceAll('+', '');
                            otherPhoneNumber = '$otherPhoneNumber+';
                          }


                          var caseManager = session["case_manager"] ?? "";
                          var isAttended = session["is_attended"] == 1;
                          var needOtherSession = session["need_other_session"] ==
                              1;
                          var isSuccessStory = session["is_success_story"] == 1;
                          var serviceName = session["consultation_service"] !=
                              null
                              ? session["consultation_service"]["name"]
                              : "";
                          var serviceDescription = session["consultation_service"] !=
                              null
                              ? session["consultation_service"]["description"]
                              : "";
                          var advisorComments = session["advicor_comments"] ??
                              "";
                          var sessionDate = session["date"] ?? "";
                          TextEditingController commentController = TextEditingController(
                              text: advisorComments);
                          return ListView(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: IconButton(
                                          icon: Icon(Icons.print, color: Colors.black,size: 40,),
                                          onPressed: () async {
                                            print('sssssssssssssssssssssssss');
                                            final pdf = pw.Document();
                                            // final notoSans = await rootBundle.load("assets/fonts/Cairo-Bold.ttf");
                                            // final ttf = pw.Font.ttf(notoSans);
                                            final fontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
                                            final ttf = pw.Font.ttf(fontData);

                                            // final image = pw.MemoryImage(
                                            //   (await rootBundle.load('assets/images/back.jpg')).buffer.asUint8List(),
                                            // );
                                            await Future.delayed(Duration(seconds: 1));
                                            pdf.addPage(
                                              pw.Page(
                                                build: (pw.Context context) {
                                                  return
                                                    pw.Column(
                                                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                                                        children: [
                                                          pw.Text(
                                                            "اسم الحالة :${patientName}" ,
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text(
                                                            "اسم الاستشارى :${advisorName}",
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text(
                                                            "رقم الهوية :${nationalId}",
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text(
                                                            "رقم الهاتف :${phoneNumber}",
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text(
                                                            "رقم بديل للهاتف :${otherPhoneNumber}",
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text(
                                                            "مدير الحالة : ${caseManager}",
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text(
                                                            isAttended
                                                                ? "الحالة حضرت الجلسة"
                                                                : "الحالة لم تحضر الجلسة",
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text(
                                                            needOtherSession
                                                                ? "الحالة بحاجه الي جلسة اخرى"
                                                                : "الحالة غير بحاجه الي جلسة اخرى",
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text(
                                                            isSuccessStory
                                                                ? "الحالة قصة نجاح"
                                                                : "الحالة ليست قصة نجاح",
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text("الخدمة الاستشارية : ${serviceName}",

                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Text(
                                                            "وصف الخدمة الاستشارية : ${serviceDescription}",
                                                            style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                            textDirection: pw.TextDirection.rtl,
                                                          ),
                                                          pw.Directionality(
                                                              textDirection: pw.TextDirection.rtl,
                                                              child:pw.Table(
                                                                border: pw.TableBorder.all(
                                                                  color: PdfColors.black,
                                                                  width: 1,
                                                                ),
                                                                children: [
                                                                  pw.TableRow(
                                                                    children: [
                                                                      pw.Padding(
                                                                        padding: const pw.EdgeInsets.all(8.0),
                                                                        child: pw.Center(child:pw.Text(
                                                                          "الملاحظة",
                                                                          style: pw.TextStyle(font: ttf, fontSize: 14),
                                                                          textDirection: pw.TextDirection.rtl,
                                                                        ),
                                                                        ),
                                                                      ),
                                                                      pw.Padding(
                                                                          padding: const pw.EdgeInsets.all(8.0),
                                                                          child: pw.Container(
                                                                            width:400,
                                                                            child:pw.Center(child:pw.Text(
                                                                              "تاريخ الجلسة",
                                                                              style: pw.TextStyle(font: ttf, fontSize: 14),
                                                                              textDirection: pw.TextDirection.rtl,
                                                                            ),
                                                                            ),
                                                                          )
                                                                      )
                                                                    ],
                                                                  ),
                                                                  // Add more rows as needed
                                                                  pw.TableRow(
                                                                    children: [
                                                                      pw.Padding(
                                                                        padding: const pw.EdgeInsets.all(8.0),
                                                                        child:pw.Text(
                                                                          advisorComments,
                                                                          style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                                                          textDirection: pw.TextDirection.rtl,
                                                                        ),
                                                                      ),
                                                                      pw.Expanded( // Expands this column to take up more space
                                                                        child: pw.Center(child:pw.Text(
                                                                          sessionDate,
                                                                          style: pw.TextStyle(font: ttf, fontSize: 12, color: PdfColors.black),
                                                                          textDirection: pw.TextDirection.rtl,
                                                                        ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ],
                                                              )

                                                          )
                                                        ]
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
                                      ),
                                    ),

                                    Text(
                                      "اسم الحالة : $patientName",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      "اسم الاستشاري : $advisorName",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      "رقم الهوية : $nationalId",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      "رقم الهاتف : $phoneNumber",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      "رقم بديل للهاتف : $otherPhoneNumber",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      "مدير الحالة : $caseManager",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      isAttended
                                          ? "الحالة حضرت الجلسة"
                                          : "الحالة لم تحضر الجلسة",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      needOtherSession
                                          ? "الحالة بحاجه الي جلسة اخرى"
                                          : "الحالة غير بحاجه الي جلسة اخرى",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      isSuccessStory
                                          ? "الحالة قصة نجاح"
                                          : "الحالة ليست قصة نجاح",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      "الخدمة الاستشارية : $serviceName",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    Text(
                                      "وصف الخدمة الاستشارية : $serviceDescription",
                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme.textTheme.bodyLarge
                                          ?.copyWith(color: Colors.black),
                                    ),
                                    const SizedBox(height: 20),
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(4),
                                        1: isMobile?FlexColumnWidth(2):FlexColumnWidth(1),
                                      },
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                              color: Colors.black),
                                          children: [
                                            TableCell(
                                              child: SizedBox(
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "الملاحظة",
                                                    textAlign: TextAlign.center,
                                                    style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Theme
                                                        .of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: SizedBox(
                                                height: 50,
                                                child: Center(
                                                  child: Text(
                                                    "تاريخ الجلسة",
                                                    textAlign: TextAlign.center,
                                                    style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.white,) : Theme
                                                        .of(context)
                                                        .textTheme
                                                        .titleLarge
                                                        ?.copyWith(fontSize: 20,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          decoration: BoxDecoration(
                                              color: Colors.black54),
                                          children: [
                                            TableCell(
                                              child: Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: 10.0),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      children: [
                                                        Text(
                                                          advisorComments,
                                                          style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.white,) : Theme
                                                              .of(context)
                                                              .textTheme
                                                              .bodyLarge
                                                              ?.copyWith(
                                                              color: Colors
                                                                  .white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  sessionDate,
                                                  style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.white,) : Theme
                                                      .of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    BorderRoundedButton(
                                      title: "تعديل",
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Constants.theme
                                                  .primaryColor,
                                              content: Form(
                                                key: formKey,
                                                child: SizedBox(
                                                  height: Constants.mediaQuery
                                                      .height * 0.6,
                                                  width: Constants.mediaQuery
                                                      .width * 0.45,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize
                                                        .min,
                                                    children: [
                                                      CustomTextField(
                                                        maxLines: 8,
                                                        minLines: 1,
                                                        fillColor: Colors
                                                            .white70,
                                                        controller: commentController,
                                                        onValidate: (value) {
                                                          if (value == null ||
                                                              value
                                                                  .trim()
                                                                  .isEmpty) {
                                                            return "من فضلك ادخل الملاحظة";
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      var data = SessionsUpdateModel(
                                                        sessionId: widget
                                                            .sessionId,
                                                        comments: commentController
                                                            .text,
                                                      );
                                                      updateSessionCubit
                                                          .updateSession(data)
                                                          .then((_) {
                                                        // _patientSessionCubit.showSession(widget.sessionId);
                                                        Navigator.of(context)
                                                            .pop();
                                                        _patientSessionCubit
                                                            .setRefreshSession(
                                                            widget.sessionId);
                                                      });
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(10),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2.5,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "موافق",
                                                      style:isMobile?Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black,) : Constants.theme
                                                          .textTheme.bodyMedium
                                                          ?.copyWith(
                                                          color: Colors.white),
                                                    ).setHorizontalPadding(
                                                        context,
                                                        enableMediaQuery: false,
                                                        20),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ).setVerticalPadding(context,enableMediaQuery: false, 20),
                                  ],
                                ).setHorizontalPadding(context,enableMediaQuery: false, 20).setHorizontalPadding(context,enableMediaQuery: false, 10),
                              ),
                            ],
                          );
                        }

                        return Container();
                      },
                    );
                  }
              ),
            );
          }),
      ),
    );
  }
}
