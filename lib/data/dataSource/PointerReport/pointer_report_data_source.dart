import 'package:dio/dio.dart';

import '../../../domain/entities/PointerReportModel.dart';

abstract class PointerReportDataSource{

  Future<Response> getPointerReport(Report pointer,int id);
}