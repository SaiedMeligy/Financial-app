import 'package:dio/dio.dart';

import '../../entities/AdviceReportModel.dart';

abstract class AdviceReportRepository{
  Future<Response> getAdviceReport(ReportAdvice advice);
}