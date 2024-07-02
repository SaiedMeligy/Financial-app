
import 'package:dio/dio.dart';

import '../../core/Failure/server_failure.dart';
import '../../domain/repository/Question/updateQuestion/update_question_repository.dart';
import '../dataSource/question/updateQuestion/update_form_data_source.dart';

class UpdateQuestionRepositoryImp implements UpdateQuestionRepository{
  final UpdateQuestionDataSource dataSource;
  UpdateQuestionRepositoryImp(this.dataSource);
  @override
  Future<Response> updateQuestion(Map<String,dynamic> dataRequest) async {
    try {
      final response = await dataSource.updateQuestion(dataRequest);
      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
          return response;
        }
        else {
          throw ServerFailure(statusCode: response.statusCode.toString(),
              message: response.data["message"] ?? "unKnown error"
          );
        }
      }
      else{
        throw ServerFailure(statusCode: response.statusCode.toString(),
            message: response.data["message"] ?? "unKnown error"
        );
      }
    }on DioException catch (dioException){
      throw ServerFailure(
          statusCode: dioException.response?.statusCode.toString()??"",
          message: dioException.response?.data["message"]?? "unKnown error");
    }
  }

}