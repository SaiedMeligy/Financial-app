import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/patientNationalId/patient_nationalId_data_source.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';
import 'get_patient_details_data_source.dart';

class GetPatientDetailsDataSourceImp implements GetPatientDetailsDataSource{

  final Dio dio;
  GetPatientDetailsDataSourceImp(this.dio);

  @override
  Future<Response> getPatientDetails(String nationalId) async{
    return await dio.get(
      "/api/pationt/show",
      queryParameters: {
        "national_id": nationalId
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