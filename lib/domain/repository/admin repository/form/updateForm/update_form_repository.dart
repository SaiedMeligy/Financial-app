import 'package:dio/dio.dart';

abstract class UpdateFormRepository{
  Future<Response> update(Map<String,dynamic> updateData);
}