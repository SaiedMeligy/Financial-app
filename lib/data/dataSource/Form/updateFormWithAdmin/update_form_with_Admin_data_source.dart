import 'package:dio/dio.dart';

abstract class UpdateFormWithAdminDataSource{
  Future<Response> update(Map<String,dynamic> updateData);
}