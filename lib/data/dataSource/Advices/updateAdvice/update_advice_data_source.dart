import 'package:dio/dio.dart';


abstract class UpdateAdviceDataSource{
  Future<Response> updateAdvice(int id,String title);
  }
