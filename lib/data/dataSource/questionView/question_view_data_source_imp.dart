import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/questionView/question_view_data_source.dart';
import 'package:experts_app/domain/entities/QuestionView.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';

class QuestionViewDataSourceImp implements QuestionViewDataSource{
  final Dio dio;
  QuestionViewDataSourceImp(this.dio);
  @override
  Future<Response> getQuestion(QuestionView questionView) async{
    print(CacheHelper.getData(key: "token"));
    print( ":(      ${Constants.apiPassword}");
    final result = await dio.get(
      "/api/advicor/question",
      options: Options(
        headers:{
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        }
      )

    );
     print(result.data);
     return result;
  }

}