import 'package:dio/dio.dart';
import 'package:experts_app/core/config/constants.dart';

import '../../../core/config/cash_helper.dart';
import 'logout_data_source.dart';

class LogoutDataSourceImp implements LogoutDataSource {
  final Dio dio;
  LogoutDataSourceImp(this.dio);
  @override
  Future<Response> logout() async{
    try {
      return await dio.post(
        '/api/auth/logout',
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token":CacheHelper.getData(key: "token")
            }
        ),
      );
    } on DioError catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }

  }
}
