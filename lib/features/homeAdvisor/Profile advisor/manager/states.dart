

import 'package:dio/dio.dart';

abstract class ProfileAdvisorStates{}
class LoadingProfileAdvisorState extends ProfileAdvisorStates{}
class LoadingUpdateProfileState extends ProfileAdvisorStates{}
class SuccessProfileAdvisorState extends ProfileAdvisorStates{
  final Response response;
  SuccessProfileAdvisorState(this.response);
}
class SuccessUpdateProfileState extends ProfileAdvisorStates{
  SuccessUpdateProfileState(Response response);}

class ErrorProfileAdvisorState extends ProfileAdvisorStates{
  final String errorMessage;
  ErrorProfileAdvisorState(this.errorMessage);
}
class ErrorUpdateProfileState extends ProfileAdvisorStates{
  final String errorMessage;
  ErrorUpdateProfileState(this.errorMessage);
}
