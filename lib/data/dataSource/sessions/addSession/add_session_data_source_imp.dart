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
  Future<Response> addSession(AddSessionModel data) async{
    return await dio.post(
      "/api/session",
      data: {
        "advicor_id":data.advisorId,
        "pationt_id":data.patientId,
        "case_manager":data.caseManager,
        "phone_number":data.phoneNumber,
        "date":data.dateTime,
        "time":data.time
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