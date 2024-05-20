import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

abstract class AllConsultationDataSource {

  Future<Response> getAllConsultation(ConsultationModel consultationViewModel);
}