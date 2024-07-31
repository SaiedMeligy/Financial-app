import 'package:dio/dio.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/core/config/constants.dart';

import 'show_session_data_source.dart';

class ShowSessionDataSourceImp implements ShowSessionDataSource{
  final Dio dio;
  ShowSessionDataSourceImp(this.dio,);
  @override
  Future<Response> showSession(int id) async{
    return await dio.get(
     "/api/advicor/session/show",
      options: Options(
        headers: {
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        },


      ),
      queryParameters:{
       "id":id
      }
    );

  }

}