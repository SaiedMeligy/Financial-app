import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AdviceMode.dart';
import 'package:experts_app/domain/entities/AllSessionModel.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

abstract class AllSessionDataSource {

  Future<Response> getAllSession(AllSessionModel sessionModel);
}