import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';

import '../../../../../../core/config/constants.dart';
import '../../../../session dates/page/session_data_view_home.dart';

class PatientSessionView extends StatefulWidget {
  final dynamic pationt_data;

  PatientSessionView({Key? key, required this.pationt_data}) : super(key: key);

  @override
  _PatientSessionViewState createState() => _PatientSessionViewState();
}

class _PatientSessionViewState extends State<PatientSessionView> {
  late AddSessionCubit _patientSessionCubit;
  bool isMobile =false;

  @override
  void initState() {
    super.initState();
    _patientSessionCubit = AddSessionCubit();
    _patientSessionCubit.getSessionDetails(widget.pationt_data.nationalId);
  }

  @override
  void dispose() {
    _patientSessionCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddSessionCubit, AddSessionStates>(
      bloc: _patientSessionCubit,
      builder: (context, state) {
        if (state is LoadingAddSessionState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ErrorAddSessionState) {
          return Center(child: Text(state.errorMessage));
        } else if (state is SuccessAddSessionState) {
          var session = state.result.data["pationt"]["sessions"];

          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/back.jpg"),
                fit: BoxFit.cover,
                opacity: 0.4
              )
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                automaticallyImplyLeading: true,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back,color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
                leadingWidth: 40,
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  isMobile = constraints.maxWidth < 600;
                  return Directionality(
                    textDirection: TextDirection.rtl,
                    child: Table(
                      columnWidths: {
                        0: FlexColumnWidth(4),
                        1: FlexColumnWidth(1),
                      },
                      border: TableBorder.all(color: Colors.black),
                      children: [
                        TableRow(
                          decoration: BoxDecoration(color: Colors.black),
                          children: [
                            TableCell(
                              child: Container(
                                height: 50,
                                child: Center(
                                  child: Text(
                                      "اسم الجلسة",
                                      textAlign: TextAlign.center,
                                      style: isMobile ? Constants.theme.textTheme.bodyMedium : Theme
                                          .of(context)
                                          .textTheme
                                          .bodyLarge
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
                                    style: isMobile?Constants.theme.textTheme.bodyMedium:Theme
                                        .of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (int index = 0; index <
                            session.length; index++) ...[
                          TableRow(
                            decoration: BoxDecoration(color: Colors.black38),
                            children: [
                              TableCell(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SessionDetailsViewHome(
                                              pationt_data: widget.pationt_data,
                                              sessionId: session[index]["id"],
                                              isFinished: session[index]["is_finished"],
                                              sessionCaseManager: session[index]["case_manager"],
                                              sessionComment: session[index]["comments"],
                                              sessionDate: session[index]["date"],
                                              consultationService: session[index]["consultation_service"],
                                              isAttend: session[index]["is_attended"],
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "الجلسة " +
                                          session[index]["session_number"]
                                              .toString(),
                                      style: isMobile?Constants.theme.textTheme.bodyMedium:Theme.of(context).textTheme.bodyLarge

                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    session[index]["date"],
                                    style: isMobile?Constants.theme.textTheme.bodyMedium:Theme
                                        .of(context)
                                        .textTheme
                                        .bodyLarge

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  );
                }),
            ),
          );
        }
        return Container();
      },
    );
  }
}
