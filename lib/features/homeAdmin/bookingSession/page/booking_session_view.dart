import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/SessionDestailViewAdmin/page/session_Details_view_admin.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/session%20dates/manager/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  ScrollController _scrollController = ScrollController();
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
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent-50){
        if(!_patientSessionCubit.isLoading)
        _patientSessionCubit.getAllSessionWithAdmin(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        isMobile = constraints.maxWidth < 600;
        return BlocBuilder<AllSessionCubit, AllSessionStates>(
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
              var filteredSessions = session.where((s) => s.pationt!.name!.toLowerCase().contains(searchQuery.toLowerCase())).toList();

              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.2,
                  ),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      controller: searchController,
                      hint: "البحث",
                      icon: Icons.search,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Table(
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
                                  color: Colors.black,
                                ),
                                children: [
                                  TableCell(
                                    child: SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "اسم الحالة",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile ? 14 : 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Center(
                                        child: Text(
                                          "أسم الاستشارى",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile ? 12 : 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Center(
                                        child: Text(
                                          "رقم الجلسة",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile ? 12 : 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: SizedBox(
                                      height: 60,
                                      child: Center(
                                        child: Text(
                                          "تاريخ الجلسة",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            color: Colors.white,
                                            fontSize: isMobile ? 12 : 20,
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
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile ? 12 : 20,
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
                                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                            fontSize: isMobile ? 12 : 20,
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
                              itemCount: session.length+1,
                              itemBuilder: (context, index) {
                                if (index == session.length) {
                                  return const Center(
                                    child: CircularProgressIndicator(), // Show loader when at the end of the list
                                  );
                                }
                                var item = session[index];
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => SessionDetailsViewAdmin(
                                                      pationt_data: item.pationt,
                                                      sessionId: item.id!,
                                                      isFinished: item.isFinished!,
                                                      sessionCaseManager: item.caseManager,
                                                      sessionComment: item.comments,
                                                      sessionDate: item.date,
                                                      consultationService: item.consultationService,
                                                      isAttend: item.isAttended,
                            
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  item.pationt!.name.toString(),
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                                                  item.advicor!.name.toString(),
                                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                    color: Colors.white,
                                                    fontSize: isMobile ? 12 : 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "الجلسة ${item.sessionNumber}",
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: isMobile ? 12 : 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                item.date.toString(),
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: isMobile ? 14 : 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                item.time.toString(),
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: isMobile ? 12 : 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          TableCell(
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                item.isFinished == 1 ? "انتهت" : "لم تنته",
                                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  color: Colors.white,
                                                  fontSize: isMobile ? 12 : 20,
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
                ).setHorizontalPadding(context, enableMediaQuery: false, 20).setVerticalPadding(context, enableMediaQuery: false, 20),
              );
            } else {
              return const Center(
                child: Text(
                  "something went wrong",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
        );
      },
    );
  }
}
