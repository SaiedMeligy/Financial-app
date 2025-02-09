import 'package:dio/dio.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'delete_question_form_data_source.dart';

class DeleteQuestionFormDataSourceImp implements DeleteQuestionFormDataSource{
  final Dio dio;
  DeleteQuestionFormDataSourceImp(this.dio);
  Future<Response> deleteQuestionFromForm(int questionId, int formId, bool isAdvisor) async {
    String? token = CacheHelper.getData(key: "token");

    if (token == null || token.isEmpty) {
      throw Exception("User is not authenticated.");
    }

    try {
      final response = await dio.post(
        isAdvisor ? "/api/advicor/remove_answer" : "/api/remove_answer",
        options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": token, // Check if this matches Postman
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
        queryParameters: {
          "question_id": questionId,
          "form_id": formId,
        },
      );
      return response;
    } catch (error) {
      throw Exception("Failed to delete question.");
    }
  }

}