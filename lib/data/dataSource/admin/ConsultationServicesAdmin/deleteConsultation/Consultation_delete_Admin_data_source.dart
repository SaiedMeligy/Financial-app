import 'package:dio/dio.dart';
abstract class DeleteConsultationAdminDataSource{
  Future<Response> deleteConsultationAdmin(int id);
  }
