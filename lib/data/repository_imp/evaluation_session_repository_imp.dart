import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/sessions/evaluationSession/evaluation_session_data_source.dart';
import 'package:experts_app/domain/repository/sessions/evaluationSession/evaluation_session_repo.dart';

import '../../core/Failure/server_failure.dart';

class EvaluationSessionRepositoryImp implements EvaluationSessionRepository{
  final EvaluationSessionDataSource dataSource;

  EvaluationSessionRepositoryImp(this.dataSource);
  @override
  Future<Response> evaluationSession(int? sessionId,int? formId) async {
    try {
      final response = await dataSource.evaluationSession(sessionId,formId);
      if (response.statusCode == 200) {
        if (response.data["success"] == true) {
          return response;
        }
        else {
          throw ServerFailure(
            message: response.data["message"] ?? "unknown error",
            statusCode: response.data["status"].toString(),);
        }
      }
      else {
        throw ServerFailure(
          message: response.data["message"] ?? "unknown error",
          statusCode: response.data["status"].toString(),);
      }
    } on DioException catch (dioException) {
      throw ServerFailure(
        message: dioException.response?.data["message"]?? "unknown error",
        statusCode: dioException.response?.statusCode.toString()??"",
      );

    }
  }

}