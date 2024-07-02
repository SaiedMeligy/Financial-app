import 'package:dio/dio.dart';

import '../../../../entities/Consultation_store.dart';


abstract class ConsultationStoreAdminRepository{
  Future<Response> addConsultationStoreAdmin(ConsultationStore consultationStore);
}