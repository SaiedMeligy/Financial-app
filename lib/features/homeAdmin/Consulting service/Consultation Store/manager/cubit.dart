import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/data/repository_imp/consultation_store_repository_imp.dart';
import 'package:experts_app/domain/entities/Consultation_store.dart';
import 'package:experts_app/features/homeAdmin/Consulting%20service/Consultation%20Store/manager/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../data/dataSource/ConsultationServices/ConsultationStore/Consultation_Services_Store.dart';
import '../../../../../data/dataSource/ConsultationServices/ConsultationStore/Consultation_Services_Store_imp.dart';
import '../../../../../domain/repository/ConsultationServices/ConsultationStore/consultation_store_repository.dart';
import '../../../../../domain/useCase/ConsultationServices/ConusltationStore/consultation_store_use_case.dart';

class ConsultationStoreCubit extends Cubit<ConsultationStoreStates>{
  ConsultationStoreCubit() : super(LoadingConsultationState());
  late ConsultationStoreUseCase consultationStoreUseCase;
  late ConsultationStoreRepository consultationStoreRepository;
  late ConsultationStoreDataSource dataSource;

  Future<Response> addConsultationStore(ConsultationStore consultationStore)async{
     WebServices service = WebServices();
    dataSource = ConsultationStoreDataSourceImp(service.freeDio);
    consultationStoreRepository = ConsultationStoreRepositoryImp(dataSource);
    consultationStoreUseCase = ConsultationStoreUseCase(consultationStoreRepository);
    final result = await consultationStoreUseCase.execute(consultationStore);
    return result;
  }
}