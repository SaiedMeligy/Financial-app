

import 'package:dio/dio.dart';

abstract class PatientFormViewStates{}
class LoadingPatientFormViewState extends PatientFormViewStates{}
class SuccessPatientFormViewState extends PatientFormViewStates{
  final Response response;
  SuccessPatientFormViewState(this.response);
}

class ErrorPatientFormViewState extends PatientFormViewStates{
  final String errorMessage;
  ErrorPatientFormViewState(this.errorMessage);
}
