import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/QuestionView.dart';
import 'package:experts_app/domain/repository/questionView/view_question_repository.dart';

class QuestionViewUseCase{
  final QuestionViewRepository questionViewRepository;
  QuestionViewUseCase(this.questionViewRepository);

  Future<Response> execute(QuestionView questionView){
    return questionViewRepository.getQuestion(questionView);
  }
}