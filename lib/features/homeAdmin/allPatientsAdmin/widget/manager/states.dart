

import 'package:dio/dio.dart';

abstract class PatientFormViewWithAdminStates{}
class LoadingPatientFormViewWithAdminState extends PatientFormViewWithAdminStates{}
class SuccessPatientFormViewWithAdminState extends PatientFormViewWithAdminStates{
  final Response response;
  SuccessPatientFormViewWithAdminState(this.response);
}

class ErrorPatientFormViewWithAdminState extends PatientFormViewWithAdminStates{
  final String errorMessage;
  ErrorPatientFormViewWithAdminState(this.errorMessage);
}
