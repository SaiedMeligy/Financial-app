import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'delete_evaluation_session_data_source.dart';

class DeleteEvaluationSessionDataSourceImp implements DeleteEvaluationSessionDataSource{
  final Dio dio;
  DeleteEvaluationSessionDataSourceImp(this.dio);
  @override
  Future<Response> deleteEvaluationSession(int id) async{
    return await dio.post(
      "/api/PointersEvaluation/deletePointerEvaluation",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      data: {
        "id": id
      },
      );


  }

}