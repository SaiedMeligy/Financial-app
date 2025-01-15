import 'package:dio/dio.dart';

abstract class GetPatientDetailsRepository{
  Future<Response> getPatientDetails(String nationalId,int? with_all_questions);
}