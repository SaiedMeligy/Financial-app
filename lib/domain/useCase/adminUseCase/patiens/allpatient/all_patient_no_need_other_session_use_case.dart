import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../repository/admin repository/patiens/AllPatientWithAdmin/all_patient_no_need_other_session_repository.dart';


class AllPatientWithAdminNoNeedOtherSessionUseCase{

  final AllPatientWithAdminNoNeedOtherSessionRepository allPatientRepository;

  AllPatientWithAdminNoNeedOtherSessionUseCase( this.allPatientRepository);

  Future<Response> execute(AllPatientModel patientModel){
    return allPatientRepository.getAllPatientWithAdminNoNeedOtherSession(patientModel);
  }
}