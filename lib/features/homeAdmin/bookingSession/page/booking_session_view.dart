import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/SessionDestailViewAdmin/page/session_Details_view_admin.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widget/custom_text_field.dart';

class BookingSessionView extends StatefulWidget {
  const BookingSessionView({super.key});

  @override
  State<BookingSessionView> createState() => _BookingSessionViewState();
}

class _BookingSessionViewState extends State<BookingSessionView> {
  late AllSessionCubit _patientSessionCubit;
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isMobile = false;

  @override
  void initState() {
    super.initState();
    _patientSessionCubit = AllSessionCubit();
    _patientSessionCubit.getAllSessionWithAdmin();
    searchController.addListener(() {
      setState(() {
        searchQuery = searchController.text;
      });
    });
  }
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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

              // var filteredSessions = session.where((sessions) =>
              //     sessions.pationt.name.toLowerCase().contains(searchQuery.toLowerCase())).toList();

            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/back.jpg"),
                  fit: BoxFit.cover,
                opacity:0.8
                )
              ),
              child: Column(
                children: [
                   CustomTextField(
                    controller: searchController,
                    hint: "البحث",
                    icon: Icons.search,
                  ),
                  SizedBox(height: 20,),
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(4),
                      1: FlexColumnWidth(2.5),
                      2: FlexColumnWidth(2),
                      3: FlexColumnWidth(2.6),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(2),
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
                                    "اسم الحالة",
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontSize: isMobile?16:20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    "أسم الاستشاري",
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontSize: isMobile?15:20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    "رقم الجلسة",
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontSize: isMobile?15:20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    "تاريخ الجلسة",
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(

                                      color: Colors.white,
                                      fontSize: isMobile?15:20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    "الوقت",
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontSize: isMobile?15:20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                height: 60,
                                child: Center(
                                  child: Text(
                                    "الحالة",
                                    textAlign: TextAlign.center,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                      fontSize: isMobile?15:20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ]
                      ),
                      ...session.map((session) {
                      return TableRow(
                          decoration: BoxDecoration(
                            color: Colors.black38,
                          ),
                          children: [
                            TableCell(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SessionDetailsViewAdmin(
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
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    session.advicor.name,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                      color: Colors.white,
                                      fontSize: isMobile?15:20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "الجلسة ${session.sessionNumber}",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontSize: isMobile?15:20,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  session.date,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontSize: isMobile?14:20,
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  session.time,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontSize: isMobile?15:20,

                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  session.isFinished ==1?"انتهت":"لم تنته",
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    color: Colors.white,
                                    fontSize: isMobile?15:20,
                                  ),
                                ),
                              ),
                            ),

                          ]
                      );
                      }).toList(),
                      //]
                    ],


                  )

                ],
              )
                  .setHorizontalPadding(context, enableMediaQuery: false, 20)
                  .setVerticalPadding(context, enableMediaQuery: false, 20),
            );
          }
          else {
            return Center(
              child: Text("some thing went wrong",style: TextStyle(color: Colors.red),),
            );
          }
        }
      );}
    );
  }
}
