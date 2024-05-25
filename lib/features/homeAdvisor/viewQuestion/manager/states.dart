import '../../../../domain/entities/QuestionView.dart';

abstract class QuestionViewStates{}
class LoadingQuestionViewState extends QuestionViewStates{}
class SuccessQuestionViewState extends QuestionViewStates{
  final List<Questions> question;
  SuccessQuestionViewState(this.question);
}
class ErrorQuestionViewState extends QuestionViewStates{
  final String errorMessage;
  ErrorQuestionViewState(this.errorMessage);
}
