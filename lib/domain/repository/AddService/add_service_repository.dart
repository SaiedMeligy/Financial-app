import 'package:dio/dio.dart';



abstract class AddServiceRepository{
  Future<Response> addService(String description);
}