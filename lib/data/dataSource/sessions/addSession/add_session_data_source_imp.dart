import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/core/config/constants.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';

import 'add_session_data_source.dart';

class AddSessionDataSourceImp implements AddSessionDataSource{
  final Dio dio;
  AddSessionDataSourceImp(this.dio);
  @override
  Future<Response> addSession(Sessions data) async{
    return await dio.post(
      "/api/session",
      data: {
        "advicor_id":data.advicorId,
        "pationt_id":data.pationtId,
        "case_manager":data.caseManager,
        "phone_number":data.phoneNumber,
        "date":data.date,
        "time":data.time,
        "other_phone_number":data.otherPhoneNumber,
        "comments":data.comments,
      },
      options: Options(
        headers: {
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        },


      ),
    );

  }

}