import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/ConsultationServices/AllConsultation/all_consultation_data_source.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';

class AllConsultationDataSourceImp implements AllConsultationDataSource{
  final Dio dio;
  AllConsultationDataSourceImp(this.dio);
  @override
  Future<Response> getAllConsultation(ConsultationModel consultationViewModel) async{
    return await dio.get(
        "/api/advicor/ConsultationServices",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}