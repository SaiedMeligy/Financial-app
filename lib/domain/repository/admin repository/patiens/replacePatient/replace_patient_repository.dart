import 'package:dio/dio.dart';

abstract class ReplacePatientWithAdminRepository{

  Future<Response> replacePatientWithAdmin(int id,int advisorId);
}