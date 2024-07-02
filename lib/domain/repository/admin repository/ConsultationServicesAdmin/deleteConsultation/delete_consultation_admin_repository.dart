import 'package:dio/dio.dart';

abstract class DeleteConsultationAdminRepository{
  Future<Response> deleteConsultationAdmin(int id);
}