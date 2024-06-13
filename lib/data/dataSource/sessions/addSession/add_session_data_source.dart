import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';

abstract class AddSessionDataSource{
  Future<Response> addSession(AddSessionModel data);
}