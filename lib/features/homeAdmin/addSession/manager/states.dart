
sealed class AddSessionStates{}
class LoadingAddSessionState extends AddSessionStates{}
class SuccessPatientNationalIdState extends AddSessionStates{
  final dynamic result;
  SuccessPatientNationalIdState(this.result);
}
class SuccessAddSessionState extends AddSessionStates{
  final dynamic result;
  SuccessAddSessionState(this.result);

}

class ErrorAddSessionState extends AddSessionStates{
  final String errorMessage;
  ErrorAddSessionState(this.errorMessage);
}
