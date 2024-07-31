import 'package:dio/dio.dart';

import '../../../repository/sessions/showSessionWithAdmin/show_session_with_Admin_repository.dart';



class ShowSessionWithAdminUseCase{
  final ShowSessionWithAdminRepository showSessionRepository;
  ShowSessionWithAdminUseCase(this.showSessionRepository);
  Future<Response> execute(int id)async{
    return await showSessionRepository.showSession(id);
  }
}