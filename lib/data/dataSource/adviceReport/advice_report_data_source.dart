import 'package:dio/dio.dart';

import '../../../domain/entities/AdviceReportModel.dart';

abstract class AdviceReportDataSource{

  Future<Response> getAdviceReport(AdviceReportModel advice);
}