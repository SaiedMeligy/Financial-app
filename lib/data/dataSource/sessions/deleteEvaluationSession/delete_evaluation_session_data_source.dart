import 'package:dio/dio.dart';

abstract class DeleteEvaluationSessionDataSource{
  Future<Response> deleteEvaluationSession(int id);
  }
