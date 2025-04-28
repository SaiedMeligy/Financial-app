import 'package:dio/dio.dart';
import 'package:experts_app/data/dataSource/ProfileAdvisor/profile_data_source.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';

class ProfileDataSourceImp implements ProfileDataSource{
  final Dio dio;
  ProfileDataSourceImp(this.dio);
  @override
  Future<Response> getProfileAdvisor(int id) async{
    return await dio.post(
        "/api/user/getProfile",
        data: {
          'id':id
        },
        options: Options(
            headers: {
              "api-password": Constants.apiPassword,
              "token": CacheHelper.getData(key: "token")
            },
        )
    );

  }

}