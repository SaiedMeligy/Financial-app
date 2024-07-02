import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'all_session_data_source.dart';
class AllSessionDataSourceImp implements AllSessionDataSource{
  final Dio dio;
  AllSessionDataSourceImp(this.dio);
  @override
  Future<Response> getAllSession(AllSessionModel sessionModel) async{
    return await dio.get(
        "/api/advicor/session",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}