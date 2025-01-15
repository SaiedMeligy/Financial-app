import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/core/widget/custom_text_field.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/SessionDestailViewAdmin/widget/drop_down_with_admin.dart';
import 'package:experts_app/features/homeAdvisor/sessions/manager/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf/pdf.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../core/Services/snack_bar_service.dart';
import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/widget/border_rounded_button.dart';
import '../../../../../core/widget/check_box_question.dart';
import '../../../../../core/widget/drop_down_button.dart';
import '../../../../../core/widget/tab_item_widget.dart';
import '../../../../../domain/entities/AdviceMode.dart';
import '../../../../../domain/entities/QuestionModel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'dart:html' as html;

import '../../../homeAdvisor/sessions/manager/states.dart';


class SessionDetailsViewAbuzabi extends StatefulWidget {
  final dynamic pationt_data;
  final int sessionId;
  int? patientId;
  String? patientNationalId;
  final int isFinished;
  final int? isAttend;
  final String? sessionCaseManager;
  final String? sessionComment;
  final String? sessionDate;
  final ConsultationService? consultationService;


  SessionDetailsViewAbuzabi({
    super.key,
    required this.pationt_data,
    required this.sessionId,
    this.patientId,
    this.patientNationalId,
    required this.isAttend,
    required this.isFinished,
    this.sessionCaseManager,
    this.sessionComment,
    this.sessionDate,
    this.consultationService,
  });

  @override
  State<SessionDetailsViewAbuzabi> createState() => _SessionDetailsViewState();
}

class _SessionDetailsViewState extends State<SessionDetailsViewAbuzabi> {
  int needOtherSession = 0;
  int isAttendSelected = 0;
  int isSuccessStorySelected = 0;
  int selected_consultation_service = 0;
  TextEditingController advisorComment = TextEditingController();
  late AddSessionCubit _patientSessionCubit;
  late UpdateSessionCubit updateSessionCubit;
  var formKey = GlobalKey<FormState>();
  late var caseManager;
  List<dynamic> sessionList = [];
  bool isMobile = false;
  RefreshController controller = RefreshController();
  List<Pointers> pointers1 = [];
  List<Pointers> pointers2 = [];
  List<Pointers> pointers3 = [];
  List<Advices> advicesList = [];
  List<Advices> addAdvicesList = [];
  List<List<int>> selectedPointers1 = [];
  List<List<int>> selectedPointers2 = [];
  List<List<int>> selectedPointers3 = [];
  List<List<int>> selectedAdvices = [];
  List<List<int>> selectedQuestions = [];
  List<TextEditingController> LengthControllers = [];

  // late var session;
  var addSessionCubit = AddSessionCubit();
  bool finished=false;


