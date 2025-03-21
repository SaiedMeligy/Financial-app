import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/core/Services/snack_bar_service.dart';

import '../../domain/repository/sessions/deleteEvaluationSession/delete_evaluation_session_repository.dart';
import '../dataSource/sessions/deleteEvaluationSession/delete_evaluation_session_data_source.dart';



class DeleteEvaluationSessionRepositoryImp implements DeleteEvaluationSessionRepository {
  final DeleteEvaluationSessionDataSource dataSource;

  DeleteEvaluationSessionRepositoryImp(this.dataSource);

  @override
  Future<Response> deleteEvaluationSession(int id) async {
    try {
      final response = await dataSource.deleteEvaluationSession(id);
      if (response.statusCode == 200) {
        if (response.data["success"] == true) {
          SnackBarService.showSuccessMessage(response.data["message"]);
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
