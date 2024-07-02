
import '../../../../domain/entities/HomeAdminModel.dart';

abstract class HomeAdminStates {}

class LoadingHomeAdmin extends HomeAdminStates {}

class SuccessHomeAdmin extends HomeAdminStates {
  final HomeAdmin? home;
  SuccessHomeAdmin(this.home);
}

class ErrorHomeAdmin extends HomeAdminStates {
  final String errorMessage;
  ErrorHomeAdmin(this.errorMessage);
}
