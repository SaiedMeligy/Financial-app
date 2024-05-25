import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'delete_pointer_data_source.dart';

class DeletePointerDataSourceImp implements DeletePointerDataSource{
  final Dio dio;
  DeletePointerDataSourceImp(this.dio);
  @override
  Future<Response> deletePointer(int id) async{
    return await dio.delete(
      "/api/pointer/destroy",
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