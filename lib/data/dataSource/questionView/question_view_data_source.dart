import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionView.dart';

abstract class QuestionViewDataSource {

  Future<Response> getQuestion(QuestionView questionView);
}