import 'package:dio/dio.dart';

import '../../../../../domain/entities/AllPatientModel.dart';

abstract class AllPatientsWithAdminDataSource {

  Future<Response> getAllPatientsWithAdmin(AllPatientModel patientModel,{int page = 1, int per_page = 20,String searchQuery = ''});
}