
import 'package:dartz/dartz.dart';

import '../../../../../core/Failure/failure.dart';
import '../../../../entities/RegisterPatient.dart';
import '../../../../repository/admin repository/patiens/registerPatientWithAdmin/repository_register_patient_admin.dart';


class RegisterPatientWithAdminUseCase {
  final RepositoryRegisterPatientWithAdmin repositoryRegisterPatientWithAdmin;
  RegisterPatientWithAdminUseCase(this.repositoryRegisterPatientWithAdmin);
  Future<Either<Failure,bool>> execute(RegisterPatientDataRequest data) async {

    return await repositoryRegisterPatientWithAdmin.registerWithAdmin(data);
  }
}