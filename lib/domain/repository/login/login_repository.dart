import 'package:dartz/dartz.dart';
import 'package:experts_app/core/Failure/failure.dart';

abstract class LoginRepository{
  Future<Either<Failure,bool>> login(String email,String password);

}