import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/domain/repository/ConsultationServices/AllConsultations/all_consultation_repository.dart';

class AllConsultationUseCase{

  final AllConsultationRepository allConsultationRepository;

  AllConsultationUseCase( this.allConsultationRepository);

  Future<Response> execute(ConsultationModel consultationViewModel){
    return allConsultationRepository.getAllConsultations(consultationViewModel);
  }
}