abstract class AddServiceStates{}
class LoadingAddService extends AddServiceStates{}
class SuccessAddService extends AddServiceStates{}
class SuccessLoginStates extends AddServiceStates{}
class LoadingLoginStates extends AddServiceStates{}
class ErrorLogin extends AddServiceStates{
   final String error;
   ErrorLogin(this.error);
}
class ErrorAddService extends AddServiceStates{
  final String errorMessage;
  ErrorAddService(this.errorMessage);
}