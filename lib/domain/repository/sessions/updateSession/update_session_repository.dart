import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';

abstract class UpdateSessionRepository{
  Future<Response> updateSession(SessionsUpdateModel data);
}