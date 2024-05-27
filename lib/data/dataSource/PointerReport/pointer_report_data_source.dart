import 'package:dio/dio.dart';

import '../../../domain/entities/PointerReportModel.dart';

abstract class PointerReportDataSource{

  Future<Response> getPointerReport(PointerReportModel pointer,int id);
}