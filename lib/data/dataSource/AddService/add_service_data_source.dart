import 'package:dio/dio.dart';

abstract class AddServiceDataSource{
  Future<Response> addService(String description);
  }
