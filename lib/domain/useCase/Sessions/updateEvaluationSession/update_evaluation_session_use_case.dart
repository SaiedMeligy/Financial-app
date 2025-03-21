import 'package:dio/dio.dart';
import '../../../repository/sessions/updateEvaluationSession/update_evaluation_session_repository.dart';



class UpdateEvaluationSessionUseCase{
  final UpdateEvaluationSessionRepository sessionEvaluationRepository;
  UpdateEvaluationSessionUseCase(this.sessionEvaluationRepository);
  Future<Response> execute(int id, int evaluation)async{
    return await sessionEvaluationRepository.updateEvaluationSession(id,evaluation);
  }
}