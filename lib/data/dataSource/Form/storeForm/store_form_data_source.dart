import 'package:dio/dio.dart';

abstract class StoreFormDataSource{
  Future<Response> store(Map<String,dynamic> storeData);
}