import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/data/dataSource/ConsultationServices/AllConsultation/all_consultation_data_source.dart';
import 'package:experts_app/data/dataSource/ConsultationServices/AllConsultation/consultation_data_source_imp.dart';
import 'package:experts_app/data/repository_imp/all_Consultation_repository_imp.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/domain/useCase/ConsultationServices/allConsultation/all_consultation_use_case.dart';
import 'package:experts_app/features/homeAdmin/Consulting%20service/All%20Consultation/manager/states.dart';

import '../../../../../domain/repository/ConsultationServices/AllConsultations/all_consultation_repository.dart';

class AllConsultationCubit extends Cubit<AllConsultationStates> {
  AllConsultationCubit() : super(LoadingAllConsultations());

  late AllConsultationUseCase allConsultationUseCase;
  late AllConsultationRepository allConsultationRepository;
  late AllConsultationDataSource allConsultationDataSource;



  Future<void> getAllConsultations() async {
    WebServices service = WebServices();
    allConsultationDataSource = AllConsultationDataSourceImp(service.freeDio);
    allConsultationRepository =
        AllConsultationRepositoryImp(allConsultationDataSource);
    allConsultationUseCase = AllConsultationUseCase(allConsultationRepository);
    emit(LoadingAllConsultations());
    try {
      var result = await allConsultationUseCase.execute(
          ConsultationModel());
      print('API Response: ${result.data}');

      final data = ConsultationModel.fromJson(result.data);

      if (data.consultationServices != null) {
        emit(SuccessAllConsultations(data.consultationServices!));
      } else {
        emit(ErrorAllConsultations("No consultation services found"));
      }
    } catch (error) {
      emit(ErrorAllConsultations(error.toString()));
    }
  }




}