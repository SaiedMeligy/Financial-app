import 'package:dio/dio.dart';

abstract class UpdateQuestionDataSource{
  Future<Response> updateQuestion(Map<String,dynamic> requestData);
}