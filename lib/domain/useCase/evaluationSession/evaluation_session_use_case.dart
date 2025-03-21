import 'package:dio/dio.dart';

import '../../repository/sessions/evaluationSession/evaluation_session_repo.dart';




class EvaluationSessionUseCase{
  final EvaluationSessionRepository evaluationRepository;
  EvaluationSessionUseCase(this.evaluationRepository);

  Future<Response> execute(int? sessionId,int? formId)async{

    return await evaluationRepository.evaluationSession(sessionId,formId);
  }
}