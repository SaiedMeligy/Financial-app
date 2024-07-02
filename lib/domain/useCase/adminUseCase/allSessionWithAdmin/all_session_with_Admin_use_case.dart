import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';

import '../../../repository/admin repository/AllSessionWithAdmin/all_session_with_admin_repository.dart';

class AllSessionWithAdminUseCase{

  final AllSessionWithAdminRepository allSessionRepository;

  AllSessionWithAdminUseCase( this.allSessionRepository);

  Future<Response> execute(AllSessionModel sessionModel){
    return allSessionRepository.getAllSessionWithAdmin(sessionModel);
  }
}