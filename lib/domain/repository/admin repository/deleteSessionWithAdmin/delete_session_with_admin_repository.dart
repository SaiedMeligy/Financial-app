import 'package:dio/dio.dart';

abstract class DeleteSessionWithAdminRepository{
  Future<Response> deleteSessionWithAdmin(int id);
}