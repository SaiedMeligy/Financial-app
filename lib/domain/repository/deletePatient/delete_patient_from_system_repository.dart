import 'package:dio/dio.dart';

abstract class DeletePatientFromSystemRepository{
  Future<Response> deletePatient(int id);
}