abstract class AddPointerStates {}
class LoadingAddPointerStates extends AddPointerStates{}
class SuccessAddPointerStates extends AddPointerStates{}
class ErrorAddPointerStates extends AddPointerStates{
  final String errorMessage;
  ErrorAddPointerStates(this.errorMessage);
}
