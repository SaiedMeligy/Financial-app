import 'package:dio/dio.dart';

abstract class DeletePointerRepository{
  Future<Response> deletePointer(int id);
}