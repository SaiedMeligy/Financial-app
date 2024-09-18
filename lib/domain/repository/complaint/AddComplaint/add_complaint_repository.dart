import 'package:dio/dio.dart';



abstract class AddComplaintRepository{
  Future<Response> addComplaint(String complaint,String nationalID);
}