import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/SenarioModels.dart';

import '../../entities/HomeAdminModel.dart';

abstract class HomeAdminSenarioRepository{
  Future<Response> getHomeAdminSenario(SenarioModels homeAdmin);
}