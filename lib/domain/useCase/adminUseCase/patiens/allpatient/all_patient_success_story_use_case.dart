import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../repository/admin repository/patiens/AllPatientWithAdmin/all_patient_success_story_repository.dart';


class AllPatientWithAdminSuccessStoryUseCase{

  final AllPatientWithAdminSuccessStoryRepository allPatientRepository;

  AllPatientWithAdminSuccessStoryUseCase( this.allPatientRepository);

  Future<Response> execute(AllPatientModel patientModel){
    return allPatientRepository.getAllPatientWithAdminSuccessStory(patientModel);
  }
}