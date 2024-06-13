import 'package:dio/dio.dart';

import '../../../core/config/cash_helper.dart';
import '../../../core/config/constants.dart';
import '../../../domain/entities/AdviceReportModel.dart';
import 'advice_report_data_source.dart';

class AdviceReportDataSourceImp implements AdviceReportDataSource{
  final Dio dio;
  AdviceReportDataSourceImp(this.dio);
  @override
  Future<Response> getAdviceReport(ReportAdvice advice,) async{
    return await dio.get(
      "/api/reports/advice-report",
      options: Options(
        headers: {
          "api-password": Constants.apiPassword,
          "token": CacheHelper.getData(key: "token")
        },
      ),
    );
  }


}