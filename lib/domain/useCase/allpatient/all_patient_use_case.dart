import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../repository/AllPatient/all_patient_repository.dart';

class AllPatientUseCase{

  final AllPatientRepository allPatientRepository;

  AllPatientUseCase( this.allPatientRepository);

  Future<Response> execute(AllPatientModel patientModel){
    return allPatientRepository.getAllPatient(patientModel);
  }
}