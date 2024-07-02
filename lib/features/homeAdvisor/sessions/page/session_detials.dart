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
import '../../viewQuestion/widget/drop_down.dart';
import '../manager/states.dart';

class SessionDetailsView extends StatefulWidget {
  final dynamic pationt_data;
  final int sessionId;
  final int isFinished;
   String? sessionCaseManager;
   String? sessionComment;
   String? sessionDate;
   dynamic consultationService;


   SessionDetailsView({super.key, required this.pationt_data,required this.sessionId,required this.isFinished,required this.sessionCaseManager,required this.sessionComment,required this.sessionDate,required this.consultationService});

  @override
  State<SessionDetailsView> createState() => _SessionDetailsViewState();
}

class _SessionDetailsViewState extends State<SessionDetailsView> {
  int needOtherSession = 0;
  int isAttendSelected = 0;
  int isSuccessStorySelected = 0;
  int selected_consultation_service = 0;
  TextEditingController advisorComment = TextEditingController();
   late AddSessionCubit _patientSessionCubit;
  late UpdateSessionCubit updateSessionCubit;
  var formKey = GlobalKey<FormState>();

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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child:
        BlocBuilder<UpdateSessionCubit, UpdateSessionStates>(
          bloc: updateSessionCubit,
          builder: (context, state) {
            return widget.isFinished==0?
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/back.jpg"),
                          fit: BoxFit.cover,
                          opacity: 0.8
                        )
                      ),
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
                                                "تم اضافة الجلسة",
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
                      ).setHorizontalPadding(context,enableMediaQuery: false, 20).setVerticalPadding(context,enableMediaQuery: false, 10),
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
                  var sessions = state.result.data["pationt"]["sessions"];
                  var patient = state.result.data["pationt"];

                  // Fetching case manager from the first session
                  var caseManager = sessions.isNotEmpty ? sessions[0]["case_manager"] : '';

                  return Container(
                    decoration: BoxDecoration(image: DecorationImage(
                      image: AssetImage("assets/images/back.jpg"),
                      fit: BoxFit.cover,
                      opacity: 0.8
                    )),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Displaying patient information
                          Text(
                            "اسم الحالة : " + patient["name"],
                            style: Constants.theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "اسم الاستشاري : " + patient["form"]["advicor"]["name"],
                            style: Constants.theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            "رقم الهوية : " + patient["national_id"],
                            style: Constants.theme.textTheme.bodyLarge?.copyWith(
                              color: Colors.black,
                            ),
                          ),
                            Text(
                              "مدير الحالة : " + widget.sessionCaseManager!??"",
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "الخدمة الاستشارية : " + (widget.consultationService?["name"]??"no found"),
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "وصف الخدمة الاستشارية : " + (widget.consultationService?["description"]??"no found"),
                              style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 20), // Adding space between case manager and table


                          // Displaying session details table
                          Table(
                            columnWidths: {
                              0: FlexColumnWidth(4),
                              1: FlexColumnWidth(1),
                              2: FlexColumnWidth(1),
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                ),
                                children: [
                                  TableCell(
                                    child: Container(
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
                                    child: Container(
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
                              // Displaying each session row
                                TableRow(
                                  decoration: BoxDecoration(
                                    color:  Colors.black38 ,
                                  ),
                                  children: [
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                           widget.sessionComment!??"",
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          widget.sessionDate!??"",
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),


                            ],
                          ),
                          SizedBox(height: 20,),

                          BorderRoundedButton(
                            title: "تعديل",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Form(
                                      key: formKey,
                                      child: SizedBox(
                                        height: Constants.mediaQuery.height * 0.6,
                                        width: Constants.mediaQuery.width * 0.45,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CustomTextField(
                                              controller: advisorComment,
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
                                              comments: advisorComment.text,);
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
                  );
                }
                return Container();
              },
            );


          }
        ),
      ),
    );
  }
}
