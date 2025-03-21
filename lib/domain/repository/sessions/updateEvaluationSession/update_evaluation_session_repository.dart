import 'package:dio/dio.dart';

abstract class UpdateEvaluationSessionRepository{
  Future<Response> updateEvaluationSession(int id, int evaluation);
}