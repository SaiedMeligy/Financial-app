import 'package:dio/dio.dart';
import '../../../domain/entities/HomeAdminModel.dart';

abstract class HomeAdminDataSource{
  Future<Response> getHomeAdmin(HomeAdminModel homeAdmin);
}