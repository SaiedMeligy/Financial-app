import 'package:dio/dio.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'delete_question_data_source.dart';

class DeleteQuestionDataSourceImp implements DeleteQuestionDataSource{
  final Dio dio;
  DeleteQuestionDataSourceImp(this.dio);
  Future<Response> deleteQuestion(int id) async{
    return await dio.delete(
      "/api/question/destroy",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      queryParameters: {
        "id":id,
      }
      );


  }

}