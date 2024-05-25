import 'package:dio/src/response.dart';

abstract class AddQuestionStates{}
class LoadingAddQuestionState extends AddQuestionStates{}
class SuccessAddQuestionState extends AddQuestionStates{
  SuccessAddQuestionState(Response result);
}
// class AddQuestionLoadedState extends AddQuestionStates{
// }
class ErrorAddQuestionState extends AddQuestionStates{
  final String errorMessage;
  ErrorAddQuestionState(this.errorMessage);
}