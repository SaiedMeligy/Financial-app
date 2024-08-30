
import 'package:dio/dio.dart';

abstract class LoginPatientDataSource{
  Future<Response> login(String nationalId);

}