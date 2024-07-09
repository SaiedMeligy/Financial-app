import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionRelationModel.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'all_question_without_relation_data_source.dart';

class AllQuestionWithoutRelationDataSourceImp implements AllQuestionWithoutRelationDataSource{
  final Dio dio;
  AllQuestionWithoutRelationDataSourceImp(this.dio);
  @override
  Future<Response> getAllQuestionWithoutRelation(QuestionRelationModel questionModel) async{
    return await dio.get(
        "/api/question-indexWithoutRelations",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}