import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionRelationModel.dart';

import '../../../repository/Question/AllQuestionWithoutRelation/all_question_without_relation_repository.dart';

class AllQuestionWithoutRelationUseCase{

  final AllQuestionWithoutRelationRepository allQuestionWithoutRelationRepository;

  AllQuestionWithoutRelationUseCase( this.allQuestionWithoutRelationRepository);

  Future<Response> execute(QuestionRelationModel questionModel){
    return allQuestionWithoutRelationRepository.getAllQuestionWithoutRelation(questionModel);
  }
}