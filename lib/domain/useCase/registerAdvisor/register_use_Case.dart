
import 'package:dartz/dartz.dart';

import '../../../core/Failure/failure.dart';
import '../../entities/RegisterModel.dart';
import '../../repository/registerAdvisor/repository_register.dart';

class RegisterUseCase {
  final RepositoryRegister repositoryRegister;
  RegisterUseCase(this.repositoryRegister);
  Future<Either<Failure,bool>> execute(RegisterDataRequest data) async {

    return await repositoryRegister.register(data);
  }
}