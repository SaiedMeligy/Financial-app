import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/SessionUpdateModel.dart';

abstract class UpdateEvaluationSessionDataSource{
  Future<Response> updateEvaluationSession(int id,int evaluation);
}