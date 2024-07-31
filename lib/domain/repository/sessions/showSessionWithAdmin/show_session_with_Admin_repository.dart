import 'package:dio/dio.dart';

abstract class ShowSessionWithAdminRepository{
  Future<Response> showSession(int id);
}