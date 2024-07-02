import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../../../domain/entities/ConsultationViewModel.dart';
import '../../../../domain/repository/admin repository/ConsultationServicesAdmin/AllConsultations/all_consultation_admin_repository.dart';
import '../../../dataSource/admin/ConsultationServicesAdmin/AllConsultation/all_consultation_admin_data_source.dart';

class AllConsultationAdminRepositoryImp implements AllConsultationAdminRepository{
  final AllConsultationAdminDataSource dataSource;
  AllConsultationAdminRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllConsultationAdmin(ConsultationModel consultationViewModel) async {
    try {
      final response = await dataSource.getAllConsultationAdmin(
          consultationViewModel);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else {
          throw ServerFailure(statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "unKnown error"
          );
        }
      }
      else{
        throw ServerFailure(statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "unKnown error"
        );
      }
    }on DioException catch (dioException){
      throw ServerFailure(statusCode: dioException.response?.statusCode.toString()??"",
      message: dioException.response?.data["message"]?? "unKnown error");
    }
  }

}