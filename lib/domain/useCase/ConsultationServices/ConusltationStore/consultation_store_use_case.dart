import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';

import '../../../repository/ConsultationServices/ConsultationStore/consultation_store_repository.dart';


class ConsultationStoreUseCase{
  final ConsultationStoreRepository consultationStoreRepository;
  ConsultationStoreUseCase(this.consultationStoreRepository);

  Future<Response> execute(ConsultationStore consultationStore)async{

    return await consultationStoreRepository.addConsultationStore(consultationStore);
  }
}