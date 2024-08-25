
import 'package:dio/dio.dart';

import '../../../../../../domain/entities/AllPatientModel.dart';

abstract class AllPatientsWithAdminNeedOtherSessionDataSource {

  Future<Response> getAllPatientsWithAdminNeedOtherSession(AllPatientModel patientModel);
}