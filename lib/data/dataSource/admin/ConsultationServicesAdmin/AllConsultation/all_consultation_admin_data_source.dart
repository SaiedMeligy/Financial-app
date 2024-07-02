import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

abstract class AllConsultationAdminDataSource {

  Future<Response> getAllConsultationAdmin(ConsultationModel consultationViewModel);
}