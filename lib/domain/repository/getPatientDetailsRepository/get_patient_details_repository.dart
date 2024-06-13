import 'package:dio/dio.dart';

abstract class GetPatientDetailsRepository{
  Future<Response> getPatientDetails(String nationalId);
}