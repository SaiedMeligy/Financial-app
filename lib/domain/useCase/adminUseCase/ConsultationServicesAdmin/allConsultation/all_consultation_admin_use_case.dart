import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';

import '../../../../repository/admin repository/ConsultationServicesAdmin/AllConsultations/all_consultation_admin_repository.dart';

class AllConsultationAdminUseCase{

  final AllConsultationAdminRepository allConsultationRepository;

  AllConsultationAdminUseCase( this.allConsultationRepository);

  Future<Response> execute(ConsultationModel consultationViewModel){
    return allConsultationRepository.getAllConsultationAdmin(consultationViewModel);
  }
}