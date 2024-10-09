import 'package:dio/dio.dart';

abstract class DeletePatientFromSystemWithAdminRepository{
  Future<Response> deletePatientWithAdmin(int id);
}