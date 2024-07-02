import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../../../domain/repository/admin repository/ConsultationServicesAdmin/deleteConsultation/delete_consultation_admin_repository.dart';
import '../../../dataSource/admin/ConsultationServicesAdmin/deleteConsultation/Consultation_delete_Admin_data_source.dart';

class DeleteConsultationAdminRepositoryImp implements DeleteConsultationAdminRepository {
  final DeleteConsultationAdminDataSource dataSource;

  DeleteConsultationAdminRepositoryImp(this.dataSource);

  @override
  Future<Response> deleteConsultationAdmin(int id) async {
    try {
      final response = await dataSource.deleteConsultationAdmin(id);
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
