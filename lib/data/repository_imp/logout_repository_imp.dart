import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/failure.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import '../../core/Services/snack_bar_service.dart';

import '../../domain/repository/logout/logout_repository.dart';
import '../dataSource/logout/logout_data_source.dart';

class LogoutRepositoryImp implements LogoutRepository {

final LogoutDataSource logoutDataSource;

LogoutRepositoryImp(this.logoutDataSource);
  @override
  Future<Either<Failure, bool>> logout() async{
    try {
      final response = await logoutDataSource.logout();
      if (response.statusCode == 200) {
        if(response.data["status"]==true){
          return Right(true);
        }
        else{
          SnackBarService.showErrorMessage(response.data["message"]);
          return Left(ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["message"],

          ));
        }

      }
      else {
        SnackBarService.showErrorMessage(response.data["message"]);
        return Left(ServerFailure(
          statusCode:response.statusCode.toString() ,
          message: response.data["message"],
        ));
      }
    } on DioException catch (dioException){
      SnackBarService.showErrorMessage(dioException.response?.data["message"]);
      return Left(ServerFailure(
          statusCode:dioException.response?.statusCode.toString()??"" ,
          message:dioException.response?.data["message"]?? "An unexpected error occurred"
      ));
    }

  }
}