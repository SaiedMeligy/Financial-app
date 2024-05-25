import 'package:dio/dio.dart';

abstract class AddPointerRepository {
  Future<Response> addPointer(int senarioId,String title);
}