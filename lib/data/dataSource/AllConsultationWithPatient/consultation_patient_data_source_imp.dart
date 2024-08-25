import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';
import 'all_consultation_patient_data_source.dart';


class AllConsultationPatientDataSourceImp implements AllConsultationPatientDataSource{
  final Dio dio;
  AllConsultationPatientDataSourceImp(this.dio);
  @override
  Future<Response> getAllConsultationPatient(ConsultationModel consultationViewModel) async{
    return await dio.get(
        "/api/view-all-consultation-services",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}