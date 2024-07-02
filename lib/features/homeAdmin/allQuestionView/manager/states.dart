import 'package:dio/dio.dart';

import '../../../../domain/entities/QuestionModel.dart';


abstract class AllQuestionStates{}
class LoadingAllQuestion extends AllQuestionStates{}
class SuccessAllQuestion extends AllQuestionStates{
  final List<Questions> question;
  SuccessAllQuestion(this.question);
}
class SuccessDeleteQuestionState extends AllQuestionStates{
  SuccessDeleteQuestionState(Response result);
}

class ErrorAllQuestion extends AllQuestionStates{
  final String errorMessage;
  ErrorAllQuestion(this.errorMessage);

}