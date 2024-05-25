import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'update_advice_data_source.dart';

class UpdateAdviceDataSourceImp implements UpdateAdviceDataSource{
  final Dio dio;
  UpdateAdviceDataSourceImp(this.dio);
  @override
  Future<Response> updateAdvice(int id,String title) async{
    return await dio.patch(
      "/api/advice/update",
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          },
      ),
      queryParameters: {
        "id":id,
        "text":title,
      }

      );


  }

}