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
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/border_rounded_button.dart';
import '../../sessions/manager/states.dart';
import '../../viewQuestion/widget/drop_down.dart';

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

  @override
  void initState() {
    super.initState();
    _patientSessionCubit = AddSessionCubit();
    _patientSessionCubit.getSessionDetails(widget.pationt_data.nationalId);
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
        backgroundColor: Color(0xff000000),
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
        child: Directionality(
          textDirection: TextDirection.rtl,
          child:
          BlocBuilder<UpdateSessionCubit, UpdateSessionStates>(
              bloc: updateSessionCubit,
              builder: (context, state) {
                return widget.isFinished==0?
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
                          style: Constants.theme.textTheme.titleLarge?.copyWith(
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
                        child: Row(
                          children: [
                            Text(
                              "الخدمة الاستشارية",
                              style: Constants.theme.textTheme.titleLarge?.copyWith(
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
                              style: Constants.theme.textTheme.titleLarge?.copyWith(
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
                              style: Constants.theme.textTheme.titleLarge?.copyWith(
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
                              style: Constants.theme.textTheme.titleLarge?.copyWith(
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
                              updateSessionCubit.updateSession(data).then((response) {
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
                                            style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Constants.theme.primaryColor,
                                                    width: 2.5,
                                                  ),
                                                ),
                                                child: Text(
                                                  "اغلاق",
                                                  style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                    color: Colors.black,
                                                  ),
                                                ).setHorizontalPadding(context, enableMediaQuery: false, 20),
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
                        ).setHorizontalPadding(context, enableMediaQuery: false, 10),
                      ),
                    ],
                  ),
                )
                    :
                 BlocBuilder<AddSessionCubit, AddSessionStates>(
                  bloc: _patientSessionCubit,
                  builder: (context, state) {
                    if (state is LoadingAddSessionState) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ErrorAddSessionState) {
                      return Center(child: Text(state.errorMessage));
                    } else if (state is SuccessAddSessionState) {
                      // print("ssssssssssssssssssss->"+state.result.data.toString());
                      var sessions = state.result.data["pationt"]["sessions"];
                      var patient = state.result.data["pationt"];
                      for(int i = 0; i < sessions.length; i++) {
                        session = sessions[i];
                      }
                      print("mmmmmmmmmmmmmmm->"+session.toString());

                      // print("dddddddddddddddd->"+sessions.toString());
                      TextEditingController commentController =TextEditingController(text: session["advicor_comments"]) ;//TextEditingController(text: widget.sessionComment);
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            Text(
                              "اسم الحالة : " + (session["pationt"]["name"] ?? ""),
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "اسم الاستشاري : " + (session["advicor"]["name"] ?? ""),
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "رقم الهوية : " + (session["pationt"]["national_id"] ?? ""),
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "مدير الحالة : " + (session["case_manager"] ?? ""),
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            session["is_attended."]==1?
                            Text(
                              "الحالة حضرت الجلسة",
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ):
                            Text(
                              "الحالة لم تحضر الجلسة",
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            session["need_other_session"]==1?
                            Text(
                              "الحالة بحاجه الي جلسة اخرى",
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ):
                            Text(
                              "الحالة غير بحاجه الي جلسة اخرى",
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            session["is_success_story"]==1?
                            Text(
                              "الحالة قصة نجاح",
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ):
                            Text(
                              "الحالة ليست قصة نجاح",
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "الخدمة الاستشارية : ${patient["form"]["consultation_service"]["name"]??""}",
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "وصف الخدمة الاستشارية : ${patient["form"]["consultation_service"]["description"]??""}",
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
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
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TableCell(
                                      child: SizedBox(
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "الملاحظة",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                                        child: Center(
                                          child: Text(
                                            "تاريخ الجلسة",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                  ),
                                  children: [
                                    TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Container(
                                          height: Constants.mediaQuery.height * 0.3,
                                          alignment: Alignment.center,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  session["advicor_comments"] ?? "",
                                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                                          session["date"] ?? "",
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                            BorderRoundedButton(
                              title: "تعديل",
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Constants.theme.primaryColor,
                                      content: Form(
                                        key: formKey,
                                        child: SizedBox(
                                          height: Constants.mediaQuery.height * 0.6,
                                          width: Constants.mediaQuery.width * 0.45,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CustomTextField(
                                                maxLines: 8,
                                                minLines: 1,
                                                fillColor: Colors.white70,
                                                controller: commentController,
                                                onValidate: (value) {
                                                  if (value == null || value.trim().isEmpty) {
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
                                            if (formKey.currentState!.validate()) {
                                              var data = SessionsUpdateModel(
                                                sessionId: widget.sessionId,
                                                comments: commentController.text,
                                              );
                                              updateSessionCubit.updateSession(data).then((_) {
                                                _patientSessionCubit.getSessionDetails(widget.pationt_data.nationalId);
                                                Navigator.of(context).pop();
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
                                              style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
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
                      );
                    }
                    return Container();
                  },
                );

              }
          ),
        ),
      ),
    );
  }
}
