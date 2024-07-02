import 'package:dio/dio.dart';

abstract class PatientFormViewWithAdminRepository{
  Future<Response> getPatientFormViewWithAdmin(int patientId);
}