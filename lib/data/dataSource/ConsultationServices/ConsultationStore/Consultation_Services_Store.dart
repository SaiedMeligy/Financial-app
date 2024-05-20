import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';

abstract class ConsultationStoreDataSource{
  Future<Response> addConsultationStore(ConsultationStore consultationStore);
  }
