import 'package:dio/dio.dart';
abstract class DeleteConsultationDataSource{
  Future<Response> deleteConsultation(int id);
  }
