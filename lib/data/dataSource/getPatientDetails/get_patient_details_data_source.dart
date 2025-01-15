import 'package:dio/dio.dart';

abstract class GetPatientDetailsDataSource{
  Future<Response> getPatientDetails(String nationalId,int? with_all_questions);
}