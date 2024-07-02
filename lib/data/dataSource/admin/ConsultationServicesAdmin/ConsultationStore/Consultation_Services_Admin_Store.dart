import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';

abstract class ConsultationStoreAdminDataSource{
  Future<Response> addConsultationStoreAdmin(ConsultationStore consultationStore);
  }
