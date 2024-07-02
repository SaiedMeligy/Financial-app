import 'package:dio/dio.dart';


abstract class ReplacePatientWithAdminDataSource{
  Future<Response> replacePatientWithAdmin(int id,int advisorId);
  }
