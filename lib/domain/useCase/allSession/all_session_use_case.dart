import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';

import '../../repository/AllSession/all_session_repository.dart';

class AllSessionUseCase{

  final AllSessionRepository allSessionRepository;

  AllSessionUseCase( this.allSessionRepository);

  Future<Response> execute(AllSessionModel sessionModel){
    return allSessionRepository.getAllSession(sessionModel);
  }
}