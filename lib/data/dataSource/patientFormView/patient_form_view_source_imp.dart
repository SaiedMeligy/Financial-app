import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/patientFormView/patient_form_view_data_source.dart';
import 'package:experts_app/data/dataSource/patientNationalId/patient_nationalId_data_source.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';

class PatientFormViewDataSourceImp implements PatientFormViewDataSource{

  final Dio dio;
  PatientFormViewDataSourceImp(this.dio);

  @override
  Future<Response> getPatientForm(int patientId) async{
    return await dio.get(
      "/api/advicor/find-form",
      queryParameters: {
        "pationt_id": patientId
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