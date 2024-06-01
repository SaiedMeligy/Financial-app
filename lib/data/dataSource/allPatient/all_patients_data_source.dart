import 'package:dio/dio.dart';

import '../../../domain/entities/AllPatientModel.dart';

abstract class AllPatientsDataSource {

  Future<Response> getAllPatients(AllPatientModel patientModel);
}