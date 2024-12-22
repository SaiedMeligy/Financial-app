import 'package:dio/dio.dart';

abstract class DeleteSessionDataSource{
  Future<Response> deleteSession(int id);
  }
