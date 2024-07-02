import 'package:dio/dio.dart';

import '../../../../domain/entities/QuestionModel.dart';

abstract class AllQuestionDataSource {

  Future<Response> getAllQuestion(QuestionModel questionModel);
}