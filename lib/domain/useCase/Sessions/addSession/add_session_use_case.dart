import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';

import '../../../repository/sessions/addSession/add_session_repository.dart';



class AddSessionUseCase{
  final AddSessionRepository sessionRepository;
  AddSessionUseCase(this.sessionRepository);
  Future<Response> execute(AddSessionModel data)async{
    return await sessionRepository.addSession(data);
  }
}