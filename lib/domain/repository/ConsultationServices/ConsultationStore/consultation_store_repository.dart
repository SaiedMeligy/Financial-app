import 'package:dio/dio.dart';

import '../../../entities/Consultation_store.dart';

abstract class ConsultationStoreRepository{
  Future<Response> addConsultationStore(ConsultationStore consultationStore);
}