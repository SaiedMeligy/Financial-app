import 'package:dio/dio.dart';
import 'package:experts_app/domain/repository/patientNationalIdRepository/patient_nationalId_repository.dart';

class PatientNationalIdUseCase {
  final PatientNationalIdRepository patientNationalIdRepository;
  PatientNationalIdUseCase(this.patientNationalIdRepository);
  Future<Response> execute(String nationalId)async{
    return await patientNationalIdRepository.getPatientNationalId(nationalId);
  }
  }