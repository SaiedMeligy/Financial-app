import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';

abstract class AddSessionRepository{
  Future<Response> addSession(AddSessionModel data);
}