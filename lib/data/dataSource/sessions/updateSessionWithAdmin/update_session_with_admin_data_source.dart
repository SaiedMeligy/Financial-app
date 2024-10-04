import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';

abstract class UpdateSessionWithAdminDataSource{
  Future<Response> updateSession(SessionsUpdateModel data);
}