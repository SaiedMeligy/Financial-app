

import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/SenarioModels.dart';

import '../../../core/Failure/server_failure.dart';
import '../../../domain/repository/homeAdminRepository/home_admin_Senario_repository.dart';
import '../../dataSource/homeAdminSenario/home_admin_senario_data_Source.dart';

class HomeAdminSenarioRepositoryImp implements HomeAdminSenarioRepository{
  final HomeAdminSenarioDataSource dataSource;
  HomeAdminSenarioRepositoryImp(this.dataSource);
  @override
  Future<Response> getHomeAdminSenario(SenarioModels homeAdminModel) async {
    try {
      final response = await dataSource.getHomeAdminSenario(
          homeAdminModel);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else {
          throw ServerFailure(statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "unKnown error"
          );
        }
      }
      else{
        throw ServerFailure(statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "unKnown error"
        );
      }
    }on DioException catch (dioException){
      throw ServerFailure(statusCode: dioException.response?.statusCode.toString()??"",
      message: dioException.response?.data["message"]?? "unKnown error");
    }
  }

}