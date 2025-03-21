import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../core/Services/snack_bar_service.dart';
import '../../domain/repository/sessions/updateEvaluationSession/update_evaluation_session_repository.dart';
import '../dataSource/sessions/updateEvaluationSession/update_evaluation_session_data_source.dart';
import '../dataSource/sessions/updateSession/update_session_data_source.dart';

class UpdateEvaluationSessionRepositoryImp implements UpdateEvaluationSessionRepository {
  final UpdateEvaluationSessionDataSource dataSource;
  UpdateEvaluationSessionRepositoryImp(this.dataSource);

  @override
  Future<Response> updateEvaluationSession(int id , int evaluation) async {
    try {
      final response = await dataSource.updateEvaluationSession(id,evaluation);

      if (response.statusCode == 200) {
        SnackBarService.showSuccessMessage(response.data['message']);

        return response;
      } else {
        throw ServerFailure(
          message: 'Failed to update session: HTTP ${response.statusCode}',
          statusCode: response.statusCode.toString(),
        );
      }
    } on DioError catch (dioError) {
      if (dioError.response != null) {
        final errorMessage = dioError.response?.data["message"] ?? "unknown error";
        throw ServerFailure(
          message: errorMessage,
          statusCode: dioError.response?.statusCode.toString() ?? "",
        );
      } else {
        throw ServerFailure(
          message: 'Failed to update session: ${dioError.message}',
          statusCode: '',
        );
      }
    }
  }
}
