import 'package:dio/dio.dart';

import '../../../repository/sessions/addSessionEvaluation/add_session_evaluation _repository.dart';



class AddSessionEvaluationUseCase{
  final AddSessionEvaluationRepository sessionEvaluationRepository;
  AddSessionEvaluationUseCase(this.sessionEvaluationRepository);
  Future<Response> execute(List<Map<String, String>>?  pointerEvaluation,int? sessionId,int? formId)async{
    return await sessionEvaluationRepository.addSessionEvaluation(pointerEvaluation,sessionId,formId);
  }
}