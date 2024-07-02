import 'package:experts_app/domain/entities/AllPatientModel.dart';

abstract class AllPatientWithAdminStates {}

class LoadingAllPatientWithAdmin extends AllPatientWithAdminStates {}

class SuccessAllPatientWithAdmin extends AllPatientWithAdminStates {
  final List<Pationts> patients;
  SuccessAllPatientWithAdmin(this.patients);
}

class ErrorAllPatientWithAdmin extends AllPatientWithAdminStates {
  final String errorMessage;
  ErrorAllPatientWithAdmin(this.errorMessage);
}
