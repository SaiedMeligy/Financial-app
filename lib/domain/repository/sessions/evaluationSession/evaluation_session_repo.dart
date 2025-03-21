import 'package:dio/dio.dart';

abstract class EvaluationSessionRepository{
  Future<Response> evaluationSession(int? sessionId,int? formId);
}