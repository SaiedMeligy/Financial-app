import 'package:dio/dio.dart';

import '../../../../entities/AllPatientModel.dart';

abstract class AllPatientWithAdminSuccessStoryRepository{
  Future<Response> getAllPatientWithAdminSuccessStory(AllPatientModel patientModel);
}