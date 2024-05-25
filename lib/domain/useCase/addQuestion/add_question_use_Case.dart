import 'package:dio/dio.dart';
import 'package:experts_app/domain/repository/addQuestion/add_question_repository.dart';

class AddQuestionUseCase{
  final AddQuestionRepository addQuestionRepository;
  AddQuestionUseCase(this.addQuestionRepository);
  Future<Response> execute(Map<String,dynamic> dataRequest)async{

    return await addQuestionRepository.addQuestion(dataRequest);
  }
}