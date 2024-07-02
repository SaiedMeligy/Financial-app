import 'package:dio/dio.dart';

abstract class PatientFormViewWithAdminDataSource{
  Future<Response> getPatientFormWithAdmin(int patientId);
}