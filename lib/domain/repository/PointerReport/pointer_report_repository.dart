import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/PointerReportModel.dart';

abstract class PointerReportRepository{
  Future<Response> getPointerReport(Report pointer,int id);
}