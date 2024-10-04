import 'package:dio/dio.dart';
abstract class ShowSessionDataSource{
  Future<Response> showSession(int id);
}