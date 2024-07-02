import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/HomeAdvisorModel.dart';

import '../../../domain/entities/HomeAdminModel.dart';

abstract class HomeAdminDataSource{
  Future<Response> getHomeAdmin(HomeAdminModel homeAdmin);
}