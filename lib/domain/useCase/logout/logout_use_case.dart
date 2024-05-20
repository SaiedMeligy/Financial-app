import 'package:dartz/dartz.dart';
import 'package:experts_app/core/Failure/failure.dart';
import 'package:experts_app/domain/repository/login/login_repository.dart';

import '../../repository/logout/logout_repository.dart';

class LogoutUseCase{
  final LogoutRepository logoutRepository;
  LogoutUseCase(this.logoutRepository);
  Future<Either<Failure,bool>> execute() async {
    return await logoutRepository.logout();
  }
}