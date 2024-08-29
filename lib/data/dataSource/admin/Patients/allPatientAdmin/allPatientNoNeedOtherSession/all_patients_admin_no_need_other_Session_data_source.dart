
import 'package:dio/dio.dart';

import '../../../../../../domain/entities/AllPatientModel.dart';

abstract class AllPatientsWithAdminNoNeedOtherSessionDataSource {

  Future<Response> getAllPatientsWithAdminNoNeedOtherSession(AllPatientModel patientModel);
}