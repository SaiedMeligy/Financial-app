import 'package:dio/dio.dart';

abstract class PatientFormViewDataSource{
  Future<Response> getPatientForm(int patientId);
}