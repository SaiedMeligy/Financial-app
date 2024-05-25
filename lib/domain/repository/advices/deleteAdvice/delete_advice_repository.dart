import 'package:dio/dio.dart';

abstract class DeleteAdviceRepository{
  Future<Response> deleteAdvice(int id);
}