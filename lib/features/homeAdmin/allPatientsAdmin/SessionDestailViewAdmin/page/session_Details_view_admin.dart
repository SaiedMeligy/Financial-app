import 'package:animate_do/animate_do.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widget/border_rounded_button.dart';
import '../../../../homeAdvisor/sessions/manager/states.dart';

class SessionDetailsViewAdmin extends StatefulWidget {
  final dynamic pationt_data;
  final int sessionId;
  final int isFinished;
  final int? isAttend;
  final String? sessionCaseManager;
  final String? sessionComment;
  final String? sessionDate;
  final ConsultationService? consultationService;

  SessionDetailsViewAdmin({
    super.key,
    required this.pationt_data,
    required this.sessionId,
    required this.isAttend,
    required this.isFinished,
    this.sessionCaseManager,
    this.sessionComment,
    this.sessionDate,
    this.consultationService,
  });

  @override
  State<SessionDetailsViewAdmin> createState() => _SessionDetailsViewState();
}

class _SessionDetailsViewState extends State<SessionDetailsViewAdmin> {
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

  // late var session;


  @override
  void initState() {
    super.initState();
    _patientSessionCubit = AddSessionCubit();
      // _patientSessionCubit.getPatientDetails(widget.pationt_data.nationalId);
     _patientSessionCubit.showSessionWithAdmin(widget.sessionId);
    updateSessionCubit = UpdateSessionCubit();
    // print("ssssssssssssssssss>>"+widget.sessionComment.toString());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("استمارة برنامج الارشاد المالي"),
        centerTitle: true,
        titleTextStyle: Constants.theme.textTheme.titleLarge,
        backgroundColor: Color(0xff000000),
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.jpg"),
            fit: BoxFit.cover,
            opacity: 0.4,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            isMobile = constraints.maxWidth < 600;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: BlocBuilder<UpdateSessionCubit, UpdateSessionStates>(
                bloc: updateSessionCubit,
                builder: (context, state) {
                  if (widget.isFinished == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 300),
                            child: Text(
                              "ملاحظات الاستشاري",
                              style: isMobile
                                  ? Constants.theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black,)
                                  : Constants.theme.textTheme.titleLarge
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
                          widget.sessionComment != null ?
                          FadeInRight(
                            duration: Duration(milliseconds: 300),
                            child: Text(
                              " ملاحظات اثناء حجز الجلسة :" +
                                  widget.sessionComment.toString(),
                              style: isMobile
                                  ? Constants.theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.black,)
                                  : Constants.theme.textTheme.titleLarge
                                  ?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ) : Container(),
                          SizedBox(height: 10),
                          FadeInRight(
                            duration: Duration(milliseconds: 700),
                            child: isMobile
                            ?Column(
                              children: [
                                Text(
                                  "الخدمة الاستشارية",
                                  style: isMobile ? Constants.theme.textTheme
                                      .bodyMedium?.copyWith(
                                    color: Colors.black,) : Constants.theme
                                      .textTheme.titleLarge?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                DropDownWithAdmin(
                                  onChange: (value) {
                                    setState(() {
                                      selected_consultation_service = value;
                                    });
                                  },
                                ),
                              ],
                            ):Row(
                              children: [
                                Text(
                                  "الخدمة الاستشارية",
                                  style: isMobile ? Constants.theme.textTheme
                                      .bodyMedium?.copyWith(
                                    color: Colors.black,) : Constants.theme
                                      .textTheme.titleLarge?.copyWith(
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                DropDownWithAdmin(
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
                                  style: isMobile ? Constants.theme.textTheme
                                      .bodyMedium?.copyWith(
                                    color: Colors.black,) : Constants.theme
                                      .textTheme.titleLarge?.copyWith(
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
                                  style: isMobile ? Constants.theme.textTheme
                                      .bodyMedium?.copyWith(
                                    color: Colors.black,) : Constants.theme
                                      .textTheme.titleLarge?.copyWith(
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
                                  style: isMobile ? Constants.theme.textTheme
                                      .bodyMedium?.copyWith(
                                    color: Colors.black,) : Constants.theme
                                      .textTheme.titleLarge?.copyWith(
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
                                var data = SessionsUpdateModel(
                                  sessionId: widget.sessionId,
                                  comments: advisorComment.text,
                                  consultationId: selected_consultation_service,
                                  needOtherSession: needOtherSession,
                                  isAttend: isAttendSelected,
                                  isSuccessStory: isSuccessStorySelected,
                                  isFinished: 1,
                                );
                                updateSessionCubit.updateSessionWithAdmin(data)
                                    .then((response) {
                                  if (response.data["status"] == true) {
                                    setState(() {
                                      // advisorComment.clear();
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
                                              "تم انهاء الجلسة",
                                              style: isMobile ? Constants.theme
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(color: Colors
                                                  .black,) : Constants.theme
                                                  .textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: Colors.black,
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
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
                                                    style: isMobile
                                                        ? Constants.theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color: Colors.black,)
                                                        : Constants.theme
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
                              },
                            ).setHorizontalPadding(
                                context, enableMediaQuery: false, 10),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return BlocBuilder<AddSessionCubit, AddSessionStates>(
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
                          var patientName = session["pationt"]["name"] ?? "";
                          var advisorName = session["advicor"]["name"] ?? "";
                          var nationalId = session["pationt"]["national_id"] ??
                              "";
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
                          TextEditingController commentController = TextEditingController(text: advisorComments);

                          return ListView(
                            children: [
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: [
                                    Text(
                                      "اسم الحالة : $patientName",
                                      style: isMobile ? Constants.theme
                                          .textTheme.bodyMedium?.copyWith(
                                        color: Colors.black,) : Constants.theme
                                          .textTheme.bodyLarge?.copyWith(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "اسم الاستشاري : $advisorName",
                                      style: isMobile ? Constants.theme
                                          .textTheme.bodyMedium?.copyWith(
                                        color: Colors.black,) : Constants.theme
                                          .textTheme.bodyLarge?.copyWith(
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "رقم الهوية : $nationalId",
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
                                          ? "الحالة بحاجه الي جلسة اخرى"
                                          : "الحالة غير بحاجه الي جلسة اخرى",
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
                                    Table(
                                      columnWidths: {
                                        0: FlexColumnWidth(4),
                                        1: FlexColumnWidth(1),
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
                                                    style: isMobile
                                                        ? Constants.theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color: Colors.black,)
                                                        : Theme
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
                                                    style: isMobile
                                                        ? Constants.theme
                                                        .textTheme.bodyMedium
                                                        ?.copyWith(
                                                      color: Colors.black,)
                                                        : Theme
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
                                                          style: isMobile
                                                              ? Constants.theme
                                                              .textTheme
                                                              .bodyMedium
                                                              ?.copyWith(
                                                            color: Colors
                                                                .black,)
                                                              : Theme
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
                                                  style: isMobile
                                                      ? Constants.theme
                                                      .textTheme.bodyMedium
                                                      ?.copyWith(
                                                    color: Colors.black,)
                                                      : Theme
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
                                    SizedBox(height: 20),
                                    BorderRoundedButton(
                                      title: "تعديل",
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Constants.theme.primaryColor.withOpacity(0.9),
                                              content: Form(
                                                key: formKey,
                                                child: SizedBox(
                                                  height: Constants.mediaQuery.height * 0.6,
                                                  width: Constants.mediaQuery.width * 0.45,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      CustomTextField(
                                                        controller: commentController ,
                                                        onValidate: (value) {
                                                          if (value == null || value.trim().isEmpty) {
                                                            return "Please enter the service name";
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
                                                    if (formKey.currentState!.validate()) {
                                                      var data = SessionsUpdateModel(
                                                        sessionId: widget.sessionId,
                                                        comments: commentController.text,);
                                                      updateSessionCubit.updateSessionWithAdmin(data).then((_) {
                                                        Navigator.pop(context);
                                                        _patientSessionCubit.setRefreshSessionAdmin(widget.pationt_data.id);

                                                        // _patientSessionCubit.getPatientDetails(widget.pationt_data.nationalId);
                                                      });

                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 2.5,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "موافق",
                                                      style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                    ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),

                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        return Container();
                      },
                    );
                  }
                },
              ),
            );
          }),
      ),
    );
  }
  // Future<void> sessionShow(int id,) async {
  //   final dio = Dio();
  //   try {
  //     final response = await dio.get(
  //         '${Constants.baseUrl}/api/session/show',
  //         options: Options(headers: {
  //           "api-password": Constants.apiPassword,
  //           "token": CacheHelper.getData(key: "token")
  //         }),
  //         queryParameters: {
  //           "id": id,
  //
  //         }
  //     );
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = response.data["session"];
  //       print(data);
  //       List<dynamic> sessiondata = [];
  //       sessiondata = data.map((json) => Sessions.fromJson(json)).toList();
  //       setState(() {
  //         sessionList = sessiondata;
  //       });
  //
  //       print('Success: ${response.data["message"]}');
  //       SnackBarService.showSuccessMessage(response.data["message"]);
  //
  //     } else {
  //       print('Failed to add pointer. Status code: ${response.statusCode}');
  //       SnackBarService.showErrorMessage(response.data["message"]);
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //     SnackBarService.showErrorMessage(e.toString());
  //   }
  // }


}
