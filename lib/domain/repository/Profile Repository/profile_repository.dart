import 'package:dio/dio.dart';


abstract class ProfileRepository{
  Future<Response> getProfile(int advisorId);
}