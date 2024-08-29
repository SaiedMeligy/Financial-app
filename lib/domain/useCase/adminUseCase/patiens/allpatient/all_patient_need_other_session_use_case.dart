import 'package:dio/dio.dart';
import 'package:experts_app/domain/entities/AllPatientModel.dart';

import '../../../../repository/admin repository/patiens/AllPatientWithAdmin/all_patient_need_other_session_repository.dart';


class AllPatientWithAdminNeedOtherSessionUseCase{

  final AllPatientWithAdminNeedOtherSessionRepository allPatientRepository;

  AllPatientWithAdminNeedOtherSessionUseCase( this.allPatientRepository);

  Future<Response> execute(AllPatientModel patientModel){
    return allPatientRepository.getAllPatientWithAdminNeedOtherSession(patientModel);
  }
}