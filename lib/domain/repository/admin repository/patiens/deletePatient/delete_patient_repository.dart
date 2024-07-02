import 'package:dio/dio.dart';

abstract class DeletePatientWithAdminRepository{
  Future<Response> deletePatientWithAdmin(int id);
}