import 'package:experts_app/domain/entities/AllPatientModel.dart';

abstract class AllPatientRecycleStates {}

class LoadingAllPatientRecycle extends AllPatientRecycleStates {}

class SuccessAllPatientRecycle extends AllPatientRecycleStates {
  final List<Pationts> patients;
  SuccessAllPatientRecycle(this.patients);
}

class ErrorAllPatientRecycle extends AllPatientRecycleStates {
  final String errorMessage;
  ErrorAllPatientRecycle(this.errorMessage);
}
