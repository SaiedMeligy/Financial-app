import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../../core/config/cash_helper.dart';
import '../../core/Services/snack_bar_service.dart';
import 'package:experts_app/core/Failure/failure.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import '../../domain/repository/loginPatient/login_patient_repository.dart';
import '../dataSource/loginPatient/login_patient_data_source.dart';


class LoginPatientRepositoryImp implements LoginPatientRepository {

final LoginPatientDataSource loginDataSource;

LoginPatientRepositoryImp(this.loginDataSource);
  @override
  Future<Either<Failure, bool>> login(String nationalId) async{
    try {
      final response = await loginDataSource.login(nationalId);
      if (response.statusCode == 200) {
        if(response.data["status"]==true){
          print("data true");
          CacheHelper.clearAllData();
          CacheHelper.saveData(key: "email", value: response.data["pationt"]["email"]);
          CacheHelper.saveData(key: "name", value: response.data["pationt"]["name"]);
          CacheHelper.saveData(key: "id", value: response.data["pationt"]["id"]);
          CacheHelper.saveData(key: "national_id", value: response.data["pationt"]["national_id"]);
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