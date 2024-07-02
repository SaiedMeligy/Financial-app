import 'package:dio/src/response.dart';

abstract class UpdatePatientWithAdminStates{}
class LoadingUpdatePatientWithAdminState extends UpdatePatientWithAdminStates{}
class SuccessUpdatePatientWithAdminState extends UpdatePatientWithAdminStates{
  SuccessUpdatePatientWithAdminState(Response response);}
class SuccessDeletePatientWithAdminState extends UpdatePatientWithAdminStates{
  SuccessDeletePatientWithAdminState(Response response);}
class ErrorUpdatePatientWithAdmin extends UpdatePatientWithAdminStates{
  final String errorMessage;
  ErrorUpdatePatientWithAdmin(this.errorMessage);

}