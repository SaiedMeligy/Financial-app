import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';
import '../../../../../../core/config/cash_helper.dart';
import '../../../../../../core/config/constants.dart';
import 'update_patient_data_source.dart';

class UpdatePatientWithAdminDataSourceImp implements UpdatePatientWithAdminDataSource{
  final Dio dio;
  UpdatePatientWithAdminDataSourceImp(this.dio);
  @override
  Future<Response> updatePatientWithAdmin(int id,Pationts patient) async{
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
      },
      data: {
        "name":patient.name,
        "email":patient.email,
        "phone_number":patient.phoneNumber,
        "national_id":patient.nationalId,


    }

      );


  }

}