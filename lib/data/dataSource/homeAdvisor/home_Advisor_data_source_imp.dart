import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/homeAdvisor/home_advisor_data_Source.dart';
import 'package:experts_app/domain/entities/HomeAdvisorModel.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';

class HomeAdvisorDataSourceImp implements HomeAdvisorDataSource{
  final Dio dio;
  HomeAdvisorDataSourceImp(this.dio);
  @override
  Future<Response> getHomeAdvisor(HomeAdvisorModel homeAdvisor) {
    return dio.get(
      "/api/advicor/home",
      options: Options(
        headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        },
      )
    );

  }

}