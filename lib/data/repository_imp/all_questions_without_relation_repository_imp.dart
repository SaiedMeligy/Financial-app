import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/Failure/server_failure.dart';
import 'package:experts_app/domain/entities/QuestionRelationModel.dart';

import '../../domain/repository/Question/AllQuestionWithoutRelation/all_question_without_relation_repository.dart';
import '../dataSource/question/AllQuestionWithoutRelation/all_question_without_relation_data_source.dart';


class AllQuestionWithoutRelationRepositoryImp implements AllQuestionWithoutRelationRepository{
  final AllQuestionWithoutRelationDataSource dataSource;
  AllQuestionWithoutRelationRepositoryImp(this.dataSource);
  @override
  Future<Response> getAllQuestionWithoutRelation(QuestionRelationModel questionModel) async {
    try {
      final response = await dataSource.getAllQuestionWithoutRelation(
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