import 'package:dio/dio.dart';

abstract class AddAdviceRepository{
  Future<Response> addAdvice(String advice);
}