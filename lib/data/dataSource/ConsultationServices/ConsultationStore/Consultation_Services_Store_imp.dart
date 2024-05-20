import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'Consultation_Services_Store.dart';

class ConsultationStoreDataSourceImp implements ConsultationStoreDataSource{
  final Dio dio;
  ConsultationStoreDataSourceImp(this.dio);
  @override
  Future<Response> addConsultationStore(ConsultationStore consultationStore) async{
    return await dio.post(
      "/api/ConsultationServices",
      data: {
        "name":consultationStore.name,
        "description":consultationStore.description
      },
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          }
      ),

      );


  }

}