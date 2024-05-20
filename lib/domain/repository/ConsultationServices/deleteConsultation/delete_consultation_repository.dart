import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

import '../../../entities/Consultation_store.dart';

abstract class DeleteConsultationRepository{
  Future<Response> deleteConsultation(int id);
}