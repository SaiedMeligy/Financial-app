import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/SenarioModels.dart';

abstract class HomeAdminSenarioDataSource{
  Future<Response> getHomeAdminSenario(SenarioModels homeAdmin);
}