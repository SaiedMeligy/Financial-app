import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';

abstract class DeleteConsultationDataSource{
  Future<Response> deleteConsultation(int id);
  }
