import 'package:dio/dio.dart';

abstract class AddComplaintDataSource{
  Future<Response> addComplaint(String complaint,String nationalId);
}