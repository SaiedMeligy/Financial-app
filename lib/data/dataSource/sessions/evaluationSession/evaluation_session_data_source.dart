import 'package:dio/dio.dart';

abstract class EvaluationSessionDataSource{
  Future<Response> evaluationSession(int? sessionId,int? formId);


}