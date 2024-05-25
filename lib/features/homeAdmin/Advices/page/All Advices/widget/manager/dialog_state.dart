import 'package:dio/src/response.dart';

abstract class UpdateAdviceStates{}
class LoadingUpdateAdviceState extends UpdateAdviceStates{}
class SuccessUpdateAdviceState extends UpdateAdviceStates{
  SuccessUpdateAdviceState(Response response);}
class SuccessDeleteAdviceState extends UpdateAdviceStates{
  SuccessDeleteAdviceState(Response response);}
class ErrorUpdateAdvices extends UpdateAdviceStates{
  final String errorMessage;
  ErrorUpdateAdvices(this.errorMessage);

}