import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

import '../../repository/AllConsultationsWithPatient/all_consultation_patient_repository.dart';


class AllConsultationPatientUseCase{

  final AllConsultationPatientRepository allConsultationRepository;

  AllConsultationPatientUseCase( this.allConsultationRepository);

  Future<Response> execute(ConsultationModel consultationViewModel){
    return allConsultationRepository.getAllConsultationPatient(consultationViewModel);
  }
}