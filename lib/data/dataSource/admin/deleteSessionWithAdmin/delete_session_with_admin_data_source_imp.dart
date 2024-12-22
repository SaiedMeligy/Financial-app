import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'delete_session_with_admin_data_source.dart';

class DeleteSessionWithAdminDataSourceImp implements DeleteSessionWithAdminDataSource{
  final Dio dio;
  DeleteSessionWithAdminDataSourceImp(this.dio);
  @override
  Future<Response> deleteSessionWithAdmin(int id) async{
    return await dio.delete(
      "/api/session/destroy",
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