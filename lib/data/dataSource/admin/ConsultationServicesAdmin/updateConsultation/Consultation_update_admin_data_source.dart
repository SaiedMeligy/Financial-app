import 'package:dio/dio.dart';

abstract class UpdateConsultationAdminDataSource{
  Future<Response> updateConsultationAdmin(int id,String name,String description);
  }
