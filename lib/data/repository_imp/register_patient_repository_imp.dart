import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


import '../../core/Failure/failure.dart';
import '../../core/Failure/server_failure.dart';
import '../../core/Services/snack_bar_service.dart';
import '../../domain/entities/RegisterModel.dart';
import '../../domain/entities/RegisterPatient.dart';
import '../../domain/registerPatient/repository_register_patient.dart';
import '../../domain/repository/registerAdvisor/repository_register.dart';
import '../dataSource/registerAdvisor/register_data_source.dart';
import '../dataSource/registerPationt/register_pationt_data_source.dart';

class RegisterPatientRepositoryImp implements RepositoryRegisterPatient{
  final RegisterPatientDataSource registerDataSource;
  RegisterPatientRepositoryImp(this.registerDataSource);
  @override
  Future<Either<Failure, bool>> register(RegisterPatientDataRequest data) async{
    try {
      final response = await registerDataSource.register(data);
      if(response.statusCode ==200){
        if (response.data["status"] == true) {
          SnackBarService.showSuccessMessage(response.data["message"]);

          return Right(true);
        }
        else{
          print("data false");
          SnackBarService.showErrorMessage(response.data["message"]);
          return Left(ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["message"],

          ));
        }


      }

      else{
        return Left(ServerFailure(
          statusCode: response.statusCode.toString(),
          message: response.data["message"],
        ));
      }
    }on DioException catch (error){
      return Left(ServerFailure(
        statusCode: error.response?.statusCode.toString()??"",
        message: error.response?.data["message"],
      ));
    }
  }

}