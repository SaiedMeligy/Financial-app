import 'package:dartz/dartz.dart';
import 'package:experts_app/core/Failure/failure.dart';

abstract class LoginPatientRepository{
  Future<Either<Failure,bool>> login(String nationalId);

}