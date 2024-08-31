import 'package:dartz/dartz.dart';
import 'package:experts_app/core/Failure/failure.dart';

import '../../repository/loginPatient/login_patient_repository.dart';

class LoginPatientUseCase{
  final LoginPatientRepository loginPatientRepository;
  LoginPatientUseCase(this.loginPatientRepository);
  Future<Either<Failure,bool>> execute(String nationalId) async {
    return await loginPatientRepository.login(nationalId);
  }
}