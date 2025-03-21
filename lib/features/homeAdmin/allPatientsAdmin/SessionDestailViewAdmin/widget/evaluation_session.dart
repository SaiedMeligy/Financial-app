import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/allPatientsAdmin/SessionDestailViewAdmin/widget/reporst_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../core/config/constants.dart';
import '../../../../../core/widget/TextFieldPointers.dart';
import '../../../../../core/widget/custom_text_field.dart';
import '../../../../../core/widget/tab_item_widget.dart';
import '../../../../../domain/entities/QuestionModel.dart';
import '../manager/cubit.dart';
import '../manager/states.dart';

class EvaluationSession extends StatefulWidget {
   int? sessionId;
   int? formId;
  List<Pointers> pointer1 ;
  List<Pointers> pointer2 ;
  List<Pointers> pointer3 ;
   EvaluationSession({super.key, this.formId, this.sessionId,required this.pointer1,required this.pointer2,required this.pointer3});

  @override
  State<EvaluationSession> createState() => _EvaluationSessionState();
}

class _EvaluationSessionState extends State<EvaluationSession> {
  SessionCubit sessionCubitBloc = SessionCubit();
  Map<String, TextEditingController> controllers1 = {};
  Map<String, TextEditingController> controllers2 = {};
  Map<String, TextEditingController> controllers3 = {};
  List<Map<String, String>> evaluationPointers1 = [];
  List<Map<String, String>> evaluationPointers2 = [];
  List<Map<String, String>> evaluationPointers3 = [];
  late var allSelectedPointers;
  void _deletePatientLocally(int pointerId) {
    setState(() {
      widget.pointer1.removeWhere((p) => p.id == pointerId);
      widget.pointer2.removeWhere((p) => p.id == pointerId);
      widget.pointer3.removeWhere((p) => p.id == pointerId);
    });
    sessionCubitBloc.emit(SuccessEvaluationSessionState(widget.pointer1));
  }


