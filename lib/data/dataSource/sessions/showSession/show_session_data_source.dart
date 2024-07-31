import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';

abstract class ShowSessionDataSource{
  Future<Response> showSession(int id);
}