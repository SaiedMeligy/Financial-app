import 'package:dio/dio.dart';
abstract class AllSessionEvaluationDataSource {

  Future<Response> getAllSessionEvaluation(List<int> sessionIds);
}