import 'package:dio/dio.dart';

abstract class DeleteQuestionFromFormRepository{
  Future<Response> deleteQuestionFromForm(int questionId,int formId,bool isAdvisor);
}