import 'package:dio/dio.dart';
import '../../../repository/sessions/deleteSession/delete_session_repository.dart';


class DeleteSessionUseCase{
  final DeleteSessionRepository deleteSessionRepository;
  DeleteSessionUseCase(this.deleteSessionRepository);

  Future<Response> execute(int id)async{

    return await deleteSessionRepository.deleteSession(id);
  }
}