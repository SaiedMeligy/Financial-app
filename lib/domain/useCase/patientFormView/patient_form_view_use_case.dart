import 'package:dio/dio.dart';
import 'package:experts_app/domain/repository/patientNationalIdRepository/patient_nationalId_repository.dart';

import '../../repository/patientFormViewRepository/patient_form_view_repository.dart';

class PatientFormViewUseCase {
  final PatientFormViewRepository patientFormViewRepository;
  PatientFormViewUseCase(this.patientFormViewRepository);
  Future<Response> execute(int patientId)async{
    return await patientFormViewRepository.getPatientFormView(patientId);
  }
  }