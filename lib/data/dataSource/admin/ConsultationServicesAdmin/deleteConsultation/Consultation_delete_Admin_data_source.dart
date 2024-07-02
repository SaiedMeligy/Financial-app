import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';

abstract class DeleteConsultationAdminDataSource{
  Future<Response> deleteConsultationAdmin(int id);
  }
