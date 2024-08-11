import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';

abstract class AllAdvicesDataSource {

  Future<Response> getAllAdvices(AdviceModel adviceModel);
}