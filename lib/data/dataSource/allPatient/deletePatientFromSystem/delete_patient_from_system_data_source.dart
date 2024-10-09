import 'package:dio/dio.dart';

abstract class DeletePatientFromSystemDataSource{
  Future<Response> deletePatient(int id);
  }
