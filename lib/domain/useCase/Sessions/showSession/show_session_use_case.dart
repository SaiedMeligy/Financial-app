import 'package:dio/dio.dart';

import '../../../repository/sessions/showSession/show_session_repository.dart';



class ShowSessionUseCase{
  final ShowSessionRepository showSessionRepository;
  ShowSessionUseCase(this.showSessionRepository);
  Future<Response> execute(int id)async{
    return await showSessionRepository.showSession(id);
  }
}