import 'package:dio/dio.dart';
import 'package:experts_app/data/dataSource/patientNationalId/patient_nationalId_data_source.dart';

abstract class PatientNationalIdRepository{
  Future<Response> getPatientNationalId(String nationalId);
}