import 'package:dio/dio.dart';
import 'package:experts_app/data/dataSource/reserveService/reserve_service_data_source.dart';

import '../../../../../core/config/cash_helper.dart';
import '../../../../../core/config/constants.dart';

class ReserveServiceDataSourceImp implements ReserveServiceDataSource{
  final Dio dio;
  ReserveServiceDataSourceImp(this.dio);
  Future<Response> reserveService(int consultationId,int patientId,String date,String time,int attendType) async{
    return await dio.post(
      "/api/reservation",
      data: {
        "consultation_service_id": consultationId,
        "pationt_id":patientId,
        "date": date,
        "time": time,
        "atending_type":attendType,
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