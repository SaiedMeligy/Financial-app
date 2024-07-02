import 'package:dio/dio.dart';

abstract class DeleteQuestionDataSource{
  Future<Response> deleteQuestion(int id);
  }
