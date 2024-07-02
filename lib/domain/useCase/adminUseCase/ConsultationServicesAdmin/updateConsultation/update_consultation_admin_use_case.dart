import 'package:dio/dio.dart';

import '../../../../repository/admin repository/ConsultationServicesAdmin/updateConsultation/update_consultation_admin_repository.dart';


class UpdateConsultationAdminUseCase{
  final UpdateConsultationAdminRepository updateConsultationRepository;
  UpdateConsultationAdminUseCase(this.updateConsultationRepository);

  Future<Response> execute(int id,String name ,String description)async{

    return await updateConsultationRepository.updateConsultationAdmin(id,name,description);
  }
}