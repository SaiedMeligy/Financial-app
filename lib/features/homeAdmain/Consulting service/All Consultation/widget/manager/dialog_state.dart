import 'package:dio/src/response.dart';

abstract class UpdateConsultationStates{}
class LoadingUpdateConsultationState extends UpdateConsultationStates{}
class SuccessUpdateConsultationState extends UpdateConsultationStates{SuccessUpdateConsultationState(Response response);}
class SuccessDeleteConsultationState extends UpdateConsultationStates{SuccessDeleteConsultationState(Response response);}
class ErrorUpdateConsultations extends UpdateConsultationStates{
  final String errorMessage;
  ErrorUpdateConsultations(this.errorMessage);

}