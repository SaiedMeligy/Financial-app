import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'all_session_with_admin_data_source.dart';
class AllSessionWithAdminDataSourceImp implements AllSessionWithAdminDataSource{
  final Dio dio;
  AllSessionWithAdminDataSourceImp(this.dio);
  @override
  Future<Response> getAllSessionWithAdmin(AllSessionModel sessionModel,{int page=1,int per_page=15}) async{
    return await dio.get(
        "/api/session",
        queryParameters: {
          "page":page,
          "per_page":per_page
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