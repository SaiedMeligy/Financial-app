import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../repository/AllPatient/all_patient_repository.dart';

class AllPatientUseCase{

  final AllPatientRepository allPatientRepository;

  AllPatientUseCase( this.allPatientRepository);


  Future<Response> execute(AllPatientModel patientModel, {int page = 1, int per_page = 20,String searchQuery=''}){
    return allPatientRepository.getAllPatient(patientModel,page: page,per_page: per_page,searchQuery:searchQuery);
  }
}