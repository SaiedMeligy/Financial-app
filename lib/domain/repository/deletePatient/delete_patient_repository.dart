import 'package:dio/dio.dart';

abstract class DeletePatientRepository{
  Future<Response> deletePatient(int id);
}