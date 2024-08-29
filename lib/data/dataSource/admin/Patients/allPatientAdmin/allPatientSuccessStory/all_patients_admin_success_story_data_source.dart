
import 'package:dio/dio.dart';

import '../../../../../../domain/entities/AllPatientModel.dart';

abstract class AllPatientsWithAdminSuccessStoryDataSource {

  Future<Response> getAllPatientsWithAdminSuccessStory(AllPatientModel patientModel);
}