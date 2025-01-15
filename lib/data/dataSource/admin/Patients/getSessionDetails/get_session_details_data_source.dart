import 'package:dio/dio.dart';

abstract class GetSessionDetailsDataSource{
  Future<Response> getSessionDetails(String nationalId,int? with_all_questions);
}