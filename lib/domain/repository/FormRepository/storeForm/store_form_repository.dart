import 'package:dio/dio.dart';

abstract class StoreFormRepository{
  Future<Response> store(Map<String,dynamic> storeData);
}