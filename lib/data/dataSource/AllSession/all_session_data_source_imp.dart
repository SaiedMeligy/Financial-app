import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'all_session_data_source.dart';
class AllSessionDataSourceImp implements AllSessionDataSource{
  final Dio dio;
  AllSessionDataSourceImp(this.dio);
  @override
  Future<Response> getAllSession(AllSessionModel sessionModel,{int page=1,int per_page=15,String searchQuery=''}) async{
    return await dio.get(
        "/api/advicor/session",
        queryParameters: {
          "page": page,
          "per_page": per_page,
          "searchQuery":searchQuery
        },
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}