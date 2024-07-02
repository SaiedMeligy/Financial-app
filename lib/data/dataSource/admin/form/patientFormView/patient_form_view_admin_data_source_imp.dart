import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/admin/form/patientFormView/patient_form_view_admin_data_source.dart';

import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';

class PatientFormViewWithAdminDataSourceImp implements PatientFormViewWithAdminDataSource{

  final Dio dio;
  PatientFormViewWithAdminDataSourceImp(this.dio);

  @override
  Future<Response> getPatientFormWithAdmin(int patientId) async{
    return await dio.get(
      "/api/find-form",
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