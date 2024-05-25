import 'package:dio/dio.dart';

abstract class UpdatePointerRepository{

  Future<Response> updatePointer(int id,String title);
}