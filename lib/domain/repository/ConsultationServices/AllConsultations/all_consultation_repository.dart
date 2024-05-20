import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

abstract class AllConsultationRepository{
  Future<Response> getAllConsultations(ConsultationModel consultationViewModel);
}