
import 'package:dio/dio.dart';

import '../../../repository/Question/updateQuestion/update_question_repository.dart';

class UpdateQuestionUseCase{
  final UpdateQuestionRepository updateQuestionRepository;
  UpdateQuestionUseCase(this.updateQuestionRepository);
  Future<Response> execute(Map<String,dynamic> dataRequest)async{
    return await updateQuestionRepository.updateQuestion(dataRequest);
  }
}