import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';
import 'package:experts_app/domain/repository/ConsultationServices/updateConsultation/update_consultation_repository.dart';

import '../../../repository/ConsultationServices/ConsultationStore/consultation_store_repository.dart';
import '../../../repository/ConsultationServices/deleteConsultation/delete_consultation_repository.dart';


class DeleteConsultationUseCase{
  final DeleteConsultationRepository deleteConsultationRepository;
  DeleteConsultationUseCase(this.deleteConsultationRepository);

  Future<Response> execute(int id)async{

    return await deleteConsultationRepository.deleteConsultation(id);
  }
}