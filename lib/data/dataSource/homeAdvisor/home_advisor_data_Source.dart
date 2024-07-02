import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/HomeAdvisorModel.dart';

abstract class HomeAdvisorDataSource{
  Future<Response> getHomeAdvisor(HomeAdvisorModel homeAdvisor);
}