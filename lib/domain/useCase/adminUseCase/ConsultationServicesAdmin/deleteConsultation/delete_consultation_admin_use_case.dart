import 'package:dio/dio.dart';

import '../../../../repository/admin repository/ConsultationServicesAdmin/deleteConsultation/delete_consultation_admin_repository.dart';


class DeleteConsultationAdminUseCase{
  final DeleteConsultationAdminRepository deleteConsultationRepository;
  DeleteConsultationAdminUseCase(this.deleteConsultationRepository);

  Future<Response> execute(int id)async{

    return await deleteConsultationRepository.deleteConsultationAdmin(id);
  }
}