import 'package:dartz/dartz.dart';

import '../../../../../core/Failure/failure.dart';
import '../../../../entities/RegisterPatient.dart';



abstract class RepositoryRegisterPatientWithAdmin{

  Future<Either<Failure,bool>> registerWithAdmin(RegisterPatientDataRequest data);
}