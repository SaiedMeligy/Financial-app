import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import '../../../../../../core/config/cash_helper.dart';
import '../../../../../../core/config/constants.dart';
import 'delete_patient_admin_data_source.dart';

class DeletePatientWithAdminDataSourceImp implements DeletePatientWithAdminDataSource{
  final Dio dio;
  DeletePatientWithAdminDataSourceImp(this.dio);
  @override
  Future<Response> deletePatientWithAdmin(int id) async{
    return await dio.delete(
      "/api/pationt/destroy",
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