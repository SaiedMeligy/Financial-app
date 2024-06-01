import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../core/Failure/server_failure.dart';
import '../../domain/updatePatient/update_patient_repository.dart';
import '../dataSource/allPatient/updatepatient/update_patient_data_source.dart';

class UpdatePatientRepositoryImp implements UpdatePatientRepository{
  final UpdatePatientDataSource dataSource;
  UpdatePatientRepositoryImp(this.dataSource);
  @override
  Future<Response> updatePatient(int id, Pationts patient) async {
    try {
      final response = await dataSource.updatePatient(id,patient);
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