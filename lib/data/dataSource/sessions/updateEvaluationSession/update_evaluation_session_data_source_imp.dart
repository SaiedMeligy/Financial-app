import 'package:dio/dio.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';
import 'update_evaluation_session_data_source.dart';

class UpdateEvaluationSessionDataSourceImp implements UpdateEvaluationSessionDataSource{
  final Dio dio;

  UpdateEvaluationSessionDataSourceImp(this.dio);
  @override
  Future<Response> updateEvaluationSession(int id , int evaluation) async{
    return await dio.post(
      "/api/PointersEvaluation/editPointerEvaluation",
      options: Options(
        headers: {
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        }
      ),
      data: {
        "id": id,
        "evaluation": evaluation
      }

    );

  }

}