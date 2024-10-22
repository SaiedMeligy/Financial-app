
import 'package:dio/dio.dart';

import '../../entities/AllPatientModel.dart';

abstract class AllPatientRecycleWithAdminRepository{
  Future<Response> getAllPatientRecycleWithAdmin(AllPatientModel patientModel,int recycle,{int page =1,int per_page=20});
}