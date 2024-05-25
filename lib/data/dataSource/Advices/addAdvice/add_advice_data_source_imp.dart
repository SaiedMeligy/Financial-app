import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/core/config/constants.dart';

import 'add_advice_data_source.dart';

class AddAdviceDataSourceImp implements AddAdviceDataSource{
  final Dio dio;
  AddAdviceDataSourceImp(this.dio);
  @override
  Future<Response> addAdvice(String advice) async{
    return await dio.post(
      "/api/advice",
      data: {"text":advice},
      options: Options(
        headers: {
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        },


      ),
    );

  }

}