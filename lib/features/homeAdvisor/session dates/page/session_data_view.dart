

import 'package:experts_app/features/homeAdvisor/session%20dates/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/page/session_data_view_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/AllPatientModel.dart';
import '../../../homeAdmin/addSession/manager/cubit.dart';
import '../../../homeAdmin/addSession/manager/states.dart';
import '../../sessions/page/session_detials.dart';

class SessionDate extends StatefulWidget {
  const SessionDate({super.key});

  @override
  State<SessionDate> createState() => _SessionDateState();
}

class _SessionDateState extends State<SessionDate> {
  late AllSessionCubit _patientSessionCubit;
  bool isMobile = false;

  @override
  void initState() {
    super.initState();
    _patientSessionCubit = AllSessionCubit();
     _patientSessionCubit.getAllSession();
  }
  Widget build(BuildContext context) {
          return LayoutBuilder(
            builder: (context, constraints) {
            isMobile = constraints.maxWidth < 600;
            return BlocBuilder<AllSessionCubit,AllSessionStates>(
              bloc: _patientSessionCubit,
              builder: (context, state) {
                if (state is LoadingAllSession) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ErrorAllSession) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: Theme
                         .of(context)
                         .textTheme
                         .titleLarge
                         ?.copyWith(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                if (state is SuccessAllSession) {
                  var session = state.session;
                  return  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/back.jpg"),
                          opacity: 0.8,
                          fit: BoxFit.cover,
                        )
                      ),
                      child: Column(
                        children: [
                          Table(
                            columnWidths: const {
                              0: FlexColumnWidth(4),
                              1: FlexColumnWidth(2.5),
                              2: FlexColumnWidth(2.57),
                              3: FlexColumnWidth(2),
                              4: FlexColumnWidth(2),
                            },
                            children: [
                              TableRow(
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                ),
                                children: [
                                  TableCell(
                                    child: Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "اسم الحالة",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                            fontSize: isMobile?18:22,
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
                                          "رقم الجلسة",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                            fontSize: isMobile?18:22,
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
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                            fontSize: isMobile?18:22,
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
                                          "الوقت",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                            fontSize: isMobile?18:22,
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
                                          "الحالة",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge
                                              ?.copyWith(
                                            fontSize: isMobile?18:22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              ...session.map((session) {
                                return TableRow(
                                  decoration: const BoxDecoration(
                                    color: Colors.black38,
                                  ),
                                  children: [
                                    TableCell(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => SessionDetailsViewHome(
                                                pationt_data:session.pationt,
                                                sessionId:session.id,
                                                isFinished:session.isFinished,
                                                sessionCaseManager:session.caseManager,
                                                sessionComment:session.comments,
                                                sessionDate:session.date,
                                                consultationService: session.consultationService,
                                              ),
                                            ),

                                          );

                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            session.pationt.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                              color: Colors.white,
                                              fontSize: isMobile?16:20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => SessionDetailsView(
                                          //       pationt_data:widget.pationt_data,
                                          //       sessionId:session[index]["id"],
                                          //       isFinished:session[index]["is_finished"],
                                          //       sessionCaseManager:session[index]["case_manager"],
                                          //       sessionComment:session[index]["comments"],
                                          //       sessionDate:session[index]["date"],
                                          //       consultationService: session[index]["consultation_service"],
                                          //     ),
                                          //   ),
                                          // );
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "الجلسة ${session.sessionNumber}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                              color: Colors.white,
                                              fontSize: isMobile?16:20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          session.date,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontSize: isMobile?16:20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          session.time,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontSize: isMobile?16:20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          session.isFinished==1 ? "انتهت" : "لم تنته",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontSize: isMobile?16:20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                else
                  return Center(
                    child: Text("some thing went wrong"),
                  );
              }
            );}
          );

  }
}
