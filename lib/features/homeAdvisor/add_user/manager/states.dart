sealed class RegisterPatientState{}
class LoadingRegisterPatientState extends RegisterPatientState{}
class SuccessRegisterPatientState extends RegisterPatientState{}
class ErrorRegisterPatientState extends RegisterPatientState{
  final String errorMessage;
  ErrorRegisterPatientState(this.errorMessage);
}
