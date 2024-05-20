
import 'package:dio/dio.dart';

abstract class LogoutDataSource{
  Future<Response> logout();

}