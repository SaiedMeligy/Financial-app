import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionModel.dart';
import 'package:experts_app/domain/entities/QuestionRelationModel.dart';


abstract class AllQuestionWithoutRelationRepository{
  Future<Response> getAllQuestionWithoutRelation(QuestionRelationModel questionModel);
}