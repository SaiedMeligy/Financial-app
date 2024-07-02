import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../../../domain/repository/admin repository/ConsultationServicesAdmin/updateConsultation/update_consultation_admin_repository.dart';
import '../../../dataSource/admin/ConsultationServicesAdmin/updateConsultation/Consultation_update_admin_data_source.dart';

class UpdateConsultationAdminRepositoryImp implements UpdateConsultationAdminRepository {
  final UpdateConsultationAdminDataSource dataSource;

  UpdateConsultationAdminRepositoryImp(this.dataSource);

  @override
  Future<Response> updateConsultationAdmin(int id,String name,String description) async {
    try {
      final response = await dataSource.updateConsultationAdmin(id,name,description);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else {
          throw ServerFailure(
            statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "Unknown error",
          );
        }
      }
      else {
        throw ServerFailure(
          statusCode: response.statusCode.toString(),
          message: "Unexpected status code: ${response.statusCode}",
        );
      }
    } on DioException catch (dioException) {
        throw ServerFailure(
          statusCode: dioException.response?.statusCode.toString() ?? "",
          message: dioException.response?.data["message"] ?? "Not found",
        );
      }

  }
}
