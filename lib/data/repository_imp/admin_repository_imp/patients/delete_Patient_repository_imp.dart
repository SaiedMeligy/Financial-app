import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../../../domain/repository/admin repository/patiens/deletePatient/delete_patient_repository.dart';
import '../../../dataSource/admin/Patients/allPatientAdmin/deletePatient/delete_patient_admin_data_source.dart';



class DeletePatientWithAdminRepositoryImp implements DeletePatientWithAdminRepository {
  final DeletePatientWithAdminDataSource dataSource;

  DeletePatientWithAdminRepositoryImp(this.dataSource);

  @override
  Future<Response> deletePatientWithAdmin(int id) async {
    try {
      final response = await dataSource.deletePatientWithAdmin(id);
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