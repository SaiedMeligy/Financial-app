import 'package:dio/dio.dart';

import '../../../core/config/constants.dart';
import '../../../domain/entities/AllPatientModel.dart';

abstract class AllPatientsDataSource {

  Future<Response> getAllPatients(AllPatientModel patientModel, {int page = 1, int per_page = 20,String searchQuery=''});
}