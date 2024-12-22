import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'delete_session_data_source.dart';

class DeleteSessionDataSourceImp implements DeleteSessionDataSource{
  final Dio dio;
  DeleteSessionDataSourceImp(this.dio);
  @override
  Future<Response> deleteSession(int id) async{
    return await dio.delete(
      "/api/advicor/session/destroy",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      queryParameters: {
        "id":id,
      }
      );


  }

}