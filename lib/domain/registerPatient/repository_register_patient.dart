import 'package:dartz/dartz.dart';


import '../../../core/Failure/failure.dart';
import '../entities/RegisterPatient.dart';

abstract class RepositoryRegisterPatient{

  Future<Either<Failure,bool>> register(RegisterPatientDataRequest data);
}