import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/widget/manager/cubit.dart';
import 'package:experts_app/features/homeAdvisor/allPatients/widget/manager/states.dart';
import 'package:experts_app/features/homeAdvisor/viewQuestion/page/update_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PatientDetailsView extends StatefulWidget {
  PatientDetailsView({super.key, required this.pationt_data});
  final dynamic pationt_data;

  @override
  State<PatientDetailsView> createState() => _PatientDetailsViewState();
}

class _PatientDetailsViewState extends State<PatientDetailsView> with TickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<Offset> _animation1;
  late AnimationController _controller2;
  late Animation<Offset> _animation2;
  late AnimationController _controller3;
  late Animation<Offset> _animation3;
  int _currentAnimation = 1;

  late PatientFormViewCubit _patientFormViewCubit;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controllers and animations
    _controller1 = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _animation1 = Tween<Offset>(
      begin: Offset(-4.0, 0.0),
      end: Offset(4, 0.0),
    ).animate(_controller1);

    _controller2 = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _animation2 = Tween<Offset>(
      begin: Offset(-4.0, 0.0),
      end: Offset(4.0, 0.0),
    ).animate(_controller2);

    _controller3 = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    _animation3 = Tween<Offset>(
      begin: Offset(-3.0, 0.0),
      end: Offset(4.0, 0.0),
    ).animate(_controller3);

    _controller1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller1.reset();
        _controller2.forward();
        setState(() {
          _currentAnimation = 2;
        });
      }
    });

    _controller2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller2.reset();
        _controller3.forward();
        setState(() {
          _currentAnimation = 3;
        });
      }
    });

    _controller3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller3.reset();
        _controller1.forward();
        setState(() {
          _currentAnimation = 1;
        });
      }
    });

    _controller1.forward();

    // Initialize the PatientFormViewCubit
    _patientFormViewCubit = PatientFormViewCubit();
    _patientFormViewCubit.getPatientFormView(widget.pationt_data.id);
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _patientFormViewCubit.close(); // Close the cubit when done
    super.dispose();
  }

  List<dynamic> filterQuestionsWithAnswer(List<dynamic> answers) {
    return answers.where((answer) {
      return answer['question_options'].any((option) {
        if (option['answer'] is String) {
          return option['answer'] == "1";
        } else if (option['answer'] is int) {
          return option['answer'] == 1;
        }
        return false;
      });
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientFormViewCubit, PatientFormViewStates>(
      bloc: _patientFormViewCubit, // Use the initialized cubit here
      builder: (context, state) {
        if (state is LoadingPatientFormViewState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ErrorPatientFormViewState) {
          return Center(
            child: Text(state.errorMessage),
          );
        } else if (state is SuccessPatientFormViewState) {
          var formData = state.response.data["form"];
          var patient = state.response.data["form"]["pationt"];
          var advicor = state.response.data["form"]["advicor"];
          var answers = state.response.data["form"]["answers"];
          var consultation = formData["consultationService"];

          var filteredAnswers = filterQuestionsWithAnswer(answers);


          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.9,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: Constants.mediaQuery.height * 0.2,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.black87,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.edit,color: Colors.white),
                          onPressed: () {

                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return UpdateForm(pationt_data: widget.pationt_data);


                                },));
                          }
                            ),
                          ),
                          if (_currentAnimation == 1)
                            SlideTransition(
                              position: _animation1,
                              child: Text(
                                "الحالة : ${patient["name"]}  ",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          if (_currentAnimation == 2)
                            SlideTransition(
                              position: _animation2,
                              child: Text(
                                "الاستشاري : ${advicor["name"]}  ",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          if (_currentAnimation == 3)
                            SlideTransition(
                              position: _animation3,
                              child: Text(
                                "تاريخ الجلسة : ${formData["date"]}  ",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),

                    Expanded(
                      child: Container(
                        height: Constants.mediaQuery.height * 0.8,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child:
                        ListView.builder(
                          itemCount: filteredAnswers.length,
                          itemBuilder: (context, index) {
                            var answer = filteredAnswers[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (filteredAnswers.length != index + 1) ...[
                                  if (answer["question_options"].any((option) => option['answer'] == "1" || option['answer'] == 1))
                                    Center(
                                      child: Text(
                                          answer["title"],
                                          style: Constants.theme.textTheme.titleLarge?.copyWith(
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                    ),
                                  Container(
                                    width: double.infinity,
                                    height:  answers[index]["question_options"].length > 1
                                  ? answers[index]["question_options"].length * 50 : 70,
                                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child:
                                    Column(
                                      children: answer["question_options"].map<Widget>((option) {
                                        bool isAnswered = (option['answer'] is String && option['answer'] == "1") ||
                                            (option['answer'] is int && option['answer'] == 1);
                                        return
                                          Row(
                                            children: [
                                              if (isAnswered)
                                                Expanded(
                                                  child: Text(
                                                    option["title"].toString(),
                                                    style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              if (option["type"] == 1 && isAnswered)
                                                Expanded(
                                                  child: Radio<bool>(
                                                    value: true,
                                                    groupValue: true,
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                              if (option["type"] == 2 && isAnswered)

                                                Expanded(
                                                  child: Checkbox(
                                                    value: true,
                                                    onChanged: (value) {},
                                                  ),
                                                ),
                                              if (option["type"] == 3 && option["answer"] != null)

                                                Expanded(
                                                  child: Text(
                                                    option["answer"].toString(),
                                                    style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          );
                                      }).toList(),
                                    ).setHorizontalPadding(context, enableMediaQuery: false, 20),

                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 3,
                                    indent: 20,
                                    endIndent: 20,
                                    color: Colors.grey.shade600,
                                  ),
                                  SizedBox(height: 10),
                                ] else ...[
                                  Column(
                                    children: [
                                      Text(consultation["name"]),
                                      SizedBox(height: 10),
                                      Container(
                                        height: Constants.mediaQuery.height * 0.15,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        child: Text(
                                          consultation["description"],
                                          style: Constants.theme.textTheme.bodyMedium?.copyWith(
                                            color: Colors.black,
                                          ),
                                        ).setHorizontalPadding(context, enableMediaQuery: false, 20),
                                      ),
                                    ],
                                  ).setVerticalPadding(context, enableMediaQuery: false, 20),
                                ],
                              ],
                            );
                          },
                        ).setHorizontalPadding(context, enableMediaQuery: false, 20),

                      ).setHorizontalPadding(context,enableMediaQuery: false ,20),
                    ),
                    ]
                ),
              ),
            ),
          );
        } else {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
