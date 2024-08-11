import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:experts_app/features/homeAdmin/allQuestionView/manager/cubit.dart';
import 'package:experts_app/features/homeAdmin/allQuestionView/manager/states.dart';
import 'package:experts_app/features/homeAdmin/question/pages/update_question.dart';

class AllQuestionView extends StatefulWidget {
  AllQuestionView({Key? key}) : super(key: key);

  @override
  _AllQuestionViewState createState() => _AllQuestionViewState();
}

class _AllQuestionViewState extends State<AllQuestionView> {
  final questionViewCubit = AllQuestionCubit();

  @override
  void initState() {
    super.initState();
    questionViewCubit.getAllQuestionWithoutRelation();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllQuestionCubit, AllQuestionStates>(
      bloc: questionViewCubit,
      builder: (context, state) {
        if (state is LoadingAllQuestion) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SuccessAllQuestion) {
          var questions = state.question;

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/back.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.2
                  ),
                ),
                child: ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    var question = questions[index];
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                        if (index == 0 || questions[index - 1].axisId != question.axisId)
                        Column(
                            children: [
                        Text(
                        question.axis!.name.toString(),
                        style: Constants.theme.textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Container(
                        height: 3,
                          width: 140,
                          color: Colors.black54,
                                ),
                              ],
                            ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black87,
                                width: 2.5,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(10),
                                                ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      question.title.toString(),
                                      style: Constants.theme.textTheme.bodyLarge?.copyWith(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateQuestion(question: question, allQuestions: questions)));
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: AlertDialog(
                                                  title: Text(
                                                    "حذف السؤال",
                                                    style: Constants.theme.textTheme.titleLarge?.copyWith(color: Colors.black),
                                                  ),
                                                  content: Text(
                                                    "هل أنت متأكد أنك تريد حذف هذا السؤال؟",
                                                    style: Constants.theme.textTheme.bodyMedium?.copyWith(color: Colors.black),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        questionViewCubit.deleteQuestion(question.id!).then((_) {
                                                          questionViewCubit.getAllQuestion();
                                                          Navigator.of(context).pop();
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
                                                          "موافق",
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
                                        icon: Icon(
                                          Icons.delete,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ).setVerticalPadding(context, enableMediaQuery: false, 10).setHorizontalPadding(context, enableMediaQuery: false, 20);
                  });
                  },
                ),
              ),
            ),
          );
        } else if (state is ErrorAllQuestion) {
          return Center(child: Text(state.errorMessage));
        }
        return SizedBox.shrink();
      },
    );
  }
}
