import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:experts_app/core/config/cash_helper.dart';
import 'package:experts_app/core/config/constants.dart';

import 'add_complaint_data_source.dart';


class AddComplaintDataSourceImp implements AddComplaintDataSource{
  final Dio dio;
  AddComplaintDataSourceImp(this.dio);
  @override
  Future<Response> addComplaint(String complaint,String nationalId) async{
    return await dio.post(
      "/api/complaint",
      data: {"complaint":complaint,"national_id":nationalId},
      options: Options(
        headers: {
          "api-password":Constants.apiPassword,
          "token":CacheHelper.getData(key: "token")
        },


      ),
    );

  }

}