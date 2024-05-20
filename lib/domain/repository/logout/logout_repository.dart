import 'package:dartz/dartz.dart';
import 'package:experts_app/core/Failure/failure.dart';

abstract class LogoutRepository{
  Future<Either<Failure,bool>> logout();

}