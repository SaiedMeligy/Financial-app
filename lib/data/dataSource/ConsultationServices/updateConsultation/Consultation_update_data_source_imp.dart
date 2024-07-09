import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'Consultation_update_data_source.dart';

class UpdateConsultationDataSourceImp implements UpdateConsultationDataSource{
  final Dio dio;
  UpdateConsultationDataSourceImp(this.dio);
  @override
  Future<Response> updateConsultation(int id,String name,String description) async{
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