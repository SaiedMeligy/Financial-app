import 'package:dio/dio.dart';

import '../../../../repository/admin repository/form/patientFormViewRepository/patient_form_view_repository.dart';


class PatientFormViewWithAdminUseCase {
  final PatientFormViewWithAdminRepository patientFormViewRepository;
  PatientFormViewWithAdminUseCase(this.patientFormViewRepository);
  Future<Response> execute(int patientId)async{
    return await patientFormViewRepository.getPatientFormViewWithAdmin(patientId);
  }
  }