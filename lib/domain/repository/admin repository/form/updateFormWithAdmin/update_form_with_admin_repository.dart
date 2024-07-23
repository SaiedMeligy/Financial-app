import 'package:dio/dio.dart';

abstract class UpdateFormWithAdminRepository{
  Future<Response> updateWithAdmin(Map<String,dynamic> updateData);
}