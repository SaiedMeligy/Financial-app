import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllAdvisorsModel.dart';
abstract class AllAdvisorDataSource {

  Future<Response> getAllAdvisor(AllAdvisorsModel advisorModel);
}