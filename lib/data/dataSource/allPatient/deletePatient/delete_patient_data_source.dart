import 'package:dio/dio.dart';

abstract class DeletePatientDataSource{
  Future<Response> deletePatient(int id);
  }