  @override
  void initState() {
    super.initState();
    sessionCubitBloc.evaluateSession(widget.sessionId,widget.formId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تقييم مؤشرات الجلسة"),
        centerTitle: true,
        titleTextStyle: Constants.theme.textTheme.titleLarge,
        backgroundColor: Constants.theme.primaryColor,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // Adjust opacity (0.0 - 1.0)
              child: Image.asset(
                "assets/images/back.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),

          BlocBuilder<SessionCubit, States>(
            bloc: sessionCubitBloc,
            builder: (context, state) {
              if (state is LoadingEvaluationSessionState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is SuccessEvaluationSessionState) {
                var evaluationSession = state.evaluationModel;

                double estimatedItemHeight = 50.0.h;
                double calculatedHeight = (evaluationSession.length * estimatedItemHeight) + 50.h;

                return Center(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      height: calculatedHeight.clamp(100.h, Constants.mediaQuery.height * 0.6.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8), // Optional background color
                        border: Border.all(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text(
                                "التقييم الإجمالي : ${sessionCubitBloc.evaluation.totalEvaluation}/10",
                                textAlign: TextAlign.center,
                                style: Constants.theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: ReportSessionWidget(),
                                        backgroundColor: Colors.black,
                                        content: SizedBox(
                                          height: Constants.mediaQuery.height * 0.6,
                                          width: Constants.mediaQuery.width * 0.45,
                                          child: TabItemWidget(
                                            item1: "السيناريو الاول",
                                            item2: "السيناريو التاني",
                                            item3: "السيناريو التالت",
                                            firstWidget: TextFieldQuestionRow(
                                              items: widget.pointer1,
                                              controllers: controllers1, // Pass controllers
                                              onChanged: (values) {
                                                evaluationPointers1 = values
                                                    .where((pointer) => pointer["evaluation"]!.isNotEmpty)
                                                    .toList();
                                                print("Scenario 1: $evaluationPointers1");
                                              },
                                              scenarioId: '1',
                                            ),
                                            secondWidget: TextFieldQuestionRow(
                                              items: widget.pointer2,
                                              controllers: controllers2, // Pass controllers
                                              onChanged: (values) {
                                                evaluationPointers2 = values
                                                    .where((pointer) => pointer["evaluation"]!.isNotEmpty)
                                                    .toList();
                                                print("Scenario 2: $evaluationPointers2");
                                              },
                                              scenarioId: '2',
                                            ),
                                            thirdWidget: TextFieldQuestionRow(
                                              items: widget.pointer3,
                                              controllers: controllers3, // Pass controllers
                                              onChanged: (values) {
                                                evaluationPointers3 = values
                                                    .where((pointer) => pointer["evaluation"]!.isNotEmpty)
                                                    .toList();
                                                print("Scenario 3: $evaluationPointers3");
                                              },
                                              scenarioId: '3',
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              allSelectedPointers = [
                                                ...evaluationPointers1,
                                                ...evaluationPointers2,
                                                ...evaluationPointers3
                                              ];
                                              print("Final Data to Send: $allSelectedPointers");
                                              // Navigator.of(context).pop();
                                              sessionCubitBloc.addSessionEvaluation(allSelectedPointers, widget.sessionId,widget.formId).then((value) {
                                                sessionCubitBloc.evaluateSession(widget.sessionId,widget.formId);
                                                Navigator.of(context).pop();
                                              }).catchError((error) {
                                                print("Error adding evaluation: $error");
                                                // Optionally, show an error message to the user
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
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "موافق",
                                                  style: Constants.theme.textTheme.bodyMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.add_circle_rounded),
                              ),

                            ],
                          ).setVerticalPadding(context, enableMediaQuery: false, 3),

                          Divider(thickness: 2, color: Colors.black),

                          Expanded(
                            child: Container(
                              color: Constants.theme.primaryColor.withOpacity(0.4),
                              child: ListView.builder(
                                // shrinkWrap: true,
                                // physics: NeverScrollableScrollPhysics(),
                                itemCount: evaluationSession.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                    child: Row(
                                      children: [
                                        // Pointer Name Column
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            evaluationSession[index].pointerName ?? 'لا يوجد',
                                            style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                              color: Colors.black,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),

                                        Align(
                                          alignment: Alignment.center,
                                          child: Container(
                                            width: 25.w,
                                            padding: EdgeInsets.symmetric(vertical: 5.h),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5.sp),
                                              border: Border.all(color: Colors.black, width: 2),
                                            ),
                                            child: Center( // Center the text inside the box
                                              child: Text(
                                                "${evaluationSession[index].evaluation}",
                                                style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),


                                         Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: Icon(Icons.edit, color: Colors.black),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    TextEditingController evaluationController = TextEditingController(text:evaluationSession[index].evaluation.toString() );

                                                    return Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: AlertDialog(
                                                        title: Container(
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              border: Border.all(
                                                                color: Constants.theme.primaryColor,
                                                                width: 2.5,
                                                              ),
                                                            ),

                                                            child: Padding(
                                                              padding: const EdgeInsets.all(8.0),
                                                              child: Center(child: Text("تعديل التقييم",style: Constants.theme.textTheme.bodyLarge,)),
                                                            )),
                                                        backgroundColor: Colors.black,
                                                        content: SizedBox(
                                                          height: Constants.mediaQuery.height * 0.06,
                                                          width: Constants.mediaQuery.width * 0.45,
                                                          child:Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure spacing
                                                            children: [
                                                              Expanded(
                                                                child: Text(
                                                                  evaluationSession[index].pointerName,
                                                                  style: Constants.theme.textTheme.bodyLarge,
                                                                ),
                                                              ),
                                                              SizedBox(width: 10.w),
                                                              SizedBox(
                                                                width: 20.w,
                                                                height: 35.h,
                                                                child: TextField(
                                                                  controller: evaluationController,
                                                                  decoration: InputDecoration(
                                                                    focusedBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(10),

                                                                        borderSide: const BorderSide(
                                                                          color: Colors.white70,
                                                                          width: 2.5,

                                                                        )
                                                                    ),
                                                                    border: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      borderSide: const BorderSide(
                                                                        color: Colors.white70,
                                                                        width: 2.5,
                                                                      ),
                                                                    ),
                                                                    enabledBorder: OutlineInputBorder(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      borderSide: const BorderSide(
                                                                        color: Colors.white70,
                                                                        width: 2.5,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  style: Constants.theme.textTheme.bodyLarge,
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                          ,
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              sessionCubitBloc.evaluateUpdateSession(
                                                                id: evaluationSession[index].id,
                                                                  evaluation: int.parse(evaluationController.text),
                                                              ).then(
                                                                (value) {
                                                                  print("Success");
                                                                  sessionCubitBloc.evaluateSession(widget.sessionId,widget.formId);
                                                                  Navigator.pop(context);


                                                                },
                                                              );


                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: Constants.theme.primaryColor,
                                                                  width: 2.5,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  "موافق",
                                                                  style: Constants.theme.textTheme.bodyMedium,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(context);

                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                border: Border.all(
                                                                  color: Constants.theme.primaryColor,
                                                                  width: 2.5,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Text(
                                                                  "إغلاق",
                                                                  style: Constants.theme.textTheme.bodyMedium,
                                                                ),
                                                              ),
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


                                         Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: Icon(Icons.delete, color: Colors.black),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Directionality(
                                                      textDirection: TextDirection.rtl,
                                                      child: AlertDialog(
                                                        backgroundColor: Colors.black,
                                                        title: Text("حذف المؤشر", style: Constants.theme.textTheme.titleLarge),
                                                        content: Text("هل أنت متأكد أنك تريد حذف هذا المؤشر", style: Constants.theme.textTheme.bodyMedium),
                                                        actions: [
                                                          TextButton(
                                                            onPressed: () {
                                                              sessionCubitBloc.evaluateDeleteSession(evaluationSession[index].id).then(
                                                                    (value) {
                                                                  Navigator.of(context).pop();
                                                                  // _deletePatientLocally(evaluationSession[index].id); // Remove patient from local list
                                                                  sessionCubitBloc.evaluateSession(widget.sessionId,widget.formId);

                                                                    },
                                                              );
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
                                                                style: Constants.theme.textTheme.bodyMedium,
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
                                                              style: Constants.theme.textTheme.bodyMedium,
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
                                    )

                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ).setVerticalPadding(context, enableMediaQuery: false, 20)
                        .setHorizontalPadding(context, enableMediaQuery: false, 40),
                  ),
                );
              } else {
                return Center(child: Text('Something went wrong'));
              }
            },
          ),
        ],
      ),
    );
  }
}
