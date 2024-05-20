import 'package:dartz/dartz.dart';
import 'package:experts_app/core/Failure/failure.dart';
import 'package:experts_app/domain/repository/login/login_repository.dart';

class LoginUseCase{
  final LoginRepository loginRepository;
  LoginUseCase(this.loginRepository);
  Future<Either<Failure,bool>> execute(String email, String password) async {
    return await loginRepository.login(email, password);
  }
}