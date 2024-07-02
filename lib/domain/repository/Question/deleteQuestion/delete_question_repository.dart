import 'package:dio/dio.dart';

abstract class DeleteQuestionRepository{
  Future<Response> deleteQuestion(int id);
}