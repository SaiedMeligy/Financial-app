
import 'package:dio/dio.dart';

import '../../entities/AllPatientModel.dart';

abstract class AllPatientRecycleWithAdminRepository{
  Future<Response> getAllPatientRecycleWithAdmin(AllPatientModel patientModel,int recycle);
}