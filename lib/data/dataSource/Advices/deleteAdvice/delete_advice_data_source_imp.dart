import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'delete_advice_data_source.dart';

class DeleteAdviceDataSourceImp implements DeleteAdviceDataSource{
  final Dio dio;
  DeleteAdviceDataSourceImp(this.dio);
  @override
  Future<Response> deleteAdvice(int id) async{
    return await dio.delete(
      "/api/advice/destroy",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      queryParameters: {
        "id":id,
      }
      );


  }

}