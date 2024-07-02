import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';
import '../../../domain/entities/HomeAdminModel.dart';
import 'home_admin_data_Source.dart';

class HomeAdminDataSourceImp implements HomeAdminDataSource{
  final Dio dio;
  HomeAdminDataSourceImp(this.dio);
  @override
  Future<Response> getHomeAdmin(HomeAdminModel homeAdmin) {
    return dio.get(
      "/api/home",
      options: Options(
        headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        },
      )
    );

  }

}