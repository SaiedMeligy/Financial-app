import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionModel.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'all_question_data_source.dart';

class AllQuestionDataSourceImp implements AllQuestionDataSource{
  final Dio dio;
  AllQuestionDataSourceImp(this.dio);
  @override
  Future<Response> getAllQuestion(QuestionModel questionModel) async{
    return await dio.get(
        "/api/question",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}