import 'package:dio/dio.dart';

import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';
import 'add_service_data_source.dart';

class AddServiceDataSourceImp implements AddServiceDataSource{
  final Dio dio;
  AddServiceDataSourceImp(this.dio);
  @override
  Future<Response> addService(String description) async{
    return await dio.post(
      "/api/suggestions-for-new-service",
      data: {
        "description":description
      },
      options: Options(
          headers: {
            "api-password": Constants.apiPassword,
            "token": CacheHelper.getData(key: "token")
          }
      ),

      );


  }

}