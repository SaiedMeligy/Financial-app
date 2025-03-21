import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/data/dataSource/sessions/evaluationSession/evaluation_session_data_source.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';

class EvaluationSessionDataSourceImp  implements EvaluationSessionDataSource{
  final Dio dio;
  EvaluationSessionDataSourceImp(this.dio);

  @override
  Future<Response> evaluationSession(int? sessionId,int? formId) async{
    return await dio.post('/api/PointersEvaluation/getEvalutionPointersForSession',
      data: {
        'sessionId':sessionId,
        'formID':formId,
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