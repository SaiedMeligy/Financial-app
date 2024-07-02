import 'package:dio/dio.dart';
import 'package:experts_app/data/dataSource/ConsultationServices/AllConsultation/all_consultation_data_source.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';
import 'all_consultation_admin_data_source.dart';


class AllConsultationAdminDataSourceImp implements AllConsultationAdminDataSource{
  final Dio dio;
  AllConsultationAdminDataSourceImp(this.dio);
  @override
  Future<Response> getAllConsultationAdmin(ConsultationModel consultationViewModel) async{
    return await dio.get(
        "/api/ConsultationServices",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}