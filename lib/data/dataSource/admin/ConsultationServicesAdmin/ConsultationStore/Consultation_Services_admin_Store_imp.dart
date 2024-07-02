import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';

import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';
import 'Consultation_Services_Admin_Store.dart';

class ConsultationStoreAdminDataSourceImp implements ConsultationStoreAdminDataSource{
  final Dio dio;
  ConsultationStoreAdminDataSourceImp(this.dio);
  @override
  Future<Response> addConsultationStoreAdmin(ConsultationStore consultationStore) async{
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