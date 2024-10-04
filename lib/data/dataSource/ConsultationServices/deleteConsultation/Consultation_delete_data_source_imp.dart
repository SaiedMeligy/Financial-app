import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'Consultation_delete_data_source.dart';

class DeleteConsultationDataSourceImp implements DeleteConsultationDataSource{
  final Dio dio;
  DeleteConsultationDataSourceImp(this.dio);
  @override
  Future<Response> deleteConsultation(int id) async{
    return await dio.delete(
      "/api/ConsultationServices/destroy",
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