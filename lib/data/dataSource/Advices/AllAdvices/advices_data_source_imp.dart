import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';

import '../../../../core/config/cash_helper.dart';
import '../../../../core/config/constants.dart';
import 'all_advices_data_source.dart';

class AllAdvicesDataSourceImp implements AllAdvicesDataSource{
  final Dio dio;
  AllAdvicesDataSourceImp(this.dio);
  @override
  Future<Response> getAllAdvices(AdviceModel adviceModel) async{
    return await dio.get(
        "/api/advice",
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            },
        )
    );

  }

}