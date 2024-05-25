import 'package:dio/dio.dart';

abstract class AddAdviceDataSource{
  Future<Response> addAdvice(String advice);
}