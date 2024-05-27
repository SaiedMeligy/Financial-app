import 'package:dio/dio.dart';

abstract class PatientNationalIdDataSource{
  Future<Response> getNationalId(String nationalId);
}