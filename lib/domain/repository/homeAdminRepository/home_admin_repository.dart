import 'package:dio/dio.dart';

import '../../entities/HomeAdminModel.dart';


abstract class HomeAdminRepository{
  Future<Response> getHomeAdmin(HomeAdminModel homeAdmin);
}