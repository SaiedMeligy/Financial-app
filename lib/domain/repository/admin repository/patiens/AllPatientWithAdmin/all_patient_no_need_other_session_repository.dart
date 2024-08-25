import 'package:dio/dio.dart';

import '../../../../entities/AllPatientModel.dart';

abstract class AllPatientWithAdminNoNeedOtherSessionRepository{
  Future<Response> getAllPatientWithAdminNoNeedOtherSession(AllPatientModel patientModel);
}