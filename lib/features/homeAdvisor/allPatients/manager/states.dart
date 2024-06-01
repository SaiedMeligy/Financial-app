import 'package:experts_app/domain/entities/AllPatientModel.dart';

abstract class AllPatientStates {}

class LoadingAllPatient extends AllPatientStates {}

class SuccessAllPatient extends AllPatientStates {
  final List<Pationts> patients;
  SuccessAllPatient(this.patients);
}

class ErrorAllPatient extends AllPatientStates {
  final String errorMessage;
  ErrorAllPatient(this.errorMessage);
}
