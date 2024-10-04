import 'package:dio/dio.dart';

abstract class UpdateConsultationDataSource{
  Future<Response> updateConsultation(int id,String name,String description);
  }
