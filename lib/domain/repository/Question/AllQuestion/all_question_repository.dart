import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionModel.dart';


abstract class AllQuestionRepository{
  Future<Response> getAllQuestion(QuestionModel questionModel);
}