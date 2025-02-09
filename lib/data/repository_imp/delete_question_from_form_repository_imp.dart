import 'package:dio/dio.dart';
import 'package:experts_app/core/Failure/server_failure.dart';

import '../../domain/repository/Question/deleteQuestion/delete_question_repository.dart';
import '../../domain/repository/deleteQuestionFromForm/delete_question_from_form_repository.dart';
import '../dataSource/deleteQuestionFromForm/delete_question_form_data_source.dart';
import '../dataSource/question/deleteQuestion/delete_question_data_source.dart';


class DeleteQuestionFromFormRepositoryImp implements DeleteQuestionFromFormRepository {
  final DeleteQuestionFormDataSource dataSource;

  DeleteQuestionFromFormRepositoryImp(this.dataSource);

  @override
  Future<Response> deleteQuestionFromForm(int questionId,int formId,bool isAdvisor) async {
    try {
      final response = await dataSource.deleteQuestionFromForm(questionId,formId,isAdvisor);
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
