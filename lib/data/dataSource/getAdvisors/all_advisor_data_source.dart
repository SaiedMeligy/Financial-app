import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';
import 'package:experts_app/domain/entities/AllAdvisorsModel.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

abstract class AllAdvisorDataSource {

  Future<Response> getAllAdvisor(AllAdvisorsModel advisorModel);
}