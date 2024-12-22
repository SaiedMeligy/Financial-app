import 'package:dio/dio.dart';

abstract class DeleteSessionWithAdminDataSource{
  Future<Response> deleteSessionWithAdmin(int id);
  }
