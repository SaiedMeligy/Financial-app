import 'package:dio/dio.dart';


abstract class UpdatePointerDataSource{
  Future<Response> updatePointer(int id,String title);
  }
