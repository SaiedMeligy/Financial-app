import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';
import 'add_question_data_source.dart';

class AddQuestionDataSourceImp implements AddQuestionDataSource{
  final Dio  dio;
  AddQuestionDataSourceImp(this.dio);

  @override
  Future<Response> addQuestion(Map<String, dynamic> requestData) async{
    try {
      return await dio.post(
        '/api/question',
        data: requestData,
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        ),
      );
    } on DioError catch (e) {
      print('Error: ${e.response?.data ?? e.message}');
      rethrow;
    }
  }

}