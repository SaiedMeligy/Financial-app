

import 'package:dio/dio.dart';

import '../../entities/HomeAdminModel.dart';
import '../../entities/HomeAdvisorModel.dart';
import '../../repository/homeAdminRepository/home_admin_repository.dart';
import '../../repository/homeAdvisorRepository/home_advisor_repository.dart';

class HomeAdminUseCase{

  final HomeAdminRepository homeAdminRepository;

  HomeAdminUseCase( this.homeAdminRepository);

  Future<Response> execute(HomeAdminModel homeModel){
    return homeAdminRepository.getHomeAdmin(homeModel);
  }
}