import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';
import 'get_session_details_data_source.dart';

class GetSessionDetailsDataSourceImp implements GetSessionDetailsDataSource{

  final Dio dio;
  GetSessionDetailsDataSourceImp(this.dio);

  @override
  Future<Response> getSessionDetails(String nationalId,int?with_all_questions) async{
    return await dio.get(
      "/api/advicor/pationt/show",
      queryParameters: {
        "national_id": nationalId,
        "with_all_questions":with_all_questions
      },
      options: Options(
        headers: {
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        }
      )

    );

  }

}