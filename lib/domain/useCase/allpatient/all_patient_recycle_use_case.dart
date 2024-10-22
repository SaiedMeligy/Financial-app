import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../repository/AllPatient/all_patient_recycle_repository.dart';
import '../../repository/AllPatient/all_patient_repository.dart';

class AllPatientRecycleUseCase{

  final AllPatientRecycleRepository allPatientRecycleRepository;

  AllPatientRecycleUseCase( this.allPatientRecycleRepository);

  Future<Response> execute(AllPatientModel patientModel,int recycle,{int page =1,int per_page=20}){
    return allPatientRecycleRepository.getAllPatientRecycle(patientModel,recycle,page: page,per_page: per_page);
  }
}