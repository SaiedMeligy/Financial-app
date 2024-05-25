import 'package:dio/dio.dart';

abstract class AddQuestionRepository{
  Future<Response> addQuestion(Map<String,dynamic> dataRequest);
}