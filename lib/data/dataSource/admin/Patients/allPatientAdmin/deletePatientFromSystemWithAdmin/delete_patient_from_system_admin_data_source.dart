import 'package:dio/dio.dart';

abstract class DeletePatientFromSystemWithAdminDataSource{
  Future<Response> deletePatientWithAdmin(int id);
  }
