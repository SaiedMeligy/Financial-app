
import 'package:dio/dio.dart';

import '../../../core/Failure/server_failure.dart';
import '../../../domain/entities/HomeAdminModel.dart';
import '../../../domain/repository/homeAdminRepository/home_admin_repository.dart';
import '../../dataSource/homeAdmin/home_admin_data_Source.dart';

class HomeAdminRepositoryImp implements HomeAdminRepository{
  final HomeAdminDataSource dataSource;
  HomeAdminRepositoryImp(this.dataSource);
  @override
  Future<Response> getHomeAdmin(HomeAdminModel homeAdminModel) async {
    try {
      final response = await dataSource.getHomeAdmin(
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