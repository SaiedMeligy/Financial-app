
import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/SenarioModels.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';
import '../../../domain/entities/HomeAdminModel.dart';
import 'home_admin_senario_data_Source.dart';

class HomeAdminSenarioDataSourceImp implements HomeAdminSenarioDataSource{
  final Dio dio;
  HomeAdminSenarioDataSourceImp(this.dio);
  @override
  Future<Response> getHomeAdminSenario(SenarioModels homeAdmin) {
    return dio.get(
      "/api/home/senarios-report",
      options: Options(
        headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        },
      )
    );

  }

}