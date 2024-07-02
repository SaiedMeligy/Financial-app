import 'package:dio/dio.dart';
import 'package:experts_app/domain/repository/admin%20repository/patiens/replacePatient/replace_patient_repository.dart';

import '../../../core/Failure/server_failure.dart';
import '../../dataSource/admin/Patients/allPatientAdmin/Replacepatient/replace_patient_data_source.dart';


class ReplacePatientRepositoryImp implements ReplacePatientWithAdminRepository{
  final ReplacePatientWithAdminDataSource dataSource; ReplacePatientRepositoryImp(this.dataSource);
  @override
  Future<Response> replacePatientWithAdmin(int id, int advisorId) async {
    try {
      final response = await dataSource.replacePatientWithAdmin(id,advisorId);
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