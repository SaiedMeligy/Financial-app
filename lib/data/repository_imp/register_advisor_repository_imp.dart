import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';


import '../../core/Failure/failure.dart';
import '../../core/Failure/server_failure.dart';
import '../../core/Services/snack_bar_service.dart';
import '../../domain/entities/RegisterModel.dart';
import '../../domain/repository/registerAdvisor/repository_register.dart';
import '../dataSource/registerAdvisor/register_data_source.dart';

class RegisterRepositoryImp implements RepositoryRegister{
  final RegisterDataSource registerDataSource;
  RegisterRepositoryImp(this.registerDataSource);
  @override
  Future<Either<Failure, bool>> register(RegisterDataRequest data) async{
    try {
      final response = await registerDataSource.register(data);
      if(response.statusCode ==200){
        if (response.data["status"] == true) {
          return const Right(true);
        }
        else{
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