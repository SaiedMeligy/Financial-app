import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/domain/entities/QuestionModel.dart';
import '../../domain/repository/Question/AllQuestion/all_question_repository.dart';
import '../dataSource/question/AllQuestion/all_question_data_source.dart';

class AllQuestionRepositoryImp implements AllQuestionRepository{
  final AllQuestionDataSource dataSource;
  AllQuestionRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllQuestion(QuestionModel questionModel) async {
    try {
      final response = await dataSource.getAllQuestion(
          questionModel);
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
      throw ServerFailure(statusCode: dioException.response?.statusCode.toString()??"",
      message: dioException.response?.data["message"]?? "unKnown error");
    }
  }

}