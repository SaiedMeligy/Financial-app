import 'package:dio/dio.dart';
import 'package:experts_app/core/config/constants.dart';

import 'login_data_source.dart';

class LoginDataSourceImp implements LoginDataSource {
  final Dio dio;
  LoginDataSourceImp(this.dio);
  @override
  Future<Response> login(String email, String password) async{
    try {
      return await dio.post(
        '/api/auth/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
            }
        ),
      );
    } on DioError catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }

  }
}
