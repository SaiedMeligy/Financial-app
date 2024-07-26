

import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/SenarioModels.dart';

import '../../entities/HomeAdminModel.dart';
import '../../entities/HomeAdvisorModel.dart';
import '../../repository/homeAdminRepository/home_admin_Senario_repository.dart';
import '../../repository/homeAdminRepository/home_admin_repository.dart';
import '../../repository/homeAdvisorRepository/home_advisor_repository.dart';

class HomeAdminSenarioUseCase{

  final HomeAdminSenarioRepository homeAdminRepository;

  HomeAdminSenarioUseCase( this.homeAdminRepository);

  Future<Response> execute(SenarioModels homeModel){
    return homeAdminRepository.getHomeAdminSenario(homeModel);
  }
}