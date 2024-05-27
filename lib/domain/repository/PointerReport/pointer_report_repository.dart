import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/PointerReportModel.dart';

abstract class PointerReportRepository{
  Future<Response> getPointerReport(PointerReportModel pointer,int id);
}