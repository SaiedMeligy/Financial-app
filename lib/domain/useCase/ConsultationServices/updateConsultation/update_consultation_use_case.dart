import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';
import 'package:experts_app/domain/repository/ConsultationServices/updateConsultation/update_consultation_repository.dart';

import '../../../repository/ConsultationServices/ConsultationStore/consultation_store_repository.dart';


class UpdateConsultationUseCase{
  final UpdateConsultationRepository updateConsultationRepository;
  UpdateConsultationUseCase(this.updateConsultationRepository);

  Future<Response> execute(int id,String name ,String description)async{

    return await updateConsultationRepository.updateConsultation(id,name,description);
  }
}