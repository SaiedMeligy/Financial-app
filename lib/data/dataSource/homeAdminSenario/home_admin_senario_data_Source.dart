import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/HomeAdvisorModel.dart';
import 'package:experts_app/domain/entities/SenarioModels.dart';

import '../../../domain/entities/HomeAdminModel.dart';

abstract class HomeAdminSenarioDataSource{
  Future<Response> getHomeAdminSenario(SenarioModels homeAdmin);
}