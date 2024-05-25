import 'package:dio/dio.dart';

abstract class DeletePointerDataSource{
  Future<Response> deletePointer(int id);
  }
