import 'package:dio/src/response.dart';

import '../../../../domain/entities/AdviceMode.dart';

abstract class AddQuestionStates{}
class LoadingAddQuestionState extends AddQuestionStates{}
class SuccessAddQuestionState extends AddQuestionStates{
  SuccessAddQuestionState(Response result);
}
class ErrorAddQuestionState extends AddQuestionStates{
  final String errorMessage;
  ErrorAddQuestionState(this.errorMessage);
}
