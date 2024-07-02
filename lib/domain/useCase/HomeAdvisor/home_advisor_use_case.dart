

import 'package:dio/dio.dart';

import '../../entities/HomeAdvisorModel.dart';
import '../../repository/homeAdvisorRepository/home_advisor_repository.dart';

class HomeAdvisorUseCase{

  final HomeAdvisorRepository homeAdvisorRepository;

  HomeAdvisorUseCase( this.homeAdvisorRepository);

  Future<Response> execute(HomeAdvisorModel patientModel){
    return homeAdvisorRepository.getHomeAdvisor(patientModel);
  }
}