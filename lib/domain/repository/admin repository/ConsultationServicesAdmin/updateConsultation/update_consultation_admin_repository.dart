import 'package:dio/dio.dart';

abstract class UpdateConsultationAdminRepository{
  Future<Response> updateConsultationAdmin(int id,String name,String description);
}