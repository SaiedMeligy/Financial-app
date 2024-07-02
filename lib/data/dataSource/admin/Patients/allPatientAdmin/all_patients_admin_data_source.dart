import 'package:dio/dio.dart';

import '../../../../../domain/entities/AllPatientModel.dart';

abstract class AllPatientsWithAdminDataSource {

  Future<Response> getAllPatientsWithAdmin(AllPatientModel patientModel);
}