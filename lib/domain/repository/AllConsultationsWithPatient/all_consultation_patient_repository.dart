import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

abstract class AllConsultationPatientRepository{
  Future<Response> getAllConsultationPatient(ConsultationModel consultationViewModel);
}