import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'delete_patient_from_system_data_source.dart';

class DeletePatientFromSystemDataSourceImp implements DeletePatientFromSystemDataSource{
  final Dio dio;
  DeletePatientFromSystemDataSourceImp(this.dio);
  @override
  Future<Response> deletePatient(int id) async{
    return await dio.delete(
      //
      "/api/advicor/pationt/destroy",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      queryParameters: {
        "id":id,
      }
      );


  }

}