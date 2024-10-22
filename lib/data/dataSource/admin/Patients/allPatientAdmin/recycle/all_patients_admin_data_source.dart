import 'package:dio/dio.dart';

import '../../../../../../domain/entities/AllPatientModel.dart';


abstract class AllPatientsRecycleWithAdminDataSource {

  Future<Response> getAllPatientsRecycleWithAdmin(AllPatientModel patientModel,int recycle,{int page =1,int per_page =20});
}