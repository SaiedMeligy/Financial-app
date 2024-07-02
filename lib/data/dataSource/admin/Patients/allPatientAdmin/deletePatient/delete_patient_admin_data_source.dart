import 'package:dio/dio.dart';

abstract class DeletePatientWithAdminDataSource{
  Future<Response> deletePatientWithAdmin(int id);
  }
