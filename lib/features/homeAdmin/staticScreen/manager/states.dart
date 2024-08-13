
import 'package:experts_app/domain/entities/SenarioModels.dart';

import '../../../../domain/entities/HomeAdminModel.dart';


abstract class HomeAdminStates {}

class LoadingHomeAdmin extends HomeAdminStates {}
class LoadingHomeAdminSenario extends HomeAdminStates {}

class SuccessHomeAdmin extends HomeAdminStates {
  final HomeAdmin? home;
  SuccessHomeAdmin(this.home);
}
class SuccessHomeAdminSenario extends HomeAdminStates {
  final Home? senario;
  SuccessHomeAdminSenario(this.senario);
}

class ErrorHomeAdmin extends HomeAdminStates {
  final String errorMessage;
  ErrorHomeAdmin(this.errorMessage);
}
