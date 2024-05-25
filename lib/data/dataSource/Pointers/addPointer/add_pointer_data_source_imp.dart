import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'add_pointer_data_source.dart';

class AddPointerDataSourceImp implements AddPointerDataSource{
  final Dio dio;
  AddPointerDataSourceImp(this.dio);
  @override
  Future<Response> addPointer(int senarioId, String title) async{
    return await dio.post(
      "/api/pointer",
      data: {
        "text": title,
        "senario_id": senarioId
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