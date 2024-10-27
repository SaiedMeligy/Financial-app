

import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/page/session_data_view_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widget/custom_text_field.dart';

class SessionDate extends StatefulWidget {
  const SessionDate({super.key});

  @override
  State<SessionDate> createState() => _SessionDateState();
}

class _SessionDateState extends State<SessionDate> {
  late AllSessionCubit _patientSessionCubit;
  bool isMobile = false;
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  String searchQuery = '';


  @override
  void initState() {
    super.initState();
    _patientSessionCubit = AllSessionCubit();
    _patientSessionCubit.getAllSession();

    // searchController.addListener(() {
    //   setState(() {
    //     searchQuery = searchController.text;
    //   });
    // });


    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
        if(!_patientSessionCubit.isLoading) {
          _patientSessionCubit.getAllSession(loadMore: true);
        }
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  void search() {
    _scrollController.jumpTo(0);
    _patientSessionCubit.getAllSession(searchQuery: searchController.text);
  }

  @override
  Widget build(BuildContext context) {
          return LayoutBuilder(
            builder: (context, constraints) {
            isMobile = constraints.maxWidth < 600;
            return BlocBuilder<AllSessionCubit,AllSessionStates>(
              bloc: _patientSessionCubit,
              builder: (context, state) {
                if (state is LoadingAllSession) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ErrorAllSession) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  );
                }
                if (state is SuccessAllSession) {
                  var session = state.session;
                  var filteredSessions = session.where((s) =>
                  s.pationt?.name?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false).toList();
                  return  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/back.jpg"),
                          opacity: 0.2,
                          fit: BoxFit.cover,
                        )
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: searchController,
                            hint: "البحث",
                            prefixIcon: IconButton(
                                onPressed: () {
                                  search();
                                },
                                icon: Icon(Icons.search)),

                          ),
                          const SizedBox(height: 20,),
                          Expanded(
                            child: Column(
                              children:[
                                Table(
                                columnWidths: const {
                                  0: FlexColumnWidth(4),
                                  1: FlexColumnWidth(2.7),
                                  2: FlexColumnWidth(2),
                                  3: FlexColumnWidth(2.9),
                                  4: FlexColumnWidth(2),
                                  5: FlexColumnWidth(1.8),
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
                                                fontSize: isMobile?14:22,
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
                                                fontSize: isMobile?14:22,
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
                                                fontSize: isMobile?14:22,
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
                                                fontSize: isMobile?14:22,
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
                                                fontSize: isMobile?14:22,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                                Expanded(
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    itemCount: _patientSessionCubit.isLastPage?filteredSessions.length:filteredSessions.length+1,
                                    itemBuilder: (context, index) {
                                      if (index == filteredSessions.length) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      var sessionIndex = filteredSessions[index];
                                      return Table(
                                        columnWidths: const {
                                          0: FlexColumnWidth(4),
                                          1: FlexColumnWidth(2.7),
                                          2: FlexColumnWidth(2),
                                          3: FlexColumnWidth(2.6),
                                          4: FlexColumnWidth(2),
                                          5: FlexColumnWidth(2),
                                        },

                                        children: [
                                          TableRow(
                                            decoration: const BoxDecoration(
                                              color: Colors.black38,
                                            ),
                                            children: [
                                              TableCell(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => SessionDetailsViewHome(
                                                        pationt_data:sessionIndex.pationt,
                                                        sessionId:sessionIndex.id!,
                                                        isFinished:sessionIndex.isFinished!,
                                                        sessionCaseManager:sessionIndex.caseManager,
                                                        sessionComment:sessionIndex.comments,
                                                        sessionDate:sessionIndex.date,
                                                        consultationService: sessionIndex.consultationService,
                                                        isAttend: sessionIndex.isAttended,
                                                      ),
                                      )
                                                    );

                                                    },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      sessionIndex.pationt!.name.toString(),
                                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                        color: Colors.white,
                                                        fontSize: isMobile?14:20,
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
                                                      "الجلسة ${sessionIndex.sessionNumber}",
                                                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                        color: Colors.white,
                                                        fontSize: isMobile?12:20,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              TableCell(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    sessionIndex.date.toString(),
                                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: isMobile?9:20,
                                                    ),
                                                  ),
                                                ),
                                      ),
                                              TableCell(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    sessionIndex.time.toString(),
                                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: isMobile?12:20,),),),),
                                              TableCell(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    sessionIndex.isFinished==1 ? "انتهت" : "لم تنته",
                                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                      color: Colors.white,
                                                      fontSize: isMobile?12:20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ],
                                      )

                                        ],
                                      );

                                  },),
                                )
                              ],
                            ),
                          ),
                        ],
                      ).setHorizontalPadding(context,enableMediaQuery: false,20).setVerticalPadding(context,enableMediaQuery: false, 20),
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
