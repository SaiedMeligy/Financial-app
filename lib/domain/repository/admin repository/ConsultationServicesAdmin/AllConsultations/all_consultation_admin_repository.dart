import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

abstract class AllConsultationAdminRepository{
  Future<Response> getAllConsultationAdmin(ConsultationModel consultationViewModel);
}