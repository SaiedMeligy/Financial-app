import 'package:experts_app/domain/entities/HomeAdvisorModel.dart';

abstract class HomeAdvisorStates {}

class LoadingHomeAdvisor extends HomeAdvisorStates {}

class SuccessHomeAdvisor extends HomeAdvisorStates {
  final Home? home;
  SuccessHomeAdvisor(this.home);
}

class ErrorHomeAdvisor extends HomeAdvisorStates {
  final String errorMessage;
  ErrorHomeAdvisor(this.errorMessage);
}
