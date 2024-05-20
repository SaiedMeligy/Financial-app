import 'package:dartz/dartz.dart';


import '../../../core/Failure/failure.dart';
import '../../entities/RegisterModel.dart';

abstract class RepositoryRegister{

  Future<Either<Failure,bool>> register(RegisterDataRequest data);
}