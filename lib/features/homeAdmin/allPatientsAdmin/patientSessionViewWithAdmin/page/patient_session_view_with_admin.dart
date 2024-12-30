import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/addSession/manager/states.dart';

import '../../../../../core/config/constants.dart';
import '../../SessionDestailViewAdmin/page/session_Details_view_admin.dart';


class PatientSessionViewWithAdmin extends StatefulWidget {
  final dynamic pationt_data;

  PatientSessionViewWithAdmin({Key? key, required this.pationt_data}) : super(key: key);

  @override
  _PatientSessionViewWithAdminState createState() => _PatientSessionViewWithAdminState();
}

class _PatientSessionViewWithAdminState extends State<PatientSessionViewWithAdmin> {
  late AddSessionCubit _patientSessionCubit;
bool isMobile = false;
  @override
  void initState() {
    super.initState();
    _patientSessionCubit = AddSessionCubit();
    _patientSessionCubit.getPatientDetails(widget.pationt_data.nationalId);
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
        } else if (state is SuccessPatientNationalIdState) {
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
                    icon: Icon(Icons.arrow_back,color: Colors.black),
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
                        1: FlexColumnWidth(2),
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
                                    style: Theme.of(context).textTheme
                                        .bodyLarge
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
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyLarge
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
                                    "حذف الجلسة",
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
                        for (int index = 0; index < session.length; index++) ...[
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
                                            SessionDetailsViewAdmin(
                                              pationt_data: widget.pationt_data,
                                              sessionId: session[index]["id"],
                                              patientNationalId: session[index]["pationt"]['national_id'],
                                              patientId: session[index]["pationt"]['id'],
                                              isFinished: session[index]["is_finished"],
                                              sessionCaseManager: session[index]["case_manager"],
                                              sessionComment: session[index]["comments"],
                                              sessionDate: session[index]["date"],
                                              consultationService: session[index]["consultation_services"],
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
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                          color: Colors.white,
                                          fontSize: isMobile?16:20
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    session[index]["date"],
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                        color: Colors.white,
                                        fontSize: isMobile?16:20
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Colors.white),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: AlertDialog(
                                            title: Text("حذف الجلسة", style: Constants.theme.textTheme.titleLarge?.copyWith(
                                                color: Colors.black
                                            )),
                                            content: Text("هل أنت متأكد أنك تريد حذف هذه الجلسة", style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                color: Colors.black
                                            )),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  _patientSessionCubit.deleteSessionWithAdmin(session[index]['id']).then((_) {

                                                    Navigator.of(context).pop();
                                                    // _deletePatientLocally(widget.pationt_data); // Remove patient from local list

                                                    _patientSessionCubit.getPatientDetails(widget.pationt_data.nationalId);
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
                                                    'نعم',
                                                    style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                  ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                }, child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  border: Border.all(
                                                    color: Constants.theme.primaryColor,
                                                    width: 2.5,
                                                  ),
                                                ),
                                                child: Text(
                                                  'لا',
                                                  style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                              ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
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
