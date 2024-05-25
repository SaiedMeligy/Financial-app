import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

abstract class AllAdvicesDataSource {

  Future<Response> getAllAdvices(AdviceModel adviceModel);
}