import 'package:dio/dio.dart';

abstract class DeleteEvaluationSessionRepository{
  Future<Response> deleteEvaluationSession(int id);
}