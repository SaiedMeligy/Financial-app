import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../repository/admin repository/patiens/AllPatientWithAdmin/all_patient_recycle_repository.dart';


class AllPatientRecycleWithAdminUseCase{

  final AllPatientRecycleWithAdminRepository allPatientRecycleRepository;

  AllPatientRecycleWithAdminUseCase( this.allPatientRecycleRepository);

  Future<Response> execute(AllPatientModel patientModel,int recycle){
    return allPatientRecycleRepository.getAllPatientRecycleWithAdmin(patientModel,recycle);
  }
}