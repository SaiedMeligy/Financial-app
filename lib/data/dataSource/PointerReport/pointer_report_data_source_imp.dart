import 'package:dio/dio.dart';
import 'package:experts_app/data/dataSource/PointerReport/pointer_report_data_source.dart';
import 'package:experts_app/domain/entities/PointerReportModel.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';

class PointerReportDataSourceImp implements PointerReportDataSource{
  final Dio dio;
  PointerReportDataSourceImp(this.dio);

  @override
  Future<Response> getPointerReport(Report pointer,int id) async{
    return await dio.get(
      "/api/reports/pointer-report",
      options: Options(
        headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        },
      ),
      queryParameters: {
        "senario_id": id,
      },
    );
  }


}