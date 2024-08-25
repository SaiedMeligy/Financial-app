import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:experts_app/core/Services/web_services.dart';
import 'package:experts_app/data/dataSource/ConsultationServices/AllConsultation/all_consultation_data_source.dart';
import 'package:experts_app/data/dataSource/ConsultationServices/AllConsultation/consultation_data_source_imp.dart';
import 'package:experts_app/data/repository_imp/all_Consultation_repository_imp.dart';
import 'package:experts_app/domain/entities/ConsultationViewModel.dart';
import 'package:experts_app/features/homeAdmin/Consulting%20service/All%20Consultation/manager/states.dart';

import '../../../../../data/dataSource/AllConsultationWithPatient/all_consultation_patient_data_source.dart';
import '../../../../../data/dataSource/AllConsultationWithPatient/consultation_patient_data_source_imp.dart';
import '../../../../../data/dataSource/admin/ConsultationServicesAdmin/AllConsultation/all_consultation_admin_data_source.dart';
import '../../../../../data/dataSource/admin/ConsultationServicesAdmin/AllConsultation/consultation_admin_data_source_imp.dart';
import '../../../../../data/repository_imp/admin_repository_imp/ConsultationAdmin/all_Consultation_admin_repository_imp.dart';
import '../../../../../data/repository_imp/all_Consultation_patient_repository_imp.dart';
import '../../../../../domain/repository/AllConsultationsWithPatient/all_consultation_patient_repository.dart';
import '../../../../../domain/repository/ConsultationServices/AllConsultations/all_consultation_repository.dart';
import '../../../../../domain/repository/admin repository/ConsultationServicesAdmin/AllConsultations/all_consultation_admin_repository.dart';
import '../../../../../domain/useCase/ConsultationServices/allConsultation/all_consultation_use_case.dart';
import '../../../../../domain/useCase/adminUseCase/ConsultationServicesAdmin/allConsultation/all_consultation_admin_use_case.dart';
import '../../../../../domain/useCase/allConsultationWithPatient/all_consultation_patient_use_case.dart';

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


  late AllConsultationAdminUseCase allConsultationAdminUseCase;
  late AllConsultationAdminRepository allConsultationAdminRepository;
  late AllConsultationAdminDataSource allConsultationAdminDataSource;



  Future<void> getAllConsultationsAdmin() async {
    WebServices service = WebServices();
    allConsultationAdminDataSource = AllConsultationAdminDataSourceImp(service.freeDio);
    allConsultationAdminRepository = AllConsultationAdminRepositoryImp(allConsultationAdminDataSource);
    allConsultationAdminUseCase = AllConsultationAdminUseCase(allConsultationAdminRepository);
    emit(LoadingAllConsultations());
    try {
      var result = await allConsultationAdminUseCase.execute(
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

  late AllConsultationPatientUseCase allConsultationPatientUseCase;
  late AllConsultationPatientRepository allConsultationPatientRepository;
  late AllConsultationPatientDataSource allConsultationPatientDataSource;



  Future<void> getAllConsultationsPatient() async {
    WebServices service = WebServices();
    allConsultationPatientDataSource = AllConsultationPatientDataSourceImp(service.freeDio);
    allConsultationPatientRepository = AllConsultationPatientRepositoryImp(allConsultationPatientDataSource);
    allConsultationPatientUseCase = AllConsultationPatientUseCase(allConsultationPatientRepository);
    emit(LoadingAllConsultations());
    try {
      var result = await allConsultationPatientUseCase.execute(
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