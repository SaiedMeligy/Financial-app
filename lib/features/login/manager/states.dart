sealed class HomeStates{}

class LoginLoadingState extends HomeStates{}
class LoginSuccessState extends HomeStates{}
class LoginErrorState extends HomeStates{
  final String errorMessage;
  LoginErrorState(this.errorMessage);
}
