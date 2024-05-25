import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/questionView/question_view_data_source.dart';
import 'package:experts_app/domain/entities/QuestionView.dart';
import 'package:experts_app/domain/repository/questionView/view_question_repository.dart';

import '../../core/Failure/server_failure.dart';

class QuestionViewRepositoryImp implements QuestionViewRepository{
  final QuestionViewDataSource dataSource;
  QuestionViewRepositoryImp(this.dataSource);
  @override
  Future<Response> getQuestion(QuestionView questionView) async{
    try {
      final response = await dataSource.getQuestion(
          questionView);
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