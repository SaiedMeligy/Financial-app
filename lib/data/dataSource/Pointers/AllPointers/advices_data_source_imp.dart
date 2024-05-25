import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import '../../../../domain/entities/pointerModel.dart';
import 'all_advices_data_source.dart';

class AllPointersDataSourceImp implements AllPointersDataSource{
  final Dio dio;
  AllPointersDataSourceImp(this.dio);
  Future<Response> getAllPointers(PointerModel pointerModel) async{
    return await dio.get(
        "/api/pointer",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            }
        )
    );

  }

}