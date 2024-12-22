import 'package:dio/dio.dart';

abstract class DeleteSessionRepository{
  Future<Response> deleteSession(int id);
}