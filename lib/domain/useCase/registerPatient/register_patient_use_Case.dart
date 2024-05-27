
import 'package:dartz/dartz.dart';

import '../../../core/Failure/failure.dart';
import '../../entities/RegisterModel.dart';
import '../../entities/RegisterPatient.dart';
import '../../registerPatient/repository_register_patient.dart';
import '../../repository/registerAdvisor/repository_register.dart';

class RegisterPatientUseCase {
  final RepositoryRegisterPatient repositoryRegisterPatient;
  RegisterPatientUseCase(this.repositoryRegisterPatient);
  Future<Either<Failure,bool>> execute(RegisterPatientDataRequest data) async {

    return await repositoryRegisterPatient.register(data);
  }
}