abstract class LogoutStates{}
class LoadingLogoutState extends LogoutStates{}
class SuccessLogoutState extends LogoutStates{}
class ErrorLogoutState extends LogoutStates{
  final String errorMessage;
  ErrorLogoutState(this.errorMessage);
}