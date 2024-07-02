import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';
import '../../../../../domain/entities/AllPatientModel.dart';
import 'all_patients_admin_data_source.dart';

class AllPatientWithAdminDataSourceImp implements AllPatientsWithAdminDataSource{
  final Dio dio;
  AllPatientWithAdminDataSourceImp(this.dio);
  @override
  Future<Response> getAllPatientsWithAdmin(AllPatientModel patientModel) async{
    return await dio.get(
        "/api/pationt",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}