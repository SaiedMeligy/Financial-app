import 'package:dio/dio.dart';

import 'package:experts_app/data/dataSource/registerPationt/register_pationt_data_source.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';
import '../../../domain/entities/RegisterPatient.dart';

class RegisterPatientDatasourceImp implements RegisterPatientDataSource{
  final Dio dio;
  RegisterPatientDatasourceImp({required this.dio});
  @override
  Future<Response> register(RegisterPatientDataRequest data) async {
    return await dio.post(
      "/api/advicor/pationt",
      data: {
        "name": data.name,
        "national_id":data.nationalId,
        "phone_number":data.phoneNumber,
        "email":data.email,
        "password":data.password,
      },
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token":CacheHelper.getData(key: "token")
          }
      ),

    );
  }
}