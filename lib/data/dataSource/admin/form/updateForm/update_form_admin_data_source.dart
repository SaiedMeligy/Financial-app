import 'package:dio/dio.dart';

abstract class UpdateFormWithAdminDataSource{
  Future<Response> updateWithAdmin(Map<String,dynamic> updateData);
}