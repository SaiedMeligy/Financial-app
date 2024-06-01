import 'package:dio/dio.dart';

abstract class UpdateFormDataSource{
  Future<Response> update(Map<String,dynamic> updateData);
}