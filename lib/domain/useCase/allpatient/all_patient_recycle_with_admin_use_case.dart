import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../repository/AllPatient/all_patient_recycle_repository.dart';
import '../../repository/AllPatient/all_patient_repository.dart';

class AllPatientRecycleUseCase{

  final AllPatientRecycleRepository allPatientRecycleRepository;

  AllPatientRecycleUseCase( this.allPatientRecycleRepository);

  Future<Response> execute(AllPatientModel patientModel,int recycle){
    return allPatientRecycleRepository.getAllPatientRecycle(patientModel,recycle);
  }
}