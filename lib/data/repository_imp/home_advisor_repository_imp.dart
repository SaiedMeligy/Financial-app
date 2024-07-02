
import 'package:dio/dio.dart';

import '../../core/Failure/server_failure.dart';
import '../../domain/entities/HomeAdvisorModel.dart';
import '../../domain/repository/homeAdvisorRepository/home_advisor_repository.dart';
import '../dataSource/homeAdvisor/home_advisor_data_Source.dart';

class HomeAdvisorRepositoryImp implements HomeAdvisorRepository{
  final HomeAdvisorDataSource dataSource;
  HomeAdvisorRepositoryImp(this.dataSource);
  @override
  Future<Response> getHomeAdvisor(HomeAdvisorModel homeAdvisorModel) async {
    try {
      final response = await dataSource.getHomeAdvisor(
          homeAdvisorModel);
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