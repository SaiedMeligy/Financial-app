import 'package:dio/src/response.dart';

abstract class UpdatePatientStates{}
class LoadingUpdatePatientState extends UpdatePatientStates{}
class SuccessUpdatePatientState extends UpdatePatientStates{
  SuccessUpdatePatientState(Response response);}
class SuccessDeletePatientState extends UpdatePatientStates{
  SuccessDeletePatientState(Response response);}
class ErrorUpdatePatients extends UpdatePatientStates{
  final String errorMessage;
  ErrorUpdatePatients(this.errorMessage);

}