import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/repository/Question/deleteQuestion/delete_question_repository.dart';
import '../dataSource/question/deleteQuestion/delete_question_data_source.dart';


class DeleteQuestionRepositoryImp implements DeleteQuestionRepository {
  final DeleteQuestionDataSource dataSource;

  DeleteQuestionRepositoryImp(this.dataSource);

  @override
  Future<Response> deleteQuestion(int id) async {
    try {
      final response = await dataSource.deleteQuestion(id);
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
