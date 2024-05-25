import 'package:dio/dio.dart';

abstract class DeleteAdviceDataSource{
  Future<Response> deleteAdvice(int id);
  }
