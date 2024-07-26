import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:experts_app/main.dart';
import '../../core/config/cash_helper.dart';
import '../../core/Services/snack_bar_service.dart';
import 'package:experts_app/core/Failure/failure.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/config/page_route_name.dart';
import 'package:experts_app/data/dataSource/login/login_data_source.dart';
import 'package:experts_app/domain/repository/login/login_repository.dart';


class LoginRepositoryImp implements LoginRepository {

final LoginDataSource loginDataSource;

LoginRepositoryImp(this.loginDataSource);
  @override
  Future<Either<Failure, bool>> login(String email, String password) async{
    try {
      final response = await loginDataSource.login(email, password);
      if (response.statusCode == 200) {
        if(response.data["status"]==true){
          print("data true");
          print(response.data["user"]["token"]);
          CacheHelper.saveData(key: "token", value: response.data["user"]["token"]);
          CacheHelper.saveData(key: "email", value: response.data["user"]["email"]);
          CacheHelper.saveData(key: "name", value: response.data["user"]["name"]);
          CacheHelper.saveData(key: "id", value: response.data["user"]["id"]);

          if(response.data["user"]["rule"]==0){
            navigatorKey.currentState!.pushReplacementNamed(PageRouteName.homeAdvisor);
          }
          else if(response.data["user"]["rule"]==1){
            navigatorKey.currentState!.pushReplacementNamed(PageRouteName.homeAdmin);
          }
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