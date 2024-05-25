
import 'package:dio/dio.dart';

import '../../core/Failure/server_failure.dart';
import '../../domain/repository/addQuestion/add_question_repository.dart';
import '../dataSource/addQuestion/add_question_data_source.dart';

class AddQuestionRepositoryImp implements AddQuestionRepository{
  final AddQuestionDataSource dataSource;
  AddQuestionRepositoryImp(this.dataSource);
  @override
  Future<Response> addQuestion(Map<String,dynamic> dataRequest) async {
    try {
      final response = await dataSource.addQuestion(dataRequest);
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