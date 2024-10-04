import 'package:experts_app/core/extensions/padding_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/constants.dart';
import '../../../../core/widget/check_box_question.dart';
import '../../../../core/widget/drop_down_button.dart';
import '../../allQuestionView/manager/cubit.dart';
import '../../allQuestionView/manager/states.dart';

// ignore: must_be_immutable
class QuestionDropDown extends StatefulWidget {
  List<int> selectedQuestion;
  ValueChanged onSelect;
   QuestionDropDown({super.key,required this.selectedQuestion,required this.onSelect});

  @override
  State<QuestionDropDown> createState() => _QuestionDropDownState();
}

class _QuestionDropDownState extends State<QuestionDropDown> {
  var questionViewCubit = AllQuestionCubit();

  @override
  void initState() {
    super.initState();
    questionViewCubit.getAllQuestion();
  }
  Widget build(BuildContext context) {
    return BlocBuilder<AllQuestionCubit,AllQuestionStates>(
        bloc: questionViewCubit,
        builder: (context, state) {
          if (state is LoadingAllQuestion) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ErrorAllQuestion) {
            return Center(
              child: Text(state.errorMessage),
            );
          }
          if (state is SuccessAllQuestion) {

            var question = state.question;
            print("++++++++++++++++++++>>"+question.toString());
            return DropDownButton(
              titleRadio: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.black,
                        content: SizedBox(
                            height: Constants
                                .mediaQuery.height *
                                0.6,
                            width: Constants
                                .mediaQuery.width *
                                0.45,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment
                                  .stretch,
                              children: [
                                Container(
                                  alignment: Alignment
                                      .center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius
                                        .circular(10),
                                    border: Border
                                        .all(
                                      color: Constants
                                          .theme
                                          .primaryColor,
                                      width: 2.5,
                                    ),
                                  ),
                                  child: Text(
                                      "اختر من الاسئلة",
                                      style: Constants
                                          .theme
                                          .textTheme
                                          .titleLarge
                                  ),
                                ),
                                CheckBoxQuestion(
                                  previous: widget.selectedQuestion,
                                  items: question,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.onSelect(value);
                                    });
                                  },
                                ),
                              ],
                            )),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pop();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius
                                      .circular(10),
                                  border: Border.all(
                                    color: Constants
                                        .theme
                                        .primaryColor,
                                    width: 2.5,),
                                ),
                                child: Text(
                                    "موافق",
                                    style: Constants
                                        .theme
                                        .textTheme
                                        .bodyMedium
                                )
                                    .setHorizontalPadding(
                                    context,
                                    enableMediaQuery: false,
                                    20)),
                          ),
                        ],);
                    },
                  );
                },
                child: Text("الاسئلة",
                  style: Constants.theme.textTheme
                      .bodyMedium?.copyWith(
                    color: Colors.white,),),
              ),
            );}
          else {
            return  Text("some thing went rong");
          }
        }
    );
  }
}
