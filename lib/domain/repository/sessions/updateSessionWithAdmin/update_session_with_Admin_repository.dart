import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AddSessionModel.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';

abstract class UpdateSessionWithAdminRepository{
  Future<Response> updateSession(SessionsUpdateModel data);
}