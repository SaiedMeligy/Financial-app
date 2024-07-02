import 'package:dio/dio.dart';
import '../../../repository/Question/deleteQuestion/delete_question_repository.dart';


class DeleteQuestionUseCase{
  final DeleteQuestionRepository deleteQuestionRepository;
  DeleteQuestionUseCase(this.deleteQuestionRepository);

  Future<Response> execute(int id)async{

    return await deleteQuestionRepository.deleteQuestion(id);
  }
}