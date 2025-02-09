import 'package:dio/dio.dart';

abstract class DeleteQuestionFormDataSource{
  Future<Response> deleteQuestionFromForm(int questionId,int formId,bool isAdvisor);
  }
