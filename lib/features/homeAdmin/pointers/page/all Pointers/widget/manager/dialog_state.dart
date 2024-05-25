import 'package:dio/src/response.dart';

abstract class UpdatePointerStates{}
class LoadingUpdatePointerState extends UpdatePointerStates{}
class SuccessUpdatePointerState extends UpdatePointerStates{
  SuccessUpdatePointerState(Response response);}
class SuccessDeletePointerState extends UpdatePointerStates{
  SuccessDeletePointerState(Response response);}
class ErrorUpdatePointers extends UpdatePointerStates{
  final String errorMessage;
  ErrorUpdatePointers(this.errorMessage);

}