import 'package:dio/dio.dart';
import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';
import 'Consultation_update_admin_data_source.dart';

class UpdateConsultationAdminDataSourceImp implements UpdateConsultationAdminDataSource{
  final Dio dio;
  UpdateConsultationAdminDataSourceImp(this.dio);
  @override
  Future<Response> updateConsultationAdmin(int id,String name,String description) async{
    return await dio.patch(
      "/api/ConsultationServices/update",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      queryParameters: {
        "id":id,
        "name":name,
        "description":description,
      }

      );


  }

}