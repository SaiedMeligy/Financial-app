import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionRelationModel.dart';

import '../../../../domain/entities/QuestionModel.dart';


abstract class AllQuestionStates{}
class LoadingAllQuestion extends AllQuestionStates{}
class SuccessAllQuestion extends AllQuestionStates{
  final List<Questions> question;
  SuccessAllQuestion(this.question);
}
class SuccessAllQuestionRelation extends AllQuestionStates{
  final List<QuestionsRelation> question;
  SuccessAllQuestionRelation(this.question);
}
class SuccessDeleteQuestionState extends AllQuestionStates{
  SuccessDeleteQuestionState(Response result);
}

class ErrorAllQuestion extends AllQuestionStates{
  final String errorMessage;
  ErrorAllQuestion(this.errorMessage);

}