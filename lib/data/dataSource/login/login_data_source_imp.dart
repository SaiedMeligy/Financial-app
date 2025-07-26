import 'package:dio/dio.dart';
import 'package:experts_app/core/config/constants.dart';

import 'login_data_source.dart';

class LoginDataSourceImp implements LoginDataSource {
  final Dio dio;
  LoginDataSourceImp(this.dio);
  @override
  Future<Response> login(String email, String password) async{
    try {
      final response = await dio.post(
        '/api/auth/login',
        data: FormData.fromMap({
          'email': email,
          'password': password,
        }),
        options: Options(
          headers: {
            "api-password": Constants.apiPassword,
          }
        ),
      );
      return response ;
    } on DioException catch (e) {
      print('====> Error: ${e.response?.data ?? e.message}');
      rethrow;
    }

  }
}
