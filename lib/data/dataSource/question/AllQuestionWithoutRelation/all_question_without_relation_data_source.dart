import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionRelationModel.dart';
abstract class AllQuestionWithoutRelationDataSource {

  Future<Response> getAllQuestionWithoutRelation(QuestionRelationModel questionModel);
}