import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/patientNationalId/patient_nationalId_data_source.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';

class PatientNationalIdDataSourceImp implements PatientNationalIdDataSource{

  final Dio dio;
  PatientNationalIdDataSourceImp(this.dio);

  @override
  Future<Response> getNationalId(String nationalId) async{
    return await dio.get(
      "/api/advicor/pationt/show",
      queryParameters: {
        "national_id": nationalId,

      },
      options: Options(
        headers: {
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        }
      )

    );

  }

}