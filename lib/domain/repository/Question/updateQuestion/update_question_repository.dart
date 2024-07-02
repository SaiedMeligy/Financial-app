import 'package:dio/dio.dart';

abstract class UpdateQuestionRepository{
  Future<Response> updateQuestion(Map<String,dynamic> dataRequest);
}