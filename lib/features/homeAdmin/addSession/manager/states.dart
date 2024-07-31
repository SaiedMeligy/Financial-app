
import 'package:dio/dio.dart';

sealed class AddSessionStates{}
class LoadingAddSessionState extends AddSessionStates{}
class SuccessPatientNationalIdState extends AddSessionStates{
  final dynamic result;
  SuccessPatientNationalIdState(this.result);
}
class SuccessAddSessionState extends AddSessionStates{
  final Response result;
  SuccessAddSessionState(this.result);

}
class SuccessShowSession extends AddSessionStates{
  final Response result;
  SuccessShowSession(this.result);

}
class SuccessShowSessionWithAdmin extends AddSessionStates{
  final Response result;
  SuccessShowSessionWithAdmin(this.result);

}

class ErrorAddSessionState extends AddSessionStates{
  final String errorMessage;
  ErrorAddSessionState(this.errorMessage);
}
class ErrorFormState extends AddSessionStates{

  ErrorFormState();
}
