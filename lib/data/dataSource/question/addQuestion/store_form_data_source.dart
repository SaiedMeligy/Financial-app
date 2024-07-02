import 'package:dio/dio.dart';

abstract class AddQuestionDataSource{
  Future<Response> addQuestion(Map<String,dynamic> requestData);
}