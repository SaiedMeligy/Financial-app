import 'package:dio/dio.dart';

import 'package:experts_app/data/dataSource/registerAdvisor/register_data_source.dart';

import '../../../core/config/constants.dart';
import '../../../domain/entities/RegisterModel.dart';

class RegisterDatasourceImp implements RegisterDataSource{
  final Dio dio;
  RegisterDatasourceImp({required this.dio});
  @override
  Future<Response> register(RegisterDataRequest data) async {
    return await dio.post(
      "/api/auth/register",
      data: {
        "name": data.name,
        "email":data.email,
        "password":data.password,
        "phone_number":data.phoneNumber,
        "rule":data.rule,
      },
      options: Options(
          headers: {
            "api-password": Constants.apiPassword
          }
      ),

    );
  }
}