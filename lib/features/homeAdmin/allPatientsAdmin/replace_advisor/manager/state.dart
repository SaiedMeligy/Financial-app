import 'package:dio/src/response.dart';

abstract class ReplacePatientWithAdminStates{}
class LoadingReplacePatientWithAdminState extends ReplacePatientWithAdminStates{}
class SuccessReplacePatientWithAdminState extends ReplacePatientWithAdminStates{
  SuccessReplacePatientWithAdminState(Response response);}
class ErrorReplacePatientWithAdmin extends ReplacePatientWithAdminStates{
  final String errorMessage;
  ErrorReplacePatientWithAdmin(this.errorMessage);

}