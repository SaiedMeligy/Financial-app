import 'package:dio/dio.dart';
import 'package:experts_app/core/config/constants.dart';

import 'login_patient_data_source.dart';


class LoginPatientDataSourceImp implements LoginPatientDataSource {
  final Dio dio;
  LoginPatientDataSourceImp(this.dio);
  @override
  Future<Response> login( String nationalId) async{
    try {
      return await dio.post(
        '/api/auth/pationt-login',
        data: {
          'national_id': nationalId,
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