  @override
  void initState() {
    super.initState();
    _patientSessionCubit = AddSessionCubit();
    _patientSessionCubit.showSessionWithAdmin(widget.sessionId);//todo
    addSessionCubit.getPatientDetails(widget.pationt_data.nationalId,0);
    fetchPointers();
    fetchAdvices();


    updateSessionCubit = UpdateSessionCubit();
    print("patientData--->"+widget.patientId.toString());


  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          isMobile = constraints.maxWidth < 600;
          return BlocBuilder<AddSessionCubit, AddSessionStates>(
            bloc: addSessionCubit,
            builder: (context, state) {
              if (state is LoadingAddSessionState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ErrorAddSessionState) {
                return Center(
                  child: Text(state.errorMessage),
                );
              }
              if (state is SuccessPatientNationalIdState) {


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
                  body: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/back.jpg"),
                          fit: BoxFit.cover,
                          opacity: 0.1  ,
                        ),
                      ),
                      child: ListView(
                        children: [
                          Container(
                            child: BlocBuilder<UpdateSessionCubit, UpdateSessionStates>(
                                bloc: updateSessionCubit,
                                builder: (context, state) {
                                  return
                                  BlocBuilder<AddSessionCubit, AddSessionStates>(
                                    bloc: _patientSessionCubit,
                                    builder: (context, state) {
                                      if (state is LoadingAddSessionState) {
                                        return Center(child: CircularProgressIndicator());
                                      } else if (state is ErrorAddSessionState) {
                                        return Center(child: Text(state.errorMessage));
                                      } else if (state is SuccessShowSessionWithAdmin) {
                                        var session = state.result.data["session"];
                                        if (session == null) {
                                          return Center(
                                              child: Text("No session data available."));
                                        }
                                        print("sesssion Id"+session['id'].toString());
                                        var sessionId = session['id'];
                                        var patientName = session["pationt"]["name"] ?? "";
                                        // var advisorName = session["advicor"]["name"] ?? "";
                                        var nationalId = session["pationt"]["national_id"] ?? "";
                                        var caseManager = session["case_manager"] ?? "";
                                        var phoneNumber = session["phone_number"] ?? "";
                                        var otherPhoneNumber = session["other_phone_number"] ?? "";
                                        var pointers = session["Pointers"] ?? [];
                                        var advices = session["Advices"] ?? [];

                                        List<dynamic> pointers1Temp = [];
                                        List<dynamic> pointers2Temp = [];
                                        List<dynamic> pointers3Temp = [];

                                        for (var pointer in pointers) {
                                          if (pointer["senario_id"] == 1) {
                                            pointers1Temp.add(pointer);
                                          } else if (pointer["senario_id"] == 2) {
                                            pointers2Temp.add(pointer);
                                          } else if (pointer["senario_id"] == 3) {
                                            pointers3Temp.add(pointer);
                                          }
                                        }
                                        List<int> selectedAdviceIds = [];
                                        List<int> selectedPointersIds = [];



                                        // if (pointers.isEmpty && advices.isEmpty) {
                                        //   return Center(
                                        //     child: Text("No data available"),
                                        //   );
                                        // }

                                        if(phoneNumber.toString().contains('+')){
                                          phoneNumber = phoneNumber.toString().replaceAll('+', '');
                                          phoneNumber = '$phoneNumber+';
                                        }
                                        if(otherPhoneNumber.toString().contains('+')){
                                          otherPhoneNumber = otherPhoneNumber.toString().replaceAll('+', '');
                                          otherPhoneNumber = '$otherPhoneNumber+';
                                        }

                                        var isAttended = session["is_attended"] == 1;
                                        var needOtherSession = session["need_other_session"] == 1;
                                        var isSuccessStory = session["is_success_story"] == 1;
                                        var serviceName = session["consultation_service"] !=
                                            null
                                            ? session["consultation_service"]["name"]
                                            : "";
                                        var serviceDescription = session["consultation_service"] !=
                                            null
                                            ? session["consultation_service"]["description"]
                                            : "";
                                        var advisorComments = session["advicor_comments"] ?? "";
                                        // bool needSession = needOtherSession ? true : false;


                                        var sessionDate = session["date"] ?? "";
 
                                        return Directionality(
                                            textDirection: TextDirection.rtl,
                                            child:
                                            Container(
                                              decoration: const BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage("assets/images/back.jpg"),
                                                    fit: BoxFit.cover,
                                                    opacity: 0.2,
                                                  )
                                              ),
                                              // todo change
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                                                        // pw.Text(
                                                                        //   "اسم الاستشارى :${advisorName}",
                                                                        //   style: pw.TextStyle(font: ttf, fontSize: 16, color: PdfColors.black),
                                                                        //   textDirection: pw.TextDirection.rtl,
                                                                        // ),
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
                                                                              ? "الحالة بحاجه الى جلسة اخرى"
                                                                              : "الحالة ليست بحاجه الى جلسة اخرى",
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
                                                    style: isMobile ? Constants.theme
                                                        .textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,) : Constants.theme
                                                        .textTheme.bodyLarge?.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  // Text(
                                                  //   "اسم الاستشاري : $advisorName",
                                                  //   style: isMobile ? Constants.theme
                                                  //       .textTheme.bodyMedium?.copyWith(
                                                  //     color: Colors.black,) : Constants.theme
                                                  //       .textTheme.bodyLarge?.copyWith(
                                                  //       color: Colors.black),
                                                  // ),
                                                  Text(
                                                    "رقم الهوية : $nationalId",
                                                    style: isMobile ? Constants.theme
                                                        .textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,) : Constants.theme
                                                        .textTheme.bodyLarge?.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  Directionality(
                                                    textDirection: TextDirection.rtl,
                                                     child: Text(
                                                      "رقم الهاتف : $phoneNumber",
                                                      style: isMobile ? Constants.theme
                                                          .textTheme.bodyMedium?.copyWith(
                                                        color: Colors.black,) : Constants.theme
                                                          .textTheme.bodyLarge?.copyWith(
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  Text(
                                                    "رقم بديل للهاتف : $otherPhoneNumber",
                                                    style: isMobile ? Constants.theme
                                                        .textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,) : Constants.theme
                                                        .textTheme.bodyLarge?.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    "مدير الحالة : $caseManager",
                                                    style: isMobile ? Constants.theme
                                                        .textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,) : Constants.theme
                                                        .textTheme.bodyLarge?.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    isAttended
                                                        ? "الحالة حضرت الجلسة"
                                                        : "الحالة لم تحضر الجلسة",
                                                    style: isMobile ? Constants.theme
                                                        .textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,) : Constants.theme
                                                        .textTheme.bodyLarge?.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    needOtherSession
                                                        ? "الحالة بحاجه الى جلسة اخرى"
                                                        : "الحالة ليست بحاجه الى جلسة اخرى",
                                                    style: isMobile ? Constants.theme
                                                        .textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,) : Constants.theme
                                                        .textTheme.bodyLarge?.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    isSuccessStory
                                                        ? "الحالة قصة نجاح"
                                                        : "الحالة ليست قصة نجاح",
                                                    style: isMobile ? Constants.theme
                                                        .textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,) : Constants.theme
                                                        .textTheme.bodyLarge?.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    "الخدمة الاستشارية : $serviceName",
                                                    style: isMobile ? Constants.theme
                                                        .textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,) : Constants.theme
                                                        .textTheme.bodyLarge?.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  Text(
                                                    "وصف الخدمة الاستشارية : $serviceDescription",
                                                    style: isMobile ? Constants.theme
                                                        .textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,) : Constants.theme
                                                        .textTheme.bodyLarge?.copyWith(
                                                        color: Colors.black),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Container(
                                                    height: Constants.mediaQuery.height*0.4,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 2,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text(
                                                              "المؤشرات",
                                                              textAlign: TextAlign.center,
                                                              style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ],
                                                        ).setVerticalPadding(context,enableMediaQuery: false, 3),
                                                        Expanded(
                                                          child: TabItemWidget(
                                                            item1: "السيناريوالأول(الحالات المتوازنة نسبيا)",
                                                            item2: "السيناريوالثاني(للحالات الغير متوازنة في الصرف)",
                                                            item3: "السيناريوالثالث(للحالات المتعثرة ماليا)",
                                                            firstWidget: Container(
                                                              color: Constants.theme.primaryColor.withOpacity(0.4),
                                                              child: pointers1Temp.isEmpty
                                                                  ? Center(child: Text('No pointers available for scenario 1.'))
                                                                  : ListView.builder(
                                                                itemCount: pointers1Temp.length,
                                                                itemBuilder: (context, index) {
                                                                  final pointer = pointers1Temp[index];
                                                                  return Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text(
                                                                              pointer["text"] ?? '',
                                                                              style: TextStyle(
                                                                                fontSize: isMobile ? 14 : 20,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ).setHorizontalPadding(context, enableMediaQuery: false, 10);
                                                                },
                                                              ),
                                                            ),
                                                            secondWidget: Container(
                                                              color: Constants.theme.primaryColor.withOpacity(0.4),
                                                              child: pointers2Temp.isEmpty
                                                                  ? Center(child: Text('No pointers available for scenario 2.'))
                                                                  : ListView.builder(
                                                                itemCount: pointers2Temp.length,
                                                                itemBuilder: (context, index) {
                                                                  final pointer2 = pointers2Temp[index];
                                                                  return Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text(
                                                                              pointer2["text"] ?? '',
                                                                              style: TextStyle(
                                                                                fontSize: isMobile ? 14 : 20,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ).setHorizontalPadding(context, enableMediaQuery: false, 10);
                                                                },
                                                              ),
                                                            ),
                                                            thirdWidget: Container(
                                                              color: Constants.theme.primaryColor.withOpacity(0.4),
                                                              child: pointers3Temp.isEmpty
                                                                  ? Center(child: Text('No pointers available for scenario 3.'))
                                                                  : ListView.builder(
                                                                itemCount: pointers3Temp.length,
                                                                itemBuilder: (context, index) {
                                                                  final pointer3 = pointers3Temp[index];
                                                                  return Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Text(
                                                                              pointer3["text"] ?? '',
                                                                              style: TextStyle(
                                                                                fontSize: isMobile ? 14 : 20,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: Colors.black,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ).setHorizontalPadding(context, enableMediaQuery: false, 10);
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  Container(
                                                    height: Constants.mediaQuery.height*0.4,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 2,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      children: [

                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                "التوصيات",
                                                                textAlign: TextAlign.center,
                                                                style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                                  color: Colors.black,
                                                                ),
                                                              ),
                                                            ),

                                                          ],
                                                        ).setVerticalPadding(context,enableMediaQuery: false, 3),

                                                        Divider(
                                                          thickness: 2,
                                                          color: Colors.black,

                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            color: Constants.theme.primaryColor.withOpacity(0.4),
                                                            child: ListView.builder(
                                                              itemCount: advices.length,
                                                              itemBuilder: (context, index) {
                                                                return Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text(
                                                                            advices[index]["text"]??'لا يوجد',
                                                                            style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                                                                color: Colors.black,
                                                                                fontSize: isMobile?14:20
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ).setHorizontalPadding(context,enableMediaQuery: false,10 ),
                                                                  ],
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ).setVerticalPadding(context,enableMediaQuery: false, 5),
                                                  SizedBox(height: 20),

                                                  Table(
                                                    columnWidths: {
                                                      0: FlexColumnWidth(4),
                                                      1: isMobile ? FlexColumnWidth(2) : FlexColumnWidth(1),
                                                    },
                                                    children: [
                                                      TableRow(
                                                        decoration: BoxDecoration(color: Colors.black),
                                                        children: [
                                                          TableCell(
                                                            child: SizedBox(
                                                              height: 50,
                                                              child: Center(
                                                                child: Text(
                                                                  "الملاحظة",
                                                                  textAlign: TextAlign.center,
                                                                  style: isMobile
                                                                      ? Constants.theme.textTheme.bodyMedium?.copyWith(
                                                                    color: Colors.white,
                                                                  )
                                                                      : Theme.of(context).textTheme.titleLarge?.copyWith(
                                                                    fontSize: 20,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          TableCell(
                                                            child: SizedBox(
                                                              height: 50,
                                                              width: 100,
                                                              child: Center(
                                                                child: Text(
                                                                  "تاريخ الجلسة",
                                                                  textAlign: TextAlign.center,
                                                                  style: isMobile
                                                                      ? Constants.theme.textTheme.bodyMedium?.copyWith(
                                                                    color: Colors.white,
                                                                  )
                                                                      : Theme.of(context).textTheme.titleLarge?.copyWith(
                                                                    fontSize: 20,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      TableRow(
                                                        decoration: BoxDecoration(color: Colors.black54),
                                                        children: [
                                                          TableCell(
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                                              child: Container(
                                                                alignment: Alignment.center,
                                                                child: SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        advisorComments,
                                                                        style: isMobile
                                                                            ? Constants.theme.textTheme.bodyMedium?.copyWith(
                                                                          color: Colors.white,
                                                                        )
                                                                            : Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                          color: Colors.white,
                                                                        ),
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
                                                                style: isMobile
                                                                    ? Constants.theme.textTheme.bodyMedium?.copyWith(
                                                                  color: Colors.white,
                                                                )
                                                                    : Theme.of(context).textTheme.bodyLarge?.copyWith(
                                                                  color: Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 20),


                                                ],
                                              ).setHorizontalPadding(context,enableMediaQuery: false, 20).setHorizontalPadding(context,enableMediaQuery: false, 10),
                                            )
                                        );
                                      }

                                      return Container();
                                    },
                                  );

                                }
                            ),
                          ),
                          //   ),
                          // ),
                          // bottomSheet: showBottomSheet?


                        ],
                      ),
                    ),
                  ),
                );
              }
              return Text("Something went wrong");
            },
          );}
    );
  }
  Future<void> fetchPointers() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/api/pointer',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["pointers"];
        List<Pointers> pointers = [];
        List<Pointers> pointers1Temp = [];
        List<Pointers> pointers2Temp = [];
        List<Pointers> pointers3Temp = [];

        pointers = data.map((json) => Pointers.fromJson(json)).toList();
        pointers.forEach(
              (pointer) {
            if (pointer.senarioId == 1) {
              pointers1Temp.add(pointer);
            } else if (pointer.senarioId == 2) {
              pointers2Temp.add(pointer);
            } else if (pointer.senarioId == 3) {
              pointers3Temp.add(pointer);
            }
          },
        );
        setState(() {
          pointers1 = pointers1Temp;
          pointers2 = pointers2Temp;
          pointers3 = pointers3Temp;
        });
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }

  Future<void> fetchAdvices() async {
    final dio = Dio();
    try {
      final response = await dio.get(
        '${Constants.baseUrl}/api/advice',
        options: Options(headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["advices"];
        print(data);
        List<Advices> advicesdata = [];
        advicesdata = data.map((json) => Advices.fromJson(json)).toList();
        setState(() {
          advicesList = advicesdata;
        });
      } else {
        print('Failed to load users. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
  }



}
