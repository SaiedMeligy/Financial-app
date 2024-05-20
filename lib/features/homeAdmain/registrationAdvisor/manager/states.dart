sealed class RegisterState{}
class LoadingRegisterState extends RegisterState{}
class SuccessRegisterState extends RegisterState{}
class ErrorRegisterState extends RegisterState{
  final String errorMessage;
  ErrorRegisterState(this.errorMessage);
}
