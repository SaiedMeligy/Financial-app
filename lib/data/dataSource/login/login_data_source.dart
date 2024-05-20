
import 'package:dio/dio.dart';

abstract class LoginDataSource{
  Future<Response> login(String email,String password);

}