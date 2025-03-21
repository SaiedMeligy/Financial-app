import 'package:dio/dio.dart';
import '../../../repository/sessions/deleteEvaluationSession/delete_evaluation_session_repository.dart';


class DeleteEvaluationSessionUseCase{
  final DeleteEvaluationSessionRepository deleteEvaluationSessionRepository;
  DeleteEvaluationSessionUseCase(this.deleteEvaluationSessionRepository);

  Future<Response> execute(int id)async{

    return await deleteEvaluationSessionRepository.deleteEvaluationSession(id);
  }
}