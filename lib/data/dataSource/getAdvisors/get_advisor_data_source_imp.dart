import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/domain/entities/AllAdvisorsModel.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'all_advisor_data_source.dart';

class AllAdvisorDataSourceImp implements AllAdvisorDataSource{
  final Dio dio;
  AllAdvisorDataSourceImp(this.dio);
  @override
  Future<Response> getAllAdvisor(AllAdvisorsModel advisorModel) async{
    return await dio.get(
        "/api/adviser",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}