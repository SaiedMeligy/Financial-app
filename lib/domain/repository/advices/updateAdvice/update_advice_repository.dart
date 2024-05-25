import 'package:dio/dio.dart';

abstract class UpdateAdviceRepository{

  Future<Response> updateAdvice(int id,String title);
}