import 'package:dio/src/response.dart';

import '../../../../domain/entities/QuestionView.dart';

abstract class QuestionViewStates{}
class LoadingQuestionViewState extends QuestionViewStates{}
class SuccessQuestionViewState extends QuestionViewStates{
  final List<Questions> question;
  SuccessQuestionViewState(this.question);
}
class SuccessPatientNationalIdState extends QuestionViewStates{
  SuccessPatientNationalIdState(Response result);
}
class QuestionViewDateSelected extends QuestionViewStates {
  final DateTime selectedDate;
  QuestionViewDateSelected(this.selectedDate);
}

class ErrorQuestionViewState extends QuestionViewStates{
  final String errorMessage;
  ErrorQuestionViewState(this.errorMessage);
}
