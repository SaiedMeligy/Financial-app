import 'package:dio/dio.dart';

abstract class AddSessionEvaluationDataSource{
  Future<Response> addSessionEvaluation(List<Map<String, String>>?  pointerEvaluation,int? sessionId,int? formId);
}