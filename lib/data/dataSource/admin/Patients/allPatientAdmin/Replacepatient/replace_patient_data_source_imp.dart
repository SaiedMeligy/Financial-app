import 'package:dio/dio.dart';
import '../../../../../../core/config/cash_helper.dart';
import '../../../../../../core/config/constants.dart';
import 'replace_patient_data_source.dart';

class ReplacePatientWithAdminDataSourceImp implements ReplacePatientWithAdminDataSource{
  final Dio dio;
  ReplacePatientWithAdminDataSourceImp(this.dio);
  @override
  Future<Response> replacePatientWithAdmin(int id,int advisorId) async{
    return await dio.patch(
      "/api/pationt/update",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      queryParameters: {
        "id":id,
        "advicor_id":advisorId
      },

      );


  }

}