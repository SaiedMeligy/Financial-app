import 'package:dio/dio.dart';

abstract class ProfileDataSource {

  Future<Response> getProfileAdvisor(int advisorId);
}