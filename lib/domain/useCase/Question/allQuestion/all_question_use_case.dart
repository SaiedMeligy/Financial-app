import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionModel.dart';
import '../../../entities/AdviceMode.dart';
import '../../../repository/Question/AllQuestion/all_question_repository.dart';

class AllQuestionUseCase{

  final AllQuestionRepository allQuestionRepository;

  AllQuestionUseCase( this.allQuestionRepository);

  Future<Response> execute(QuestionModel questionModel){
    return allQuestionRepository.getAllQuestion(questionModel);
  }
}