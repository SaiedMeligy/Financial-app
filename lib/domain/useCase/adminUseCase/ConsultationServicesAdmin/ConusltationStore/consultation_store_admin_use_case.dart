import 'package:dio/dio.dart';

import '../../../../entities/Consultation_store.dart';
import '../../../../repository/admin repository/ConsultationServicesAdmin/ConsultationStore/consultation_store_admin_repository.dart';



class ConsultationStoreAdminUseCase{
  final ConsultationStoreAdminRepository consultationStoreRepository;
  ConsultationStoreAdminUseCase(this.consultationStoreRepository);

  Future<Response> execute(ConsultationStore consultationStore)async{

    return await consultationStoreRepository.addConsultationStoreAdmin(consultationStore);
  }
}