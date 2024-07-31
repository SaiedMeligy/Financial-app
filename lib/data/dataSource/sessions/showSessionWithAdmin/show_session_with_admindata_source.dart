import 'package:dio/dio.dart';

abstract class ShowSessionWithAdminDataSource{
  Future<Response> showSession(int id);
}