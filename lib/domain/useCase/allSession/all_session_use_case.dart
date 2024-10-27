import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';

import '../../repository/AllSession/all_session_repository.dart';

class AllSessionUseCase{

  final AllSessionRepository allSessionRepository;

  AllSessionUseCase( this.allSessionRepository);

  Future<Response> execute(AllSessionModel sessionModel,{int page=1,int per_page=15,String searchQuery =''}){
    return allSessionRepository.getAllSession(sessionModel,page: page,per_page: per_page,searchQuery: searchQuery);
  }
}