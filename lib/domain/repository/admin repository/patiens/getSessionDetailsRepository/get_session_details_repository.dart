import 'package:dio/dio.dart';

abstract class GetSessionDetailsRepository{
  Future<Response> getSessionDetails(String nationalId,int? with_all_questions);
}