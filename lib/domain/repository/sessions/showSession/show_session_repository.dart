import 'package:dio/dio.dart';

abstract class ShowSessionRepository{
  Future<Response> showSession(int id);
}