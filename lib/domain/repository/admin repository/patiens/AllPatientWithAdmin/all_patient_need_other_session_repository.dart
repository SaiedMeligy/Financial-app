import 'package:dio/dio.dart';

import '../../../../entities/AllPatientModel.dart';

abstract class AllPatientWithAdminNeedOtherSessionRepository{
  Future<Response> getAllPatientWithAdminNeedOtherSession(AllPatientModel patientModel);
}