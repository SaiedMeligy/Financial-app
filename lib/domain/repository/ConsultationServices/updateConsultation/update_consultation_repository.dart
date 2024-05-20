import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

import '../../../entities/Consultation_store.dart';

abstract class UpdateConsultationRepository{
  Future<Response> updateConsultation(int id,String name,String description);
}