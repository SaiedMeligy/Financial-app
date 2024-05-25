import 'package:dio/dio.dart';

abstract class AddPointerDataSource {
  Future<Response> addPointer(int senarioId,String title);
}