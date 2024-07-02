import 'package:dio/dio.dart';
import 'package:experts_app/data/dataSource/admin/Patients/registerPationtAdmin/register_pationt_admin_data_source.dart';

import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';
import '../../../../../domain/entities/RegisterPatient.dart';


class RegisterPatientWithAdminDatasourceImp implements RegisterPatientWithAdminDataSource{
  final Dio dio;
  RegisterPatientWithAdminDatasourceImp({required this.dio});
  @override
  Future<Response> registerWithAdmin(RegisterPatientDataRequest data) async {
    return await dio.post(
      "/api/pationt",
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