import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/core/config/constants.dart';

import 'add_session_evaluation_data_source.dart';

class AddSessionEvaluationDataSourceImp implements AddSessionEvaluationDataSource{
  final Dio dio;
  bool isForm = false;
  AddSessionEvaluationDataSourceImp(this.dio,
      // {this.isAdvicor = false}
      );
  @override
  Future<Response> addSessionEvaluation(List<Map<String, String>>?  pointerEvaluation,int? sessionId, int? formId ) async{
    return await dio.post(
      // (isAdvicor)?
      "/api/PointersEvaluation/addPointersEvaluation",
      data: {
        "pointersEvaluation" : pointerEvaluation,
        "formID":formId,
        "sessionId":sessionId,
      },
      options: Options(
        headers: {
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        },
      ),
    );

  }

}