import 'package:dio/dio.dart';

import '../../repository/deleteQuestionFromForm/delete_question_from_form_repository.dart';


class DeleteQuestionFromFormUseCase{
  final DeleteQuestionFromFormRepository deleteQuestionFromFormRepository;
  DeleteQuestionFromFormUseCase(this.deleteQuestionFromFormRepository);

  Future<Response> execute(int questionId,int formId,bool isAdvisor)async{

    return await deleteQuestionFromFormRepository.deleteQuestionFromForm(questionId,formId,isAdvisor);
  }
}